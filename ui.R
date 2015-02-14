library(shiny)
library(ggplot2)

wages <- read.table("data/wages.txt", header = TRUE)
wages$Age.Group <- as.factor(wages$Age.Group)
wages$Potential.Experience <- as.factor(wages$Potential.Experience)

dataset <- wages

shinyUI(
    
fluidPage(
    
titlePanel("Canadian Wage Explorer"),
    
sidebarLayout(
        
sidebarPanel(

h3("Input"),
    
p("Create exploratory graphs using custom wage data subsetted 
             from Canada's 2011 National Household Survey."),
            
    selectInput('x', 
                label = 'Choose x-axis variable',
                choices = names(dataset), 
                selected = names(dataset)[[1]]),
    selectInput('y', 
                label = 'Choose y-axis variable',
                choices = names(dataset), 
                selected = names(dataset)[[2]]),
    selectInput('color',
                label = 'Choose variable to subset data by using colour',
                choices = c('None', names(dataset)), 
                selected = names(dataset)[[4]]),
    selectInput('facet_row', 
                label = 'Choose variable to subset data by using facet row', 
                choices = c(None='.', names(dataset))),
    selectInput('facet_col', 
                label = 'Choose variable to subset data by using facet column', 
                choices = c(None = '.', names(dataset)))
    ),
    
mainPanel(
    h3("Introducing Canadian Wage Explorer"),
    p("This is a very simple tool I made to explore a custom dataset I'm
      using for a empirical project I'm working on about wage discrimination in
      Canada."),
    p("The explorer makes use of ", 
      a("R's",
        href = "http://www.r-project.org/"), 
      a("ggplot2",
        href = "http://ggplot2.org/"),
      "package to make",
      a("box and whiskers plots",
      href = "http://docs.ggplot2.org/0.9.3.1/geom_boxplot.html"),
      "of the chosen variables."),
    
    h3("Data"),
    p("The dataset is restricted to 175,119 full-time, full-year, non-Aboriginal 
      employees aged 25-64 living in a province."),
    p("The data source is Statistics Canada's 2011 National Household Survey
      Public Use Microdata File (Individuals), which I accessed from the Equinox
      portal via the Concordia Unversity library."),
    p("For more information on the National Household Survey, visit the ",
      a("NHS website.", 
        href = "http://www12.statcan.gc.ca/nhs-enm/index-eng.cfm?HPA")),
    
    h3("Output"),
    plotOutput("plot")
)
)))