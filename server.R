library(shiny)

data(mtcars)
fit <- lm(mpg ~ wt + hp + am, data = mtcars)

shinyServer(function(input, output) {

  pred <- reactive({
    newcar <- data.frame(wt = input$wt, hp = input$hp, am = as.numeric(input$am))
    max(0, predict(fit, newdata = newcar))
  })

  output$prediction <- renderText({
    paste0("Predicted: ", round(pred(), 1), " miles per gallon")
  })

  output$category <- renderText({
    p <- pred()
    rating <- if (p > 25) "Efficient" else if (p >= 18) "Average" else "Thirsty"
    paste("Efficiency rating:", rating)
  })

  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg, pch = 19, col = "steelblue", cex = 1.3,
         xlab = "Weight (1000 lbs)", ylab = "Miles per gallon",
         main = "mtcars data and your predicted car")
    if (input$showfit) {
      wts <- seq(1.5, 5.5, length.out = 50)
      nd <- data.frame(wt = wts, hp = input$hp, am = as.numeric(input$am))
      lines(wts, predict(fit, nd), col = "darkgreen", lwd = 2)
    }
    points(input$wt, pred(), pch = 18, col = "red", cex = 3)
    legend("topright", legend = c("mtcars cars", "Your car"),
           pch = c(19, 18), col = c("steelblue", "red"))
  })
})
