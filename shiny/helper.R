library(shiny)
library(tm)
library(dplyr)
library(lazyeval)
library(SnowballC)
library(ggplot2)
library(plyr)


# wins<-get.wins(name)
# 
# win.docs <- Corpus(VectorSource(paste(wins$loser.trademark.moves, wins$loser.finishers)))
# win.docs <- tm_map(win.docs,
#                    content_transformer(function(x) iconv(x, to='UTF-8', sub='byte')),
#                    mc.cores=1)
# win.docs <- tm_map(win.docs, content_transformer(removeNumbers), lazy=T)
# #win.docs <- tm_map(win.docs, content_transformer(tolower), lazy=T)
# win.docs <- tm_map(win.docs, content_transformer(removePunctuation), lazy=T)
# win.docs <- tm_map(win.docs, content_transformer(removeWords), stopwords("english"), lazy=T)
# win.docs <- tm_map(win.docs, content_transformer(stemDocument), lazy=T)
# win.docs <- tm_map(win.docs, content_transformer(stripWhitespace), lazy=T)
# win.dtm <- DocumentTermMatrix(win.docs)   
