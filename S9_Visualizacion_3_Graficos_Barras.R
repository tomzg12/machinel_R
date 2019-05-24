# Graficos de barra

library(ggplot2)
library(dplyr)

remove(list = c('auto', 'plot'))

bike <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/daily-bike-rentals.csv')

# agregar factores (transformados con otras etiquetas)-----------------
    # columnas categóricas

    bike$season <- factor(bike$season,
                   level = c(1,2,3,4),
                   labels = c('Invierno',
                              'Primavera',
                              'Verano',
                              'Otoño'))
    
    bike$workingday <-factor(bike$workingday, 
                             levels= c(0,1),
                             labels = 'Dia libre',
                             'Dia de trabajo')

    bike$weathersit <- factor(bike$weathersit,
                              levels = c(1,2,3),
                              labels=c('buen tiempo',
                                       'dia nublado',
                                       'mal tiempo'))

  #---------------------------------
  # BAR CHARS
  #---------------------------------
    
      # Transformar los datos (dplyr)
      bike.sum <- bike%>%
                  group_by(season, 
                          workingday)%>%
                              summarize(rental = sum(cnt))
    
      bike.sum
      
      ### Gráfico de barras 1 (sencillo)
      ggplot(bike.sum,
             aes(x= season,
                 y = rental))+
        geom_bar(show.legend = T,  # mostrar leyendas (T = True)
               stat= 'identity' # indica que la Y es una columna del data set (bin)
               )+
        labs(title='Alquileres de bicicletas por estación y día')
      
    
### Gráfico de barras 1 (RELLENO)-------------------------------------------------
      ggplot(bike.sum,
             aes(x= season,
                 y = rental,
                 fill = workingday,   # relleno interior de cada barra (usar variable del df)
                 label = scales::comma(rental)))+
        geom_bar(show.legend = T,  # mostrar leyendas (T = True)
                 stat= 'identity', # indica que la Y es una columna del data set (bin)
                  fill = 'yellow',  # color de relleno
                  colour = 'black')+   # color de borde
        labs(title='Alquileres de bicicletas por estación y día')+
        scale_y_continuous(labels= scales::comma)+
        geom_text(size = 3,
                  position = position_stack((vjust = 0.5))) # Etiquetas y posición de las etiquetas
                                                            # dentro de cada barra
      
      