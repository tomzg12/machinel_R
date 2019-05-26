# Plot Multivariante

  install.packages('GGally')  
  library(ggplot2)
  library(GGally)
  
  
  bike <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/daily-bike-rentals.csv')
  head(bike)  

  
  # Convertir números en factores
  bike$season = factor(bike$season,
                       levels = c(1,2,3,4),
                       labels = c('Invierno','Primavera',
                                  'Verano','Otoño'))  

  bike$weathersit <- factor(bike$weathersit,
                            levels = c(1,2,3),
                            labels = c('Despejado','Nublado','Lluvia'))  

  
  bike$weekday <- factor(bike$weekday,
                         levels=0:6,
                         labels = c('D', 'L',
                                    'M','X',
                                    'J','V','S'))
  
  # Histograma  
  hist(bike$windspeed)
  
  # Cortar datos de una columna agregando factores y ponerlos en otra
  bike$windspeed.fac <- cut(bike$windspeed, 
                            breaks = 5,
                            labels = c('baja_vel',
                                       'Mediana_vel',
                                       'Mediana_al',
                                       'alta_vel',
                                       'muy_alta_vel'))

  head(bike)  
  
  # Gráfico multivariante
  ggplot(bike,
         aes(x = temp, 
             y = cnt))+
    geom_point(size =3,
               aes(color = windspeed.fac))+
                 theme(legend.position = 'bottom')+
    geom_smooth(method = 'gam',
                 se = T,  # intervalo de confianza de la regresión
                 col='red')+
    facet_grid(weekday~season)  # para hacer varias dimensiones
    
  
#-------------------2o EJERCICIO
  
  auto<- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/auto-mpg.csv',
                  stringsAsFactors = F)

  auto$cylinders <- factor(auto$cylinders,
                           labels = c('3C','4c','5c','6c','8c'))

  # Crear gráficos con GALLY  
  ggpairs(auto[,2:5],  #<--- CANTIDAD DE VARIABLES A AÑADIR
          aes(colour= cylinders, 
              alpha = 0.4),
          title='Analisis multivariante',# Título
          upper=list(continuous = 'density'), # combinar variable de densidad
          lower=list(combo='denstrip'))+  # combinar continuas vs categóricas (mpg vs cyl, ejemplo)
    theme(plot.title = element_text(hjust=0.5)) # Justificado horizontal
  