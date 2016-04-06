library(dplyr)
djs <- read.csv('djs.tsv',sep='\t', stringsAsFactors = F)
djs <- arrange(djs, name)
choices = setNames(djs$dj,djs$name)