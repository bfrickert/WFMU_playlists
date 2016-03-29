library(dplyr)
args = commandArgs(trailingOnly=TRUE)

print('Removing duplicates............')

nm <- args[1]

irwin <- read.csv(paste('data/', nm, '/playlists.tsv', sep=''), sep='\t', stringsAsFactors = F)
irwin <- distinct(irwin)
write.table(irwin, paste('data/', nm, '/playlists.tsv', sep=''), sep='\t', row.names = F, quote = F)