library(shiny)
library(datasets)

# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot<-renderPlot({
  if (input$variable =="Year"){
      barplot(WorldPhones[input$year,]*1000, 
              main=input$year,
              ylab="Number of Telephones",
              xlab="Region")
  }
  else{
    barplot(WorldPhones[, input$region]*1000, 
            main=input$region,
            ylab="Number of Telephones",
            xlab="Year")
  }
  }, height = 700)
  
}


# Use a fluid Bootstrap layout
ui <- fluidPage(    

  # Give the page a title
  titlePanel("Telephones by region"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      checkboxGroupInput("variable", "Variables to show:",
                         c("Region","Year"),selected = "Region"), 
      selectInput("region", "Region:", 
                  choices=colnames(WorldPhones)),
      selectInput("year", "Year:", 
                  choices=rownames(WorldPhones)),
      hr(),
      helpText("Data from AT&T (1961) The World's Telephones.")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("phonePlot")  
    )
  )
)

shinyApp(ui = ui, server = server)
