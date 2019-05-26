#Heat map

    # Instalación de paquetes
    install.packages(c('ggmap', 'maps'))0
    library(ggmap)
    
    # datos con latitud y altitud (dataframe)
    tartu.data <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/tartu_housing.csv', 
                           sep = ';')
    
    # vista previa dataframe
    head(tartu.data)    
    
    # Clave desde la plataforma de google
    register_google(key = 'AIzaSyBWuMsLKZ16kpB6XHWyLpfUpyxZe-7zqiA')
    
    # Mapa (definir)
    tartu.map <- get_map(location = 'tartu',  # Locación
                         maptype = 'satellite',  # tipo de vista (hibrido)
                         zoom = 12)  # Zoom de mapa
    
    # Mapa (visualizar)
    ggmap(tartu.map,
          extent = 'device')
    
    # Añadir al mapa datos (MAPA 1)
    ggmap(tartu.map,
          extent = 'device')+
      geom_point(data = tartu.data, 
                 aes(x = lon,
                     y = lat),
                 colour = 'red',
                 alpha = 0.12,
                 size = 2)
    
#-----------------------2o MAPA-------------------------
    
    
    tartu.map2 <- get_map(location = 'tartu',  # Locación
                         zoom = 15)  # Zoom de mapa
    
    # Mostrar mapa nuevamente
    ggmap(tartu.map2, 
          extent = 'device')+
      geom_density2d(data = tartu.data,
                     aes(x= lon,
                         y= lat),
                     size = .3)+
      stat_density2d(data = tartu.data, 
                     aes(x= lon,
                         y= lat,
                     fill = ..level..,
                     alpha= ..level..),
    size = 0.01, bins=16, geom = 'polygon')+
      scale_fill_gradient(low ='green',
                          high = 'red')+
      scale_alpha(range=c(0,0.25), guide=F)
    