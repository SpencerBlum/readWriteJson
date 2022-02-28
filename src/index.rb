require 'json'
require "tty-prompt"

class Cli
    def turn_json_to_hash(file_route)
        data_hash = {}
        file = File.read(file_route)
        data_hash = JSON.parse(file)
        return data_hash
    end

    def create_new_json(new_file_data) 
        File.open("../jsonFiles/new.json","w") do |f|
            f.puts JSON.pretty_generate(new_file_data)
        end
    end

    def add_id_to_array(item, newSongID)
        if !item['song_ids'].include?(newSongID)
            item['song_ids'].push(newSongID)
            return item['song_ids']
        end        
    end

    def add_new_song_to_playlist(newChange, spotifyJson)
        playLists = spotifyJson["playlists"]
        newPlaylist = []
        playLists.each do |item|
            if item["id"] == newChange["playlist_id"] then
                new_song_ids = add_id_to_array(item, item["id"])
                item["song_ids"] = new_song_ids
            end
            newPlaylist.push(item)
        end  
        spotifyJson["playlists"] = newPlaylist
        create_new_json(spotifyJson) 
    end

    def includes_songs(song_ids, spotifyJson)
        correct_count = 0
        song_ids.each do |song|
            spotifyJson["songs"].each do |loaded_songs| 
                if (loaded_songs["id"] == song)
                    correct_count = correct_count + 1 
                end
            end
        end
        if correct_count == song_ids.length()
            return true
        end
        return false 
    end

    def add_new_playlist(newChange, spotifyJson) 

        spotifyJson["users"].each do |user|
            if user["id"] == newChange["user_id"]
                new_playlist = spotifyJson["playlists"]
                new_change_in_list = includes_songs(newChange["song_ids"], spotifyJson)
                if (new_change_in_list)
                    new_playlist_obj = {
                        "id": (spotifyJson["playlists"].length() + 1).to_s,
                        "owner_id":  newChange["user_id"],
                        "song_ids": [
                        newChange["song_ids"],
                        ]
                    }
                    new_playlist.push(new_playlist_obj)
                    spotifyJson["playlists"] = new_playlist
                    create_new_json(spotifyJson) 
                else 
                    puts 'song is not in the song list'
                end
            end
        end
    end

    def remove_playlist(newChange, spotifyJson)
        new_playlist = spotifyJson['playlists'].select {|playlist| playlist['id'] != newChange["playlist_id"] }
        spotifyJson["playlists"] = new_playlist
        create_new_json(spotifyJson) 
    end

    def run_console()
        prompt = TTY::Prompt.new
        changeFileType = prompt.select("Choose your file type change?", %w(addSong addNewPlaylist removePlaylist))
        newJson = turn_json_to_hash("../jsonFiles/#{changeFileType}.json")
        spotifyJson = turn_json_to_hash("../jsonFiles/spotify.json")
        change_type = newJson["change_type"]
        case change_type
        when 'Add_Song_To_Playlist'
            puts 'add song'
            add_new_song_to_playlist(newJson, spotifyJson)
        when 'Add_New_Playlist_For_Existing_User'
            puts 'add playList'
            add_new_playlist(newJson, spotifyJson)
        when 'Remove_Playlist'
            puts 'remove playList'
            remove_playlist(newJson, spotifyJson)
        else
        "Error: change type is invalid (#{change_type})"
        end
    end

end
