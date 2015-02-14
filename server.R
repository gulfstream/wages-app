library(shiny)
library(ggplot2)

wages <- read.table("data/wages.txt", header = TRUE)
wages$Age.Group <- as.factor(wages$Age.Group)
wages$Potential.Experience <- as.factor(wages$Potential.Experience)

dataset <- wages

shinyServer(function(input, output) {
    
output$plot <- reactivePlot(function() {
        
options(scipen = 6)
    
p <- ggplot(dataset, aes_string(x = input$x, y = input$y)) +
            geom_boxplot() + theme_bw() +
            theme(axis.text.x = element_text(angle = 90, vjust = 0.5,
                                             hjust = 0.5, size = 10),
                  axis.text.y = element_text(size = 10),
                  axis.title.x = element_text(vjust = -0.5, size = 12),
                  axis.title.y = element_text(vjust = 2, size = 12))
    
if (input$color != 'None')
    p <- p + aes_string(color = input$color)
        
facets <- paste(input$facet_row, '~', input$facet_col)

if (facets != '. ~ .')
    p <- p + facet_grid(facets)

print(p) 
        
}, height = 700)

})