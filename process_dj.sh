#!/bin/sh
python py/GetPlaylists.py $1
Rscript R/distinct.playlist.R $1
python py/GetSongs.py $1 $2
python py/nltk_playlist.py $1
python py/GetComments.py $1
Rscript R/create.data.sets.R $1

