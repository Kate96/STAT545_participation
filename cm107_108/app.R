#cm107 ------------------------------------------
#Lines 4-28 are from Vincenzo's repository (I missed cm107 so didn't have notes)

library(shiny)
library(tidyverse)

bcl <- read.csv("C:/Users/Kate96/Desktop/Connect/MSc/Stat545_547/STAT545_participation/cm107_108/bcl-data.csv", stringsAsFactors = FALSE)

#ui <- fluidPage(
#  titlePanel("BC Liquor price app", 
#             windowTitle = "BCL app"),
#  sidebarLayout(
#    sidebarPanel("This text is in the sidebar."),
#    mainPanel(
#      plotOutput("price_hist"),
#      tableOutput("bcl_data")
#    )
#  )
#)

#server <- function(input, output) {
#  output$price_hist <- renderPlot(ggplot2::qplot(bcl$Price))
#  output$bcl_data <- renderTable({
#    bcl
#  })
#}

#shinyApp(ui = ui, server = server)

#cm108 ------------------------------------------

#RECAP: 
#to develop shiny app, need ui (user interface - html), 
#and server (to handle R machinery, eg generate the plot)
#To produce eg the plot, use plotOutput in ui with its id (in this case, "price_hist")
#Then this id is used in the server to generate the plot

ui <- fluidPage(
  titlePanel("BC Liquor price app", 
             windowTitle = "BCL app"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Select your desired price range.",
                  min = 0, max = 100, value = c(15, 30), pre="$"),
      radioButtons("typeInput", "Select your alcoholic beverage type.",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE")
    ),
    mainPanel(
      plotOutput("price_hist"),
      tableOutput("bcl_data")
    )
  )
)

server <- function(input, output) {
  #to make the code interactive so it changes both the df and the plot:
  bcl_filtered <- reactive({
    bcl %>% 
      filter(Price < input$priceInput[2],
             Price > input$priceInput[1],
             Type == input$typeInput) #it is now a function; need to add () in the code below
  })
  output$price_hist <- renderPlot({
    bcl_filtered() %>% 
      ggplot(aes(Price)) +
      geom_histogram()
  })
  output$bcl_data <- renderTable({
    bcl_filtered()
  })
}

shinyApp(ui = ui, server = server)