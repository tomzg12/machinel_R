# Tree maps

  install.packages('treemap')
  library(treemap)

    branch <- c( rep('branch-1',4)
                ,rep('branch-2',2)
                ,rep('branch-3',3))  

    subranch <- paste('subranch', c(1,2,3,4,1,2,1,2,3), sep = '-')    
    
    values = c(15, 4, 22, 13, 11, 8, 6, 1, 25)
    
    # juntar rama, subrama y valor en un dataframe
    
    data <- data.frame(branch, subranch, values)
    View(data)
    
    # Representar mapa de árbol (muestra conjuntos)
    treemap(data, 
            index = c('branch', 
                      'subranch'), 
            vSize = 'values', 
            type = 'index',
            palette = "Set1")
  
    
    # Ejemplos de datos con dataframe
    posts <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/post-data.csv')
    View(posts)
    
    png(filename = 'tree.png', width=1500, height=800)
    treemap(posts, 
            index = c('category',
                      'comments'),
            vSize = 'views',
            type = 'index',
            palette = "Set2",
            fontfamily.legend = "sans", 
            border.col = "white",
            fontsize.title = 25, 
            fontsize.labels = 11, 
            fontsize.legend = 12, 
            fontcolor.labels = NULL,
            title =' Vistas'
            )
    dev.off()
    
    
    