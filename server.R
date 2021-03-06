#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#install.packages("pacman")
pacman::p_load(shiny, HistData, dplyr, ggplot2)

# 1st step: load data
data(GaltonFamilies)
gf <- GaltonFamilies

# linear model
model1 <- lm(childHeight ~ father + mother + gender, data=gf)

shinyServer(function(input, output) {
  output$pText <- renderText({
    paste("Father's height is",
          strong(round(input$inFh, 1)),
          "in, and mother's height is",
          strong(round(input$inMh, 1)),
          "in, then:")
  })
  output$pred <- renderText({
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(model1, newdata=df)
    kid <- ifelse(
      input$inGen=="female",
      "Daugther",
      "Son"
    )
    paste0(em(strong(kid)),
           "'s predicted height is going to be around ",
           em(strong(round(ch))),
           " in"
    )
  })
  output$Plot <- renderPlot({
    kid <- ifelse(
      input$inGen=="female",
      "Daugther",
      "Son"
    )
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(model1, newdata=df)
    yvals <- c("Father", kid, "Mother")
    df <- data.frame(
      x = factor(yvals, levels = yvals, ordered = TRUE),
      y = c(input$inFh, ch, input$inMh))
    ggplot(df, aes(x=x, y=y, color=c("Grey", "green", "black"), fill=c("Grey", "green", "black"))) +
      geom_bar(stat="identity", width=0.5) +
      xlab("") +
      ylab("Height (cm)") +
      theme_minimal() +
      theme(legend.position="none")
  })
})
