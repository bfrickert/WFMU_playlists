source('helper.R')
library(ggplot2)

shinyServer(function(input, output) {
  
  getUnqSongs <- reactive({
    s <- read.csv(paste('data/', input$dj, '/unq_songs.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
    })
  getNLTKplaylist <- reactive({
    s <- read.csv(paste('data/', input$dj, '/nltk_playlist.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
  })
  getTop10byYear <- reactive({
    s <- read.csv(paste('data/', input$dj, '/top.10.tsv', sep=''), sep='\t', header = T, stringsAsFactors = F)
    s
  })

  output$tabl <- renderTable({
    getNLTKplaylist()
  })
  
  output$top <- renderPlot({
    ggplot(head(getUnqSongs(), n=10), 
                aes(fill=artist, x=artist, y=count)) + 
      geom_bar(stat = "identity") + coord_flip() + ggtitle("Most Unique Songs Played by These Artists") +
      theme_bw()
    
  })
  output$big.one <- renderPlotly({
    plot_ly(arrange(getTop10byYear(), artist), x=artist, y=count, type='bar', color=factor(year)) %>%
      layout(showlegend=F)
  })
})

