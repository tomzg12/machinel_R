

# Redes

  library(igraph)

  
    # Gráfico dirigido
    g.dir <- graph(edges = c(1,2, 2,3, 2, 4, 1,4, 5,5, 3,6, 5,6),
                   n= 6)
  
    # Gráfico No dirigido
    g.n_dir <- graph(edges = c(1,2, 2,3, 2, 4, 1,4, 5,5, 3,6, 5,6),
                   n= 6,
                   directed = FALSE)
    
    
    par(mfrow= c(1,1))

    plot(g.dir)
    plot(g.n_dir)
    
    # Gráfico con elementos aislados
    
    g_isolated <- graph(c('Juan', 'Maria', 
                          'Maria','Ana',
                          'Ana','Juan',
                          'Jose','Maria',
                          'Pedro','Jose',
                          'Joel','Pedro'),
                        isolates = c(
                          'Carmen',
                          'Pedro',
                          'Mario',
                          'Vicente'
                        ))
    
    
    set.seed(1) # Para fijar la forma del gráfico
    plot(g_isolated,
         edge.arrow.size= 1,
         vertex.color = 'gold',
         vertex.size = 15,
         vertex.frame.color = 'gray',
         vertex.label.color = 'black',
         vertex.label.cex = 0.8,
         vertex.label.dis = 5,
         edge.curved = 0.5)
    
    
    
    
    
    
    