library(dplyr)
args = commandArgs(trailingOnly=TRUE)

nm <- args[1]

irwin <- read.csv(paste('data/', nm, '/playlists.tsv', sep=''), sep='\t', stringsAsFactors = F)
irwin <- distinct(irwin)
write.table(irwin, paste('data/', nm, '/playlists.tsv', sep=''), sep='\t', row.names = F)