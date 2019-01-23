# loading required libraries
library(plotly)

# Choices for drop-downs
vars_armed <- c(
  "All" = "all",
  "Gun" = "gun",
  "Knife" = "knife",
  "Other" = "Other"
)

vars_gender <- c(
  "All" = "all",
  "Male" = "M",
  "Female" = "F"
)

vars_race <- c(
  "All" = "all",
  "White" = "W",
  "Black" = "B",
  "Hispanic" = "H",
  "Other" = "Other"
)

vars_fleeing <- c(
  "All" = "all",
  "Not Fleeing" = "Not fleeing",
  "Car" = "Car",
  "Foot" = "Foot",
  "Other" = "Other"
)


# main page display options
navbarPage("Police Shootings (US)", id="nav",
           
           # main map on the app display
           tabPanel("Interactive map",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css")
                        ),
                        
                        plotlyOutput("plot", height = "600px"),
                        verbatimTextOutput("click"),
                        
                        # Shiny versions prior to 0.11 should use class = "modal" instead.
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 100, left = 20, right = "auto", bottom = "auto",
                                      width = 330, height = "auto",
                                      
                                      h2("Explorer"),
                                      sliderInput("age_range", "Age:",
                                                  min = 1, max = 100,
                                                  value = c(1, 80)),
                                      
                                      selectInput("race", "Race", vars_race, selected = "all"),
                                      selectInput("gender", "Gender", vars_gender),
                                      selectInput("armed", "Armed", vars_armed),
                                      selectInput("fleeing", "Fleeing", vars_fleeing),
                                      plotOutput("histAge", height = 200),
                                      tableOutput("top5")
                                      #plotOutput("scatterCollegeIncome", height = 250)
                        )
                        
                        
                    )
           ),
           
           # configuring the ui for the data explorer tab
           tabPanel("Data explorer",
                    fluidPage(
                      titlePanel("Basic DataTable"),
                      
                      # Create a new Row in the UI for selectInputs
                      fluidRow(
                        column(4,
                               selectInput("gen",
                                           "Gender:",
                                           c("All",
                                             unique(as.character(shootings$gender))))
                        ),
                        column(4,
                               selectInput("rac",
                                           "Race:",
                                           c("All",
                                             unique(as.character(shootings$race))))
                        ),
                        column(4,
                               selectInput("arm",
                                           "Armed:",
                                           c("All",
                                             unique(as.character(shootings$armed))))
                        ),
                        column(4,
                               selectInput("flee",
                                           "Flee:",
                                           c("All",
                                             unique(as.character(shootings$flee))))
                        )
                      ),
                      # Create a new row for the table.
                      DT::dataTableOutput("table")
                    )
           ),
           
           conditionalPanel("false", icon("crosshair"))
)
