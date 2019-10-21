md <- mtcars

library(shiny)
library(ggplot2)
library(dplyr)
md$cyl <- as.factor(md$cyl)
md$vs <- as.factor(md$vs)
md$am <- as.factor(md$am)
md$gear <- as.factor(md$gear)
md$carb <- as.factor(md$carb)



ui <- fluidPage(
  titlePanel("Boxplot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "y", label = "Y-axis:",
                  choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                  selected = "mpg"), 
      selectInput(inputId = "x", label = "X-axis:",
                  choices = c("am", "vs", "carb", "gear", "cyl"),
                  selected = "am")
    ),
    mainPanel(
      plotOutput(outputId = "boxplot")
    )
    
  )
  
)

server <- function(input, output){
  output$boxplot <- renderPlot({
    ggplot(md, aes_string(x = input$x, y = input$y)) + geom_boxplot()
  })
}


shinyApp(ui = ui, server = server)