require(plyr)
library(lubridate)
library(lattice)
library(dplyr)
songs <- read.csv('data/ken_songs.tsv', sep='\t')
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


#elakelaiset songs
elakelaiset <- songs[ which(songs$artist == 'elakelaiset'), ]

# noonday underground
noonday <- songs[ which(songs$artist == 'noonday underground'), ]
cnt_noon <- ddply(noonday, .(noonday$artist, noonday$song), nrow)


unknown <- songs[ which(songs$artist == 'unknown'), ]
cnt_unknown <- ddply(unknown, .(unknown$artist, unknown$song), nrow)
names(cnt_unknown) <- c("artist", "songs", "count")
cnt_unknown <- cnt_unknown[order(cnt_unknown$count, decreasing=TRUE),]

# Count of elakelaiset songs -- a lot of misspellings
cnt_ek <- ddply(elakelaiset, .(elakelaiset$song), nrow)

jpeg("viz/mostplayed.jpeg")
#install.packages("ggplot2")
# Most played Artists
library(ggplot2)
c <- ggplot(head(cnt_artists[ which(cnt_artists$artist != 'fail'), ], n=10), 
              aes(fill=artist, x=artist, y=count))
c + geom_bar(stat = "identity") + coord_flip()
dev.off()

songs$year <- year(mdy(as.character(songs$date)))
head(songs)

require(data.table)
d <- data.table(cnt_artists, key="year")
d <- d[, head(.SD, 10), by=year]

barchart(as.integer(count) ~ as.character(artist) | factor(year), data=d,
           main="barchart",
           scales=list(x=list(rot=90))
           )

