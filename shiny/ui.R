library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Forecast Bike Trail Usage in Arlington, Va."),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dj", "Choose a DJ:",
                   c("Ken Freedman"="KF",
                     "Liz Berg"="LB",
                     "Irwin Chusid"="IC"
                     ))
    ),
    mainPanel(
      )
      )
    ))