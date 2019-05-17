
  # Carga de dataset
  protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
      # Todas las variables son numéricas excepto "country"
  
  # Escalar todas las columnas, excepto "Country" que es la columna 1 y
    # construir un nuevo dataframe
  data <- as.data.frame(scale(protein[,-1])) # Todas las filas, menos una columna
  
  # Agregar columna country al DF escalado
  data$Country = protein$Country
  
  # Establecer nombre de columnas (columna "Country")
  rownames(data) = data$Country
  
  #Clústering 1
  hc <- hclust(dist(data, 
                    method = 'euclidean'), 
                    method = 'ward.D2')  # euclidea, ward, etc.  (distancias en R red. dist)
  
  # Clúster creado (jerárquico) - Método de Ward
  hc
  
  # Graficar clúster
  plot(hc,
       hang = -0.01, 
       cex = 0.7)
  
  #Clústering 2 (Método "single")
  hc2 <- hclust(dist(data, 
                    method = 'euclidean'), # euclidea, manhattan, etc.  (distancias en R red. dist)
               method = 'single')  # complete / single / average / ward.D2
  
  # Clúster creado (jerárquico) - Método de Ward
  hc2
  
  
  # Función merge
  hc2$merge # Dice cuales se juntaron
  
  # Graficar clúster
  plot(hc2,
       #hang = -0.01, # El hang cuelga a todos en el mismo sitio
       cex = 0.7)  # Disminuye o aumenta el tamaño de la fuente
  
  # Construir matriz de distancias
  d <- dist(data, 
            method = 'euclidean')

  # Imprime matriz
  d
  
  # Extraer filas para calcular la distancia manualmente
  alb <- data['Albania', -10]  # Quitar última columna
  aus <- data['Austria', -10]  # Quitar última columna
    
    # Calcular la distancia manualmente (método euclideano)
    sqrt(sum((alb-aus)^2))
    
    # Calcular la distancia manualmente (método manhattan)
    sum(abs(alb-aus))
    
    
    