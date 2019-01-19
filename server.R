# loading required libraries
library(tidyverse)
library(shiny)

set.seed(100)

function(input, output, session) {
  
  ## Interactive Map ###########################################
  
    # creating a reactive data object to be used in the plot
    dat <- reactive({
        
        # filtering data bsed on user selected settings
        dat <- shootings %>% 
                filter(race == input$race, armed == input$armed, 
                       gender == input$gender, flee == input$fleeing,
                       age >=input$age_range[1], age <= input$age_range[2]) %>% 
                group_by(state) %>% 
                summarise(n = n()) %>% 
                mutate(prop = n * 100 / sum(n))
    })
    
  
  ## map plotly
  output$plot <- renderPlotly({
    # specify some map projection/options
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      lakecolor = toRGB('white')
    )
    # plot the map with the reactive dataset created based on user settings
    plot_ly(z = dat()$prop, text = dat()$state, locations = dat()$state,
            type = 'choropleth', locationmode = 'USA-states', colorscale='Viridis') %>%
            colorbar(title = '% of Total Shootings') %>% 
            layout(geo = g, title = 'Poolice Shootings in the United States (2015 - Present)')
  })
  
  # add some more interactivity in the future based on clicks
  # output$click <- renderPrint({
  #   d <- event_data("plotly_click")
  #   if (is.null(d)) "Click on a state to view event data" else d
  # })
  
  
  # reactive slider for age to diplay corresponding histogram
    age <- shootings$age
    lims <- reactive({
      c(input$age_range[1], input$age_range[2])
    })
    
  # Precalculate the breaks we'll need for the two histograms
    ageBreaks <- hist(plot = FALSE, shootings$age, breaks = 20)$breaks
  
    output$histAge <- renderPlot({
      hist(shootings$age,
           breaks = ageBreaks,
           main = "Age of the person",
           xlab = "Age",
           xlim = lims(),
           col = '#00DD00',
           border = 'white')
  })
  
  ## Data Explorer ###########################################
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
      data <- shootings
      if (input$gen != "All") {
        data <- data[data$gender == input$gen,]
      }
      if (input$rac != "All") {
        data <- data[data$race == input$rac,]
      }
      if (input$arm != "All") {
        data <- data[data$armed == input$arm,]
      }
      if (input$flee != "All") {
        data <- data[data$flee == input$flee,]
      }
      data
    }))
  
}
