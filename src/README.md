# Hello welcome to my json reader and manipulator app!

## About
This application reads different json files that have requests for changes in a spotify json file and adds those chages to a new.json file

### Change types are as follows 
- Add an existing song to an existing playlist(Add_Song_To_Playlist)
- Add a new playlist for an existing user; the playlist should contain at least one existing song(Add_New_Playlist_For_Existing_User)
- Remove an existing playlist(Remove_Playlist)

## What does Journey do?

 - Users can create accounts
 - Sign into account
 - View all journals or select by title
 - Users can edit the title or notes of their journal 
 - They is also an admin panel where the admin can delete users in the system and edit their notes and titles(Admin has complete control)

##### Ruby Gems
```sh
gem "json"
gem 'tty-prompt'
```
```sh
$ bundle install
```
##### Run Program
```sh
$ ruby ./run.rb
```

## User Manual 
#### 1. Select Json Change
- I wanted to make it easy to select different json type changes so I added a command line interface to select the json files change types in the document 
- use UP and DOWN keys to move to a choice on the command line
- ENTER key selects a file type from the command line

#### 2. View Change
- Change is viewable in the new.json file

### Scalability 

##### 1. Progress Bar
- If I wanted to scale this to large json files I would want to have a progress bar to show the user the progress of the file upload
##### 2. Stages
- I would also want to show the different stages of the change process that I am in 

### Coding Choices 

##### 1. 
- If I wanted to scale this to large json files I would want to have a progress bar to show the user the progress of the file upload
- I would also want to show the different stages of the json manipulation process that I am in 




