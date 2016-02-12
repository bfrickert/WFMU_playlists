songs <- read.csv('C:/dev/wfmu/data/ken_songs.tsv', sep='\t')

library(dplyr)
dat_max <- songs %>% group_by(date) %>% filter(row_number(X)==n())

maxes <- select(dat_max, date, X)

songs$num_songs <- sapply(songs$date, function(x) {
  return(filter(maxes, date==x)$X)
})

songs$fraction <- songs$X/songs$num_songs
songs$hour <- sapply(songs$fraction, function(x) {
  if (x <= 0.33) {return("First")}
  else if (x <= 0.66) {return("Second")}
  else {return("Third")}
})

write.table(songs, file="c:/dev/WFMU/data/songs_hour.tsv", sep="\t")