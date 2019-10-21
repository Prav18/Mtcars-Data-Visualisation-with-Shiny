#===================Shiny App- Histogram================================================

md <- mtcars

library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Histogram"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                  selected = "mpg")
      
    ),
    mainPanel(
      plotOutput(outputId = "hist")
    )
    
  )
  
)

server <- function(input, output){
  output$hist<- renderPlot({
    ggplot(md, aes_string(x = input$x)) + geom_histogram(color = "red", fill = "green", bins = 8) 
    # hist(x=input$x)
  })
}


shinyApp(ui = ui, server = server)