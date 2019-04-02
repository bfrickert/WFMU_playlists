library(xtable)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {
  
  getUnqSongs <- reactive({
    s <- read.csv(paste('data/', input$dj, '/unq_songs.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
  })
  getNLTKplaylist <- reactive({
    s <- select(read.csv(paste('data/', input$dj, '/nltk_playlist.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F),
                -X)
    s$artist <- gsub('\\(','',gsub('\\)','',s$artist))
    s$song <- gsub('\\(','',gsub('\\)','',s$song))
    s
  })
  getTop10byYear <- reactive({
    s <- read.csv(paste('data/', input$dj, '/top.10.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
  })
  getArtistSongs <- reactive({
    s <- read.csv(paste('data/', input$dj, '/cnt_artists.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
  })
  
  output$tabl <- renderTable({
    getNLTKplaylist()
  })
  
  output$var <- renderText({
    s <- getArtistSongs()
    mean(s$count, na.rm=T)
  })
  
  output$top <- renderPlot({
    ggplot(head(getUnqSongs(), n=10), 
                aes(fill=artist, x=artist, y=count)) + 
      geom_bar(stat = "identity") + coord_flip() + ggtitle("Most Played Artists by this DJ, by Number of Unique Songs") +
      theme_bw() + theme(legend.position="none")
    
  })
  output$big.one <- renderPlotly({
    ax <- list(
      title = "artists",
      zeroline = FALSE,
      showline = FALSE,
      showticklabels = FALSE,
      showgrid = FALSE
    )
    plot_ly(arrange(getTop10byYear(), artist), x=~artist, y=~count, type='bar', color=factor(arrange(getTop10byYear(), artist)$year)) %>%
      layout(showlegend=F, xaxis=ax, title='')
  })
  output$word.cloud <- renderImage({
    list(src = paste('./viz/wordcloud/',input$dj,'.jpg',sep=''),
         alt = "Word Cloud")
    
  }, deleteFile = FALSE)
})
