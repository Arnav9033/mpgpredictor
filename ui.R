library(shiny)

shinyUI(fluidPage(
  titlePanel("MPG Predictor: How Efficient Is Your Car?"),
  tabsetPanel(
    tabPanel("App",
      sidebarLayout(
        sidebarPanel(
          h4("Describe your car"),
          sliderInput("wt", "Weight (1000 lbs):", min = 1.5, max = 5.5, value = 3.0, step = 0.1),
          sliderInput("hp", "Horsepower:", min = 50, max = 340, value = 120, step = 5),
          radioButtons("am", "Transmission:", choices = c("Automatic" = 0, "Manual" = 1), selected = 0),
          checkboxInput("showfit", "Show regression line on plot", value = TRUE),
          submitButton("Predict MPG")
        ),
        mainPanel(
          h3("Predicted fuel efficiency"),
          textOutput("prediction"),
          br(),
          textOutput("category"),
          br(),
          plotOutput("plot")
        )
      )
    ),
    tabPanel("Documentation",
      h3("How to use this app"),
      p("This app predicts a car's fuel efficiency (miles per gallon) using a linear regression model
         trained on the built-in R 'mtcars' dataset (32 cars from 1974 Motor Trend)."),
      h4("Steps"),
      tags$ol(
        tags$li("Open the 'App' tab."),
        tags$li("Use the 'Weight' slider to set the car's weight in thousands of pounds (e.g. 3.0 = 3,000 lbs)."),
        tags$li("Use the 'Horsepower' slider to set engine horsepower."),
        tags$li("Choose 'Automatic' or 'Manual' transmission."),
        tags$li("Optionally tick 'Show regression line' to draw the fitted trend on the plot."),
        tags$li("Click 'Predict MPG'. The predicted MPG and an efficiency rating appear on the right.")
      ),
      h4("Reading the output"),
      tags$ul(
        tags$li("Predicted MPG: the model's estimate for the car you described."),
        tags$li("Rating: Efficient (> 25 MPG), Average (18-25) or Thirsty (< 18)."),
        tags$li("Plot: the blue points are real cars from the dataset; the red diamond is your predicted car.")
      ),
      h4("Model"),
      code("mpg ~ wt + hp + am"),
      p("Heavier and more powerful cars generally get fewer MPG; manual transmissions tend to be slightly more efficient.
         Predictions are estimates from a small dataset and are for demonstration only.")
    )
  )
))
