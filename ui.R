library(plotly)

# Choices for drop-downs
vars_armed <- c(
  "Gun" = "gun",
  "Knife" = "knife",
  "Other" = "Other"
)

vars_gender <- c(
  "Male" = "M",
  "Female" = "F"
)

vars_race <- c(
  "White" = "W",
  "Black" = "B",
  "Hispanic" = "H",
  "Other" = "Other"
)

vars_fleeing <- c(
  "Not Fleeing" = "Not fleeing",
  "Car" = "Car",
  "Foot" = "Foot",
  "Other" = "Other"
)


navbarPage("Shootings", id="nav",
           
           tabPanel("Interactive map",
                    div(class="outer",
                        
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css")
                        ),
                        
                        plotlyOutput("plot"),
                        verbatimTextOutput("click"),
                        
                        # Shiny versions prior to 0.11 should use class = "modal" instead.
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      
                                      h2("Explorer"),
                                      sliderInput("age_range", "Age:",
                                                  min = 1, max = 100,
                                                  value = c(1, 80)),
                                      
                                      selectInput("race", "Race", vars_race),
                                      selectInput("gender", "Gender", vars_gender),
                                      selectInput("armed", "Armed", vars_armed),
                                      selectInput("fleeing", "Fleeing", vars_fleeing),
                                      plotOutput("histAge", height = 200)
                                      #plotOutput("scatterCollegeIncome", height = 250)
                        )
                    )
           ),
           
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
