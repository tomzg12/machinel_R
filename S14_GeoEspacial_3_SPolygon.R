# Ficheros ESRI  11-07-2019
    install.packages('sp')
    install.packages('rgdal')
    
    library(sp)
    library(rgdal)    

    # Carga de datasets
    countries.sp <- readOGR('G:/BD/GitHub/mlearningcourseR/r-course/data/tema12/natural_earth',
                            layer = 'ne_50m_admin_0_countries')
    
    airports.sp <- readOGR('G:/BD/GitHub/mlearningcourseR/r-course/data/tema12/natural_earth',
                            layer = 'ne_50m_airports')
    # Tipo de datos
    class(countries.sp)
    class(airports.sp) 
    
    # Representar los pol�gonos espaciales
    plot(countries.sp)
  
    # En funci�n a la variable admin, pinta un color para cada pais
    plot(countries.sp, 
       col = countries.sp@data$admin)
    
    # Nuevo mapa de aeropuestos (ADD = TRUE sobrepone los mapas)
      #El mapa de aeropuertos sobre el mapa de pa�ses
    plot(airports.sp, add = TRUE)
    
    # Agregar una nueva variable (en este caso economia de cada pa�s)
    spplot(countries.sp, c('economy'))
    
    # Agregar una nueva variable con la poblaci�n estimada
    spplot(countries.sp, c('pop_est'))
    
    # Agregar una nueva variable con el continente
    spplot(countries.sp, c('continent'))
    
    #Lista de atributos de la tabla    
    str(countries.sp@data)
  