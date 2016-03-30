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
                     "Diane's Kamikaze Fun Machine" = "DK",
                     "Brian Turner" = "BT",
                     "Nickel & Dime" = "ND",
                     "This is the Modern World" = "LM",
                     "John Allen" = "JA",
                     "Scott Williams" = "SW",
                     "My Castle of Quiet" = "WB",
                     "Put the Needle on the Record" = "BJ",
                     "Strength Through Failure" = "FR",
                     "Bryce" = "BK",
                     "Evan \"Funk\" Davies" = "ED",
                     "Irene Trudel" = "IT",
                     "Airborne Event" = "AE",
                     "World of Echo" = "DM",
                     "Gaylord Fields" = "GF",
                     "Shrunken Planet" = "SP",
                     "Todd-a-phonic Todd" = "TA",
                     "Inflatable Squirrel Carcass" = "IS"
                     ))
    ),
    mainPanel(
      
     #textOutput('var'),
     plotOutput('top'),
     plotlyOutput('big.one'),
     br(),br(),
     tableOutput('tabl')
    )
      )
    ))