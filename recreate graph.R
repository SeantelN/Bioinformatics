#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Waterstats recreated graph"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("yvalues",
                  "Y-axis choice:",
                  choices = c(
                    "Total weight lost"="total.loss",
                    "Total percent body weight lost"="total.percent",
                    "Average body weight lost per day"="avg.daily",
                    "Average percent body weight lost per day"="avgpercentdaily",
                    "Number of days survived at 0% relative humidity"="days.survived"
                  ))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("waterplot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) 
  
  output$waterPlot <- renderPlot
    # generate bins based on input$bins from ui.R
    if (input$yvalues=="total.loss")
      y=waterstats$total.loss
      ylabs="Total weight lost"
      
      (input$yvalues=="total.percent")
      y=waterstats$total.percent
      ylabs="Total percent body weight lost"
     
      (input$yvalues=="avg.daily"){
      y=waterstats$avg.daily
      ylabs="Average body weight lost per day"
      
      (input$yvalues=="avgdailypercent"){
      y=waterstats$avgdailyperceny
      ylabs="Average percent body weight lost per day"
    }
    else {
      y=waterstats$days.survived
      ylabs="Days survived at 0% relative humidity"
    }
    
    # make ggplot object
    ggplot(waterstats,aes(factor(status),y))+
      geom_boxplot()+
      stat_boxplot(geom="errorbar")
    
}

# Run the application 
shinyApp(ui = ui, server = server)