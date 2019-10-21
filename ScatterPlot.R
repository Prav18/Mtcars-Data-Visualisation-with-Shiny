#====================================Shiny App Mtcars=================================

md <- mtcars

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Scatter Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "y", label = "Y-axis:",
                  choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                  selected = "mpg"), 
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                  selected = "wt")
    ),
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
    
  )
  
)

server <- function(input, output){
  output$scatterplot <- renderPlot({
    ggplot(md, aes_string(x = input$x, y = input$y)) + geom_point()
  })
}


shinyApp(ui = ui, server = server)