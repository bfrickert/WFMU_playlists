songs <- read.csv('../data/songs_hour.tsv', sep='\t')

library(plyr)
songs$bohemian <- grepl("bohemian", songs$song, ignore.case = TRUE)
songs$rhapsody <- grepl("rhapsody", songs$song, ignore.case = TRUE)

x <- ddply(songs, .(date), summarize, bohemian_factor=sum(bohemian))
y <- ddply(songs, .(date), summarize, rhapsody_factor=sum(rhapsody))

plot.new()

plot(x$date,x$bohemian_factor,col="red")
lines(x$date,x$bohemian_factor,col="red")
lines(y$date,y$rhapsody_factor,col="green")

library(ggplot2)
p1 <- 
  ggplot(x, aes(x=date, y=bohemian_factor, group=1)) +
  geom_line() +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("Instances of 'Bohemian'")
jpeg('../viz/bohemian.jpeg', width=20, height=30, units='cm', res=100)
p1
dev.off()
# Second plot
p2 <- 
  ggplot(y, aes(date, y=rhapsody_factor, group=1)) +
  geom_line(alpha=.3) +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("Instances of 'Rhapsody'")
jpeg('../viz/rhapsody.jpeg', width=20, height=30, units='cm', res=100)
p2
dev.off()

write.table(x,"../data/x.tsv",sep="\t")
write.table(y,"../data/y.tsv",sep="\t")
