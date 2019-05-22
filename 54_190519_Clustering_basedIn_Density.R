

  library(factoextra)
  
  data('multishapes',
       package = 'factoextra')
  
  par(mfrow=c(1,1))
  
  head(multishapes)
  
  dataPoints <- multishapes[,1:2]
  plot(dataPoints)

#Probar con k means (mala distribución original )
  
  km <- kmeans(dataPoints, 5)

  fviz_cluster(km, 
               data = dataPoints) # No pinta una figura adecuada
                                  # El dataset tiene mucho ruido (puntos sueltos)

  # Aquí no continua, porque se necesita la librería fcp, no está para la versión más reciente de R
  dsFit <- dbscan
  
  
    
  
    