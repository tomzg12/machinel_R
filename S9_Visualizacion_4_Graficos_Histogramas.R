# Gráficos de distibución

  library(ggplot2)

  # dataset  
  geiser <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/geiser.csv')  
  
  # vista preliminar ds
  head(geiser, 4)  

  #---HISTOGRAMA SENCILLO--------------
  plot <- ggplot(geiser, 
                 aes(x = waiting))
  plot+geom_histogram()  # Por defecto hace 30 divisiones
  plot+geom_histogram(binwidth = 5,  # No. divisiones
                      fill= 'white',  # color interno
                      colour= 'black' # color de borde
                      )
  
  #------------------------------------
  
  #---HISTOGRAMA MEDIANA COMPLEJIDAD CON FRECUENCIAS RELATIVAS--------------
  ggplot(geiser,
         aes(x=waiting,
             y = ..density..))+   # Presenta frecuencas relativas (porcentajes)
    geom_histogram(fill ='cornsilk',  # color de relleno
                   colour = 'grey60',  #color de borde
                   size = 0.2)+   # grosor de las barras
    geom_density(colour= 'blue',linetype = 'dashed') +  # pinta línea de densidad
    xlim(35,105)+ stat_bin(binwidth=4, 
                           geom="text", 
                           aes(label=..count..), 
                             vjust=-1.5) 
  
  #------------------------------------
  