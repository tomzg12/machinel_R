
# instalar paqueter�a
  install.packages(c('fpc','NbClust'))
  install.packages('C:/Users/Admin/Downloads/fpc_2.1-11.2.tar.gz')
  
  library(factoextra) # representaciones gr�ficas
  library(cluster)
  library(NbClust)  
  
  
  
  protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
  rownames(protein) <- protein$Country  # Convertir columna en indices de filas
  protein$Country = NULL # Eliminar variable
  
  # Escalar
  protein.scaled <- as.data.frame(scale(protein))
  
  
  
  # Calcular el n�mero �ptimo de cl�sters
  nb <- NbClust(protein.scaled,
                distance = 'euclidean',
                min.nc = 2, 
                max.nc = 12, 
                method = 'ward.D2',
                index = 'all')
  # Indica cual es el mejor n�mero de cl�sters ('among all indices)
      # El m�s votado (columna de la izquierda te dice el n�mero)
  

    # representaci�n gr�fica m�s tema de ggplot2  
  fviz_nbclust(nb) + theme_minimal()
    # Indica el n�mero �ptimo de cl�sters ( K = 3 en este ejemplo)
  
  
  # Hacer cl�sterizaci�n con K Means
  km.res <- kmeans(protein.scaled, 
                   3   # N�mero de cl�sters �ptimo calculado
                   )
  
  # Calculo de distancia de los objetos iniciales
  sil.km <- silhouette(km.res$cluster,       # pasar los cl�sters
                       dist(protein.scaled)) # pasar matriz de distancias del ds
  
  # Resumen del objeto calculado (de distancias)    
  sil.sum <- summary(sil.km)
  sil.sum
  
  # representaci�n de la silueta de un K-means (an�lisis de la silueta)
  fviz_silhouette(sil.km)
  # �Que tan separados est�n los cl�sters, uno del otro?
  # para cada uno de los puntos del cl�sters, la cercan�a con los
  # cl�sters vecinos (se encontrar� entre -1 y 1)
  # cuanto m�s cerca de -1, peor clusterizado y viceversa.
  # Si tiende a 0, podr�a ser que es un cl�ster indeciso.
  
  
  
  # Convertir en variable el dataframe de distancias
  dd <- dist(protein.scaled, 
             method = 'euclidean')

  # Utilizar libreria
  pam_stats <- cluster.stats(dd, km.res$cluster)
  
  
  
  