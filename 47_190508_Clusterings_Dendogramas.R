
  # Carga de dataset
  protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
      # Todas las variables son num�ricas excepto "country"
  
  # Escalar todas las columnas, excepto "Country" que es la columna 1 y
    # construir un nuevo dataframe
  data <- as.data.frame(scale(protein[,-1])) # Todas las filas, menos una columna
  
  # Agregar columna country al DF escalado
  data$Country = protein$Country
  
  # Establecer nombre de columnas (columna "Country")
  rownames(data) = data$Country
  
  #Cl�stering 1
  hc <- hclust(dist(data, 
                    method = 'euclidean'), 
                    method = 'ward.D2')  # euclidea, ward, etc.  (distancias en R red. dist)
  
  # Cl�ster creado (jer�rquico) - M�todo de Ward
  hc
  
  # Graficar cl�ster
  plot(hc,
       hang = -0.01, 
       cex = 0.7)
  
  #Cl�stering 2 (M�todo "single")
  hc2 <- hclust(dist(data, 
                    method = 'euclidean'), # euclidea, manhattan, etc.  (distancias en R red. dist)
               method = 'single')  # complete / single / average / ward.D2
  
  # Cl�ster creado (jer�rquico) - M�todo de Ward
  hc2
  
  
  # Funci�n merge
  hc2$merge # Dice cuales se juntaron
  
  # Graficar cl�ster
  plot(hc2,
       #hang = -0.01, # El hang cuelga a todos en el mismo sitio
       cex = 0.7)  # Disminuye o aumenta el tama�o de la fuente
  
  # Construir matriz de distancias
  d <- dist(data, 
            method = 'euclidean')

  # Imprime matriz
  d
  
  # Extraer filas para calcular la distancia manualmente
  alb <- data['Albania', -10]  # Quitar �ltima columna
  aus <- data['Austria', -10]  # Quitar �ltima columna
    
    # Calcular la distancia manualmente (m�todo euclideano)
    sqrt(sum((alb-aus)^2))
    
    # Calcular la distancia manualmente (m�todo manhattan)
    sum(abs(alb-aus))
    
    
    