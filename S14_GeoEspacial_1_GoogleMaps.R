
# R Google maps 28 junio 2019

library(RgoogleMaps)

# Obtener latitud y longitud (puede ser de google maps)
lat <-  40.689563
lon <- -74.044871

# Ubicación (estatua de la libertad)
uib.map <- GetMap(center = c(lat, lon), # latitud / longitud
                  zoom = 17,            # zoom del mapa (mínimo zoom = 1)
                  API_console_key = 'AIzaSyBWuMsLKZ16kpB6XHWyLpfUpyxZe-7zqiA',    # agregar API de la consola de google
                  destfile = 'G:/Programacion/R_Entrenamiento/mlearningcourseR/gMaps.jpeg', # guardar imagen del mapa
                  format = 'jpeg',  # formato en el que se guarda el mapa (png, pdf)
                  maptype = 'satellite'  # tipo de mapa (satellite, terrain)
                  )

PlotOnStaticMap(uib.map) # Mostrar el mapa



