require(plyr)
library(lubridate)
library(lattice)
library(dplyr)
library(ggplot2)
library(plotly)
songs <- read.csv('data/shiny/IC/songs.tsv', sep='\t')
songs$artist <- tolower(songs$artist)
songs$song <- tolower(songs$song)

thes <- songs[grepl('^the ', tolower(songs$artist)),]
#remove 'the '
#the_songs <- songs[thes,]
stones2 <- songs[grepl('^the ', tolower(songs$artist)),]

songs <- within(songs, artist <- 
                  ifelse(grepl('^the ', tolower(songs$artist)), 
                         substr(songs$artist, 5, nchar(songs$artist)), 
                         songs$artist))

cnts_unqsongs <- ddply(songs,'artist',
              summarise,
              count = length(unique(song)))

cnts_unqsongs <- cnts_unqsongs[order(cnts_unqsongs$count, decreasing=TRUE),]

songs$year <- format(mdy(songs$date), '%Y')

songs.g <- group_by(select(songs, artist, year), artist, year)
cnt_artists <- dplyr::summarize(songs.g, cnt=n())
#cnt_artists <- ddply(select(songs, -date), .(songs$artist, songs$year, nrow))
names(cnt_artists) <- c("artist", "year","count")
cnt_artists <- cnt_artists[order(cnt_artists$count, decreasing=TRUE),]
cnt_artists <- filter(cnt_artists, artist != 'fail')

cnt_songs <- ddply(songs, .(songs$artist, songs$song), nrow)
names(cnt_songs) <- c("artist", "song", "count")
cnt_songs <- cnt_songs[order(cnt_songs$count, decreasing=TRUE),]

c <- ggplot(head(filter(cnts_unqsongs, artist != 'fail'), n=10), 
              aes(fill=artist, x=artist, y=count)) + 
  geom_bar(stat = "identity") + coord_flip() + ggtitle("Most Unique Songs Played by These Artists") +
  theme_bw()
c

songs$year <- year(mdy(as.character(songs$date)))
head(songs)

require(data.table)
d <- data.table(cnt_artists, key="year")
d <- d[, head(.SD, 10), by=year]

plot_ly(arrange(d, artist), x=artist, y=count, type='bar', color=year) %>%
  layout(showlegend=F)

playlist <- select(read.csv('/home/ubuntu/WFMU_playlists/shiny/data/KF/nltk_playlist.tsv', sep='\t', header = T, stringsAsFactors = F), -ind)
