suppressMessages(library(plyr))
suppressMessages(library(dplyr))
suppressMessages(library(tm))
suppressMessages(library(SnowballC))
suppressMessages(library(wordcloud))
suppressMessages(library(lubridate))

args = commandArgs(trailingOnly=TRUE)
print("Creating data sets........")

clean.songs <- function(x){
  return(within(x, artist <- 
                  ifelse(grepl('^the ', tolower(x$artist)), 
                         substr(x$artist, 5, nchar(x$artist)), 
                         x$artist)))
}

getSongs <- function(name){
  songs <- read.csv(paste('data/', name, '/songs.tsv',sep=''), sep='\t')
  songs$artist <- tolower(songs$artist)
  songs$song <- tolower(songs$song)
  
  songs <- filter(songs, artist != 'fail')
  return(clean.songs(songs))
}

unq_songs <- function(x){
  cnts_unqsongs <- ddply(x,'artist',
                         summarise,
                         count = length(unique(song)))
  cnts_unqsongs <- cnts_unqsongs[order(cnts_unqsongs$count, decreasing=TRUE),]
  return(cnts_unqsongs)
}

cnt_artists <- function(x){
  x$year <- year(mdy(as.character(x$date)))
  songs.g <- group_by(select(x, artist, year), artist, year)
  cnt_artists <- dplyr::summarize(songs.g, cnt=n())
  names(cnt_artists) <- c("artist", "year","count")
  cnt_artists <- cnt_artists[order(cnt_artists$count, decreasing=TRUE),]
  
  return(arrange(cnt_artists, artist))
}

cnt_songs <- function(x){
  
  cnt_songs <- ddply(x, .(x$artist, x$song), nrow)
  names(cnt_songs) <- c("artist", "song", "count")
  cnt_songs <- cnt_songs[order(cnt_songs$count, decreasing=TRUE),]
  return(cnt_songs)
}

suppressMessages(require(data.table))
top.10.artists.year <- function(x){
  d <- data.table(x, key="year")
  d <- d[, head(.SD, 10), by=year]
  d <- filter(d, count>2)
  return(d)
}

word.cloud <- function(x) {
  stop.words.df <- read.csv('data/stop.words.tsv', sep='\t',stringsAsFactors = F)
  comments <- read.csv(paste('data/',x, '/comments.txt', sep=''), stringsAsFactors = F, sep='\t',fill=T)
  corp <- Corpus(VectorSource(comments$X0))
  corp <- tm_map(corp,content_transformer(function(x) iconv(x, to='UTF-8', sub='byte')),
                     mc.cores=1)
  corp <- tm_map(corp, content_transformer(removeNumbers), lazy=T)
  corp <- tm_map(corp, content_transformer(tolower), lazy=T)
  corp <- tm_map(corp, content_transformer(removePunctuation), lazy=T)
  myStopwords <- c(stopwords('english'), "morning", "listening", "show", "album", "wfmu", "listeners",
                   "music", "radio", "hear", "playing", "listen", "sounds", "track", "sound", "record",
                   "also", "ive", "ill", "get", "youre", "everyone", "something", "play", "even",
                   "band", "playlist", stop.words.df$stop.word)
  corp <- tm_map(corp, content_transformer(removeWords), myStopwords)
  corp <- tm_map(corp, content_transformer(stemDocument), lazy=T)
  corp <- tm_map(corp, content_transformer(stripWhitespace), lazy=T)
  pal2 <- brewer.pal(8,"Set1")
  jpeg(paste('shiny/viz/wordcloud/',x,'.jpg', sep=''))
  wordcloud(corp, max.words = 100, random.order = FALSE, colors=pal2)
  suppressMessages(dev.off())
 }

process.dj <- function(x){
  songs <- getSongs(x)
   write.table(unq_songs(songs), paste('shiny/data/', x, '/unq_songs.tsv', sep=''), 
               sep='\t', row.names=F, quote=F)
   write.table(cnt_artists(songs), paste('shiny/data/', x, '/cnt_artists.tsv', sep=''), 
              sep='\t', row.names=F, quote=F)
   write.table(cnt_songs(songs), paste('shiny/data/', x, '/cnt_songs.tsv', sep=''), 
               sep='\t', row.names=F, quote=F)
   c <- arrange(data.frame(cnt_artists(songs)), year, desc(count))
   write.table(arrange(top.10.artists.year(arrange(data.frame(cnt_artists(songs)), year, desc(count))),artist), paste('shiny/data/', x, '/top.10.tsv', sep=''), 
               sep='\t', row.names=F, quote=F)
   word.cloud(x)
}

process.dj(args[1])
