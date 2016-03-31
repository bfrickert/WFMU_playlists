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
                   c("Airborne Event" = "AE",
                     "Brian Turner" = "BT",
                     "Bryce" = "BK",
                     "Charlie Lewis" = "CL",
                     "Diane's Kamikaze Fun Machine" = "DK",
                     "Duane Train" = "DH",
                     "Evan \"Funk\" Davies" = "ED",
                     "Gaylord Fields" = "GF",
                     "Imaginary Radio" = "ID",
                     "Inflatable Squirrel Carcass" = "IS",
                     "Irene Trudel" = "IT",
                     "Irwin Chusid"="IC",
                     "John Allen" = "JA",
                     "Ken Freedman"="KF",
                     "Liz Berg"="LB",
                     "Marty McSorley" = "BY",
                     "Michael Shelley" = "SH",
                     "My Castle of Quiet" = "WB",
                     "Nickel & Dime" = "ND",
                     "Put the Needle on the Record" = "BJ",
                     "Scott Williams" = "SW",
                     "Shrunken Planet" = "SP",
                     "Strength Through Failure" = "FR",
                     "Surface Noise" = "SN",
                     "Therese" = "TQ",
                     "This is the Modern World" = "LM",
                     "Todd-a-phonic Todd" = "TA",
                     "Tony Coulter" = "TC",
                     "World of Echo" = "DM"
                     ), selected='Ken Freedman')
    ),
    mainPanel(
      HTML("<h4>Welcome to the <strong>WFMU DJ Dashboard</strong>!
           </h4>"),
     plotOutput('top'),
     HTML("<h4><strong>Top Ten Most Played Artists by Year</strong></h4>"),
     tags$h5("Below is a graph of the artists whose songs were played the most by your DJ, with
counts broken
down by year. Hover over the graph to see artist names and counts."),
     plotlyOutput('big.one'),
     br(),br(),
     HTML("<h4><strong>A Representative Playlist</strong></h4>"),
     HTML("<h5>Using natural language processing, a <i>representative<?i> playlist was created.</h5>"),
     tableOutput('tabl'),
     HTML("<h4><strong>Comments Section Word Cloud</strong></h4>"),
     HTML("<h5>The following word cloud is <i>WFMU-adjusted</i>. That means words common
             in comments for other DJ's have been removed in an effort to isolate a collection of 
             words 
             that is perhaps unique for this DJ.</h5>"),
     imageOutput("word.cloud")
    )
      )
    ))