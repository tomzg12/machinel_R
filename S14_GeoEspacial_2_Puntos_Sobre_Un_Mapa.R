
# 09-07-2019
# Representar puntos sobre un mapa


  library(RgoogleMaps)
  
  # Contiene códigos postales de USA 
  wages <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema12/nj-wages.csv')  
  
  head(wages)
  
  # Agregar columna calculando los cuartiles
  wages$wgClass <- cut(wages$Avgwg, 
                       quantile(wages$Avgwg, 
                                probs = seq(0, 1, 0.2)),
                       labels = F, 
                       include.lowest = T) # Si alguno cae en el corte, se ponga en el grupo inferior
  
  head(wages)  
  
  # paleta de colores
  pal <- palette(rainbow(5))  # El 5 representa la selección de 5 colores para los cortes de cuantil
  
  # crear variable mapa (en este caso utilizamos Nueva Jersey)
   # Variables
    zoom = 8
    lat = 40.155
    lon = -74.715
 
    
  map <- GetMap(center = c(lat, lon),
                API_console_key = 'AIzaSyBWuMsLKZ16kpB6XHWyLpfUpyxZe-7zqiA',
                zoom = zoom)
                       # agregar API de la consola de google
  
  PlotOnStaticMap(map, lat, lon)
  
  
  
  