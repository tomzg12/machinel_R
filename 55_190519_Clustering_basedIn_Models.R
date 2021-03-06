

  library(factoextra)
  
  data('multishapes',
       package = 'factoextra')
  
  par(mfrow=c(1,1))
  
  head(multishapes)
  
  dataPoints <- multishapes[,1:2]
  plot(dataPoints)

#Probar con k means (mala distribuci�n original )
  
  km <- kmeans(dataPoints, 5)

  fviz_cluster(km, 
               data = dataPoints) # No pinta una figura adecuada
                                  # El dataset tiene mucho ruido (puntos sueltos)

  # Aqu� no continua, porque se necesita la librer�a fcp, no est� para la versi�n m�s reciente de R
 # dsFit <- dbscan
  
  
#------CLUSTERING BASADOS EN MODELOS-----------

  install.packages('mclust')
  library(mclust)
  
  
  mclust <- Mclust(dataPoints)
  
  # Debemos seleccionar el modelo a representar (gr�fico)
  plot(mclust)

# Resumen de mclust  (crea un modelo gaussiano finito mixto)
summary(mclust)

  # Columna de clasificaci�n (a que cl�ster pertenece cada registro)
  clas <- mclust$classification

    clas



