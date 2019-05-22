
# instalar paquetería
  install.packages(c('fpc','NbClust'))
  install.packages('C:/Users/Admin/Downloads/fpc_2.1-11.2.tar.gz')
  
  library(factoextra) # representaciones gráficas
  library(cluster)
  library(NbClust)  
  
  
  
  protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
  rownames(protein) <- protein$Country  # Convertir columna en indices de filas
  protein$Country = NULL # Eliminar variable
  
  # Escalar
  protein.scaled <- as.data.frame(scale(protein))
  
  
  
  # Calcular el número óptimo de clústers
  nb <- NbClust(protein.scaled,
                distance = 'euclidean',
                min.nc = 2, 
                max.nc = 12, 
                method = 'ward.D2',
                index = 'all')
  # Indica cual es el mejor número de clústers ('among all indices)
      # El más votado (columna de la izquierda te dice el número)
  

    # representación gráfica más tema de ggplot2  
  fviz_nbclust(nb) + theme_minimal()
    # Indica el número óptimo de clústers ( K = 3 en este ejemplo)
  
  
  # Hacer clústerización con K Means
  km.res <- kmeans(protein.scaled, 
                   3   # Número de clústers óptimo calculado
                   )
  
  # Calculo de distancia de los objetos iniciales
  sil.km <- silhouette(km.res$cluster,       # pasar los clústers
                       dist(protein.scaled)) # pasar matriz de distancias del ds
  
  # Resumen del objeto calculado (de distancias)    
  sil.sum <- summary(sil.km)
  sil.sum
  
  # representación de la silueta de un K-means (análisis de la silueta)
  fviz_silhouette(sil.km)
  # ¿Que tan separados están los clústers, uno del otro?
  # para cada uno de los puntos del clústers, la cercanía con los
  # clústers vecinos (se encontrará entre -1 y 1)
  # cuanto más cerca de -1, peor clusterizado y viceversa.
  # Si tiende a 0, podría ser que es un clúster indeciso.
  
  
  
  # Convertir en variable el dataframe de distancias
  dd <- dist(protein.scaled, 
             method = 'euclidean')

  # Utilizar libreria
  pam_stats <- cluster.stats(dd, km.res$cluster)
  
  
  
  