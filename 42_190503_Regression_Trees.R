
# Instalación de librerías

install.packages('rpart')
install.packages('rpart.plot')

library(rpart)
library(rpart.plot)
library(caret)

# Dataset
  bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')

# Partición (variable a predecir MEDV - variable de costo prom de vivienda)
  t.id <- createDataPartition(bh$MEDV, 
                            p = 0.7,
                            l = F)
  
  bfit <- rpart(MEDV ~ .,                   # rpart -> árbol de regresión
                data = bh[t.id,])

# Imprime árbol de regresión
  bfit
  
# Árbol de regresión gráfico
  
  par(mfrow=c(1,1))
  
  prp(bfit,
      type= 1,            #Muestra el zoom del árbol (a partir de que nivel puedes ver)
      nn = T,             #Para que muestre el número de nodos
      fallen.leaves =  T, #Para que aparezcan los nodos hoja alineados y hasta abajo
      faclen =  4,        #Longitud nombres de factores
      varlen = 8,         #Longitud nombres de variables
      shadow.col = 'gray' #Sombra detrás de cada nodo
  )
  
  
# Variable CPTABLE (muestra resultados comprensibles de los árboles con diferentes números de nodos, así como 
                    # promedio y desviación, para cada árbol)
  bfit$cptable
                # CP -> Factor complejidad del árbo
                # nsplit -> Número de divisiones en el árbol
  # Se debe sumar el "xerror" + "xstd"
    # buscar el xerror que esté por debajo de la suma anterior
      # Buscar el número de árbol y utilizar ese
# El siguiente gráfico muestra que árbol utilizar
  # Debejo de la línea punteada
    plotcp(bfit)
  
# Árbol recortado------------------------------------------------
    
    bfitpruned <- prune(bfit,
                        cp = 0.02804397 ) #Factor de complejidad (tomado del CP de la tabla equivalente al número de árbol recomendado)

# Sustituir el módelo de árbol recortado
    prp(bfitpruned,
        type= 1,            #Muestra el zoom del árbol (a partir de que nivel puedes ver)
        nn = T,             #Para que muestre el número de nodos
        fallen.leaves =  T, #Para que aparezcan los nodos hoja alineados y hasta abajo
        faclen =  4,        #Longitud nombres de factores
        varlen = 8,         #Longitud nombres de variables
        shadow.col = 'gray', #Sombra detrás de cada nodo
        roundint = F)
    
# Predecir valores a partir del árbol recortado-----------------------
    
    # Conjunto de entrenamiento
    preds.t <- predict(bfitpruned, bh[t.id,])
        # Cálculo de los errores 
    sqrt(mean((preds.t-bh[t.id,]$MEDV)^2))
    
    # Conjunto de validación
    preds.v <- predict(bfitpruned, bh[-t.id,])
        # Cálculo de los errores 
        sqrt(mean((preds.v-bh[-t.id,]$MEDV)^2))
    
    # Imprime predicciones
        print(preds.v)
    