md <- mtcars

library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Barplot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("cyl", "gear", "vs", "am", "carb"),
                  selected = "cyl")
      
    ),
    mainPanel(
      plotOutput(outputId = "barplot")
    )
    
  )
  
)

server <- function(input, output){
  output$barplot<- renderPlot({
    ggplot(md, aes_string(x = input$x)) + geom_bar(color = "red", fill = "green") 
    # hist(x=input$x)
  })
}


shinyApp(ui = ui, server = server)