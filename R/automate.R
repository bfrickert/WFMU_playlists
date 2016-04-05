library(dplyr)
df <- read.csv('djs.tsv',sep='\t', stringsAsFactors = F)

apply(df,1,function(x){
  if(dir.exists(paste('data/', x['dj'], sep='')) == F){
    print(x['dj'])
    dir.create(paste('data/', x['dj'], sep=''))
    dir.create(paste('shiny/data/', x['dj'], sep=''))
    cmd.run <- paste('/home/ubuntu/WFMU_playlists/process_dj.sh', x['dj'], x['border.width'], sep=' ')
    system(cmd.run)
  }
  })
