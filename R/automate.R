library(dplyr)
df <- read.csv('shiny/djs.tsv',sep='\t', stringsAsFactors = F)

apply(df,1,function(x){
  if(dir.exists(paste('data/', x['dj'], sep='')) == F){
    print(x['dj'])
    dir.create(paste('data/', x['dj'], sep=''))
    dir.create(paste('shiny/data/', x['dj'], sep=''))
  }
    cmd.run <- paste('sh process_dj.sh', x['dj'], x['border.width'], sep=' ')
    print(cmd.run)
    system(cmd.run)
  })
