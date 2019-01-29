# loading required libraries
library(tidyverse)
library(shiny)

set.seed(100)

function(input, output, session) {
  
  ## Interactive Map ###########################################
  
    # creating a reactive data object to be used in the plot
    dat <- reactive({
        
        # filtering based on user selected input
        if(input$race=="all")
          filter_race=unique(shootings$race)
        else
          filter_race = input$race
        
        if(input$armed=="all")
          filter_armed=unique(shootings$armed)
        else
          filter_armed = input$armed
        
        if(input$gender=="all")
          filter_gender=unique(shootings$gender)
        else
          filter_gender = input$gender
        
        if(input$fleeing=="all")
          filter_flee=unique(shootings$flee)
        else
          filter_flee = input$fleeing
        
        
        # applying the filters on data based on user selected settings
        dat <- shootings %>% 
                filter(race %in% filter_race, armed %in% filter_armed,
                       gender %in% filter_gender, flee %in% filter_flee,
                       age >=input$age_range[1], age <= input$age_range[2]) %>% 
                group_by(state) %>% 
                summarise(cases = n()) %>% 
                mutate(percentage = round(cases * 100 / sum(cases), 3))
    })
    
    ## map plotly
    output$plot <- renderPlotly({
      # specify some map projection/options
      g <- list(
        scope = 'usa',
        projection = list(type = 'albers usa'),
        lakecolor = toRGB('white')
      )
      
      output$hover <- renderTable({
          d <- event_data("plotly_hover", source = "choropleth")
          if (length(d))
          {
            curr_state <- map$state[map$index == (d[['pointNumber']] + 1)]
            shootings %>% 
              filter(state == curr_state) %>% 
              group_by(race) %>% 
              mutate(cases = n()) %>% 
              select(race, cases) %>% 
              arrange(race) %>% 
              distinct()
          }
          else
          {
            text <- NULL
          }
      })
      
      
      # plot the map with the reactive dataset created based on user settings
      plot_ly(z = dat()$percentage, text = dat()$state, locations = dat()$state, source = "choropleth",
              type = 'choropleth', locationmode = 'USA-states', colorscale='Viridis') %>%
              colorbar(title = '% of Shootings based \n on selected settings') %>% 
              layout(geo = g, title = 'Analyze Civilian Deaths from Police Shootings across the US (2015 - Present)')
    })
  
    # add some more interactivity based on clicks
    output$linechart <- renderPlotly({
      s <- event_data("plotly_click", source = "choropleth")
      if (length(s)) {
          d <- country_gp %>% 
              filter(state == map$state[map$index == (s[['pointNumber']] + 1)])

          # plotting line chart of deaths over time for selected state
          d %>% 
              ggplot(aes(x = ym, y = count, group=1)) +
              geom_line() +
              labs(x = "Time", y = "Civilian Deaths") +
              ggtitle(unique(d$state)) +
              theme_bw() +
              theme(axis.text.x = element_text(angle = 90, hjust = 1))
      } else {
        plotly_empty()
      }
    })
    
  
    # reactive slider for age to diplay corresponding histogram
      age <- shootings$age
      lims <- reactive({
        c(input$age_range[1], input$age_range[2])
      })
      
    # Precalculate the breaks we'll need for the two histograms
      ageBreaks <- hist(plot = FALSE, shootings$age, breaks = 20)$breaks
    
    # histogram for age by selected slider range
      output$histAge <- renderPlot({
        hist(shootings$age,
             breaks = ageBreaks,
             main = "Age of the person",
             xlab = "Age",
             ylab = "Death Count",
             xlim = lims(),
             col = "red",
             border = 'white')
      })
      
      output$bar <- renderPlotly({
          x <- list(
            title = "Race"
          )
          y <- list(
            title = "Death Count"
          )
          plot_ly(x = bar_dat$race, y = bar_dat$cases, type = "bar", 
                  name = "Race (deaths) distribution") %>% 
            layout(xaxis = x, yaxis = y, title = "Deaths (by race) distribution")
      })
    
      # displaying top 5 states with the selected settings
      output$top5 <- renderTable({dat() %>% 
                                top_n(5) %>% 
                                arrange(desc(cases))})
    
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
