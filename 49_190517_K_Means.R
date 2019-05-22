
library(devtools)

    protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
      rownames(protein) <- protein$Country  # Convertir columna en indices de filas
      protein$Country = NULL # Eliminar variable
      
      # Escalar
      protein.scaled <- as.data.frame(scale(protein))
    
      
      # Liberaría para representar gráficamente los clústers generados por K-means
      devtools::install_github('kassambara/factoextra')  
      
      
      # Ver tabla
      View(protein.scaled)
      
      # Correr algoritmo k means
      km <- kmeans(protein.scaled,
                    4)
      
      # Devuelve la lista con el cluster al que pertenece
      km
      
      
      # Agrupar por medias de las variables
      aggregate(protein.scaled, 
                by = list(cluster = km$cluster),
                mean)
      
      
      library(factoextra)
      fviz_cluster(km,
                   data = protein.scaled)      
      
      
      