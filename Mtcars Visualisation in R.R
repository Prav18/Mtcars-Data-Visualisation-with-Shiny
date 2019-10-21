
library(shiny)
library(ggplot2)
library(dplyr)
library(psych)
library(DT)
md <- mtcars

md$cyl <- as.factor(md$cyl)
md$vs <- as.factor(md$vs)
md$am <- as.factor(md$am)
md$gear <- as.factor(md$gear)
md$carb <- as.factor(md$carb)
d <- round(describe(md),2)
ds <- str(md)
# str(md)

shinyApp(
  shinyUI(
    
    navbarPage("Mtcars", 
               tabPanel("mtcars Data", DTOutput('tbl_1')),
               tabPanel("Data Summary", DTOutput('tbl_2')),
               tabPanel("Scatter Plot", uiOutput('page2')),
               tabPanel("Boxplot", uiOutput("page3")),
               tabPanel("Histogram", uiOutput("page4")),
               tabPanel("Barplot", uiOutput("page5"))
    )
    
  ),
  
  shinyServer(function(input, output, session) {
    
    output$tbl_1 = renderDT(
      md, options = list(lengthChange = T))
    
    output$tbl_2=renderDT(
      d, options = list(lengthChange =F)
    )

    output$page2 <- renderUI({
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "y1", label = "Y-axis:",
                      choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                      selected = "mpg"), 
          selectInput(inputId = "x1", label = "X-axis:",
                      choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                      selected = "wt")
        ),
        mainPanel(
          plotOutput(outputId = "scatterplot")
        )
      )
    })
    
    output$scatterplot <- renderPlot({
      ggplot(md, aes_string(x = input$x1, y = input$y1)) + geom_point(col = "red")
    })
  
  output$page3 <- renderUI({
    sidebarLayout(
      sidebarPanel(
  selectInput(inputId = "y2", label = "Y-axis:",
              choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
              selected = "mpg"), 
  selectInput(inputId = "x2", label = "X-axis:",
              choices = c("am", "vs", "carb", "gear", "cyl"),
              selected = "am")
  ),
  mainPanel(
    plotOutput(outputId = "boxplot")
  )
 )
})

    output$boxplot <- renderPlot({
    ggplot(md, aes_string(x = input$x2, y = input$y2)) + geom_boxplot(col = "red", fill = "orange")
    })
    
    output$page4 <- renderUI({
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "x3", label = "X-axis:",
                      choices = c("mpg", "wt", "hp", "disp", "drat", "qsec"),
                      selected = "mpg") 
          ),
        mainPanel(
          plotOutput(outputId = "hist")
        )
      )
    })
    
    output$hist<- renderPlot({
      ggplot(md, aes_string(x = input$x3)) + geom_histogram(color = "red", fill = "green", bins = 8) 
      })
    
    
 
    
    output$page5 <- renderUI({
      sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "x4", label = "X-axis:",
                      choices = c("cyl", "gear", "vs", "am", "carb"),
                      selected = "cyl")
        ),
        mainPanel(
          plotOutput(outputId = "barplot")
        )
      )
    })
    
    output$barplot<- renderPlot({
      ggplot(md, aes_string(x = input$x4)) + geom_bar(color = "red", fill = "blue") 
      })  
    
  }
    )
)

