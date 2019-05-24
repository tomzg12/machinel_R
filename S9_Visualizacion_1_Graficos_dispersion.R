
# Scatter plots

    library(ggplot2)

    auto<- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/auto-mpg.csv', 
                    stringsAsFactors = F)

    
    # Cambiar nombres de los factores
    auto$cylinders <- factor(auto$cylinders,
                             labels = c('3C','4C','5C','6C','8C'))
    # Head
    head(auto)
    
    
    # Plot inicial ---------GRAFICO 1
    plot <- ggplot(auto, aes(weight, mpg))
    
    # agregar capas al gráfico inicial
    plot + geom_point()      # define circulos
    plot + geom_point(alpha = 1/2,  # transparencia
                      size = 5,     # tamaño del punto
                      aes(color = factor(cylinders) # colores de los puntos
                          )) + geom_smooth(method = 'lm', # recta reg lineal
                       se = TRUE,  # se muestra intervalo de confianza
                       col = 'blue')+ #Color de la linea
      theme_bw(base_family = "Times", # tipo de fuente
               base_size = 8)+ # tamaño de fuente
      labs(title = 'Consumo vs peso')+ # Titulo
      labs(x = 'Peso')+  # etiqueta
      labs(y='Millas por galeón')  # etiqueta

    
  

    # GRÁFICO 2 (GENERANDO VARIOS PLOTS CON FACE_GRID)
    plot <- ggplot(auto, aes(weight, mpg))
    
    # agregar capas al gráfico inicial
    plot + geom_point()      # define circulos
    plot + geom_point(alpha = 1/2,  # transparencia
                      size = 5,     # tamaño del punto
                      aes(color = factor(cylinders) # colores de los puntos
                      )) + geom_smooth(method = 'lm', # recta reg lineal
                                       se = TRUE,  # se muestra intervalo de confianza
                                       col = 'blue')+ #Color de la linea
      theme_bw(base_family = "Times", # tipo de fuente
               base_size = 8)+ # tamaño de fuente
      labs(title = 'Consumo vs peso')+ # Titulo
      labs(x = 'Peso')+  # etiqueta
      labs(y='Millas por galeón')+ # etiqueta
      facet_grid(cylinders~.)  #facet_grid(.~cylinders)
                               # Vertical u horizontal
    
    # GRÁFICO 3 (QPLOT) # Muestra regresiones
    
      qplot(x = weight,
            y = mpg, 
            data = auto,
            geom=c('point',
                   'smooth'),
            color= cylinders,
            main = 'Regresion de MPG sobre el peso')
    
    
    
    
    
    
    
    
    
    
    
    