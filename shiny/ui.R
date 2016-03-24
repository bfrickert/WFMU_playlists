library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Forecast Bike Trail Usage in Arlington, Va."),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      tags$img(src="https://pbs.twimg.com/profile_images/463339101895159808/7bVLf-U2_400x400.jpeg",
               width="200px",height="200px"),
      radioButtons("dj", "DJ:",
                   c("Ken Freedman"="KF",
                     "Liz Berg"="LB",
                     "Irwin Chusid"="IC"
                     ))
    ),
    mainPanel(
      )
      )
    ))