#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

pacman::p_load(shiny)

shinyUI(fluidPage(
  titlePanel("Height Pediction"),
  sidebarLayout(
    sidebarPanel(
      helpText("Prediction of the child's height based on gender and parent's height"),
      helpText("Parameters:"),
      sliderInput(inputId = "inFh",
                  label = "Father's height (in):",
                  value = 36,
                  min = 36,
                  max = 96,
                  step = 1),
      sliderInput(inputId = "inMh",
                  label = "Mother's height (in):",
                  value = 36,
                  min = 36,
                  max = 96,
                  step = 1),
      radioButtons(inputId = "inGen",
                   label = "Child's gender: ",
                   choices = c("Female"="female", "Male"="male"),
                   inline = TRUE)
    ),
    
    mainPanel(
      htmlOutput("pText"),
      htmlOutput("pred"),
      plotOutput("Plot", width = "50%")
    )
  )
))
