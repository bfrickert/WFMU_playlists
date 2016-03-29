library(shiny)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("WFMU DJ Dashboard"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dj", "Choose a DJ:",
                   c("Ken Freedman"="KF",
                     "Liz Berg"="LB",
                     "Irwin Chusid"="IC",
                     "Marty McSorley" = "BY",
                     "Brian Turner" = "BT",
                     "Nickel & Dime" = "ND",
                     "John Allen" = "JA",
                     "Scott Williams" = "SW"
                     ))
    ),
    mainPanel(
      
     textOutput('var'),
     plotOutput('top'),
     plotlyOutput('big.one'),
     br(),br(),
     tableOutput('tabl')
    )
      )
    ))