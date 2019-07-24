
    # Conversión entre dataframes y datos espaciales
    
    library(sp)

    nj <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema12/nj-wages.csv')
    class(nj)    
    head(nj)
    
    # Función que devuelve coordenadas (lat y long) de un dataframe
      #Sirve para tablas que contengan coordenadas entre su contenido
    coordinates(nj) <- c('Long', 'Lat')  # La función busca las coordenadas en el dataset
    class(nj)     
    head(nj)    
    
    # Unir lineas del dataframe (en este caso lat y long del dataset denew jersey)
    nj.lines <- SpatialLines(list(Lines(list(Line(coordinates(nj))), 
                                        'line_nj')))
    
    plot(nj.lines)
    
    
    
    