library(shiny)
library(ggplot2)
library(hrbrthemes)
library(scales)
# load data
data("diamonds")

# Define UI for the application
shinyUI(fluidPage(titlePanel("Diamonds - Cost depends on Carat, Cut, Color, and Clarity"),
                  sidebarLayout(sidebarPanel(h4("Choose Diamond"),
                                             selectInput("cut", "Cut", (sort(unique(diamonds$cut), decreasing = T))),
                                             selectInput("color", "Color", (sort(unique(diamonds$color)))),
                                             selectInput("clarity", "Clarity", (sort(unique(diamonds$clarity), decreasing = T))),
                                             sliderInput("lm", "Carat",
                                                         min = min(diamonds$carat), max = max(diamonds$carat),
                                                         value = max(diamonds$carat) / 2, step = 0.1),
                                             h4("Predicted Price"), verbatimTextOutput("predict"), width = 4),
                                mainPanel("Price-Carat Relationship", plotOutput("distPlot")))))