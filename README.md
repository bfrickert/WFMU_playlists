# WFMU_playlists
If you've ever wanted to create a WFMU playlist, this may just be the project for you!

###Requirements
Run `sudo pip install -r requirements.txt` to get all the python libraries necessary to run the scripts below.

For each DJ, find his or her initials from his or her playlist page. Then click on a playlist to see if her or she uses borders for the table that displays the songs within his or her playlists (1 for yes, 0 for no). Then run the following:

1. `mkdir data\{initials}`
2. `mkdir shiny\data\{initials}`
3. `./process_dj.sh {initials} {border_width}`
