library(shiny)
library(DT)

drdata <- read.csv("drdata.csv")

ui <- fluidPage(
   
  titlePanel("Devy Watch Dominator Rating"),

  br(),
  fluidRow(
      column(4,selectInput("data_tog","Select Type:",choices = c("Rushing","Receiving"),
                  selected = "Rushing")),
      column(4, selectInput("data_year","Select Year:",choices = c("All","2017","2016","2015"),
                  selected = "All"))
  ),
  br(),
  fluidRow(dataTableOutput("DRdata"))
)


server <- function(input, output) {
   
  output$DRdata <- renderDataTable({
    
    if(input$data_year == "All") {
      
      DRdata <- drdata[drdata$Type == input$data_tog,1:11]
    
    }
    
    if(input$data_year != "All") {
      
      DRdata <- drdata[drdata$Type == input$data_tog & drdata$Year == input$data_year,1:11]
      
    }
    
    DRdata
    
  }, rownames = FALSE, filter = "top", options = list(lengthMenu = c(25, 50, 100),
                                      pageLength = 25))
  
}

# Run the application 
shinyApp(ui = ui, server = server)

