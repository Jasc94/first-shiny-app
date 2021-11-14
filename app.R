library(shiny)
library(shinydashboard)
library(ggplot2)

# Data for visualizations
df <- read.csv('TRUMPWORLD-pres.csv')

# Data for tags
# Year with highest confidence in Trump's administration
max_confidence_year <- df[which(df$avg == max(df$avg)), "year"]

# Country with highest average confidence in Trump administration
country_average_confidence <- sapply(df[-c(1:2)], mean, na.rm = TRUE)
country_names <- names(df[-c(1:2)])
df3 <- data.frame(country_names, country_average_confidence)
highest_confidence_country <- df3[which(df3$country_average_confidence == max(df3$country_average_confidence)), "country_names"]


# UI for application
width <- 12
ui <- dashboardPage(
    dashboardHeader(title = "Actividad 1 - Estadística"),
    dashboardSidebar(
      sidebarMenu(
        menuItem('Dashboard', tabName = 'Dashboard')
      )
    ),
    dashboardBody(
      box(textOutput('max_confidence_text'), width = width),
      box(textOutput('highest_confidence_country'), width = width),
      box(plotOutput('barplot'), width = width),
      box(plotOutput('lineplot'), width = width)
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$max_confidence_text <- renderText({
      paste0('Year of max. average confidence: ', max_confidence_year)
    })
    output$highest_confidence_country <- renderText({
      paste0('Country with highest average confidence: ', highest_confidence_country)
    })
    output$barplot <- renderPlot({
      ggplot(df, aes(x = factor(df$year), y = df$avg)) + geom_bar(stat = 'identity') +xlab('year') + ylab('Average confidence') + theme_minimal()
    })
    output$lineplot <- renderPlot({
      ggplot(df, aes(x = df$year, y = df$Spain)) + geom_line() +xlab('year') + ylab('Spain confidence') + theme_minimal()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
