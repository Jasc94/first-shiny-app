library(shiny)
library(shinydashboard)

# Data for visualizations
df <- read.csv('TRUMPWORLD-pres.csv')

# UI for application
ui <- dashboardPage(
    dashboardHeader(title = "my dashboard"),
    dashboardSidebar(),
    dashboardBody()
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
}

# Run the application 
shinyApp(ui = ui, server = server)
