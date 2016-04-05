# WFMU_playlists
If you've ever wanted to create a WFMU playlist, this may just be the project for you!

###Requirements
Run `sudo pip install -r requirements.txt` to get all the python libraries necessary to run the scripts below.


###Steps
The DJ's are listed in a tab-delimited file (`shiny/djs.tsv`). Run `Rscript R/automation.R` to scrape DJ information and compile aggregations and visualizations for all those DJ's.

If you ever need to re-scrape a DJ's data, just find that DJ's two letter code and run `rm -r data/{code}` and `rm -r shiny/data/{code}`. That removes that DJ's data. Then re-run `Rscript R/automation.R` again. This will only process those DJ's who do not have data in the data directories.

The `shiny/` directory also contains a Shiny R app that can be hosted. Learn more about [Shiny](http://shiny.rstudio.com/).

