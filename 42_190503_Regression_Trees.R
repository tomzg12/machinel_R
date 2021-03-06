
# Instalaci�n de librer�as

install.packages('rpart')
install.packages('rpart.plot')

library(rpart)
library(rpart.plot)
library(caret)

# Dataset
  bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')

# Partici�n (variable a predecir MEDV - variable de costo prom de vivienda)
  t.id <- createDataPartition(bh$MEDV, 
                            p = 0.7,
                            l = F)
  
  bfit <- rpart(MEDV ~ .,                   # rpart -> �rbol de regresi�n
                data = bh[t.id,])

# Imprime �rbol de regresi�n
  bfit
  
# �rbol de regresi�n gr�fico
  
  par(mfrow=c(1,1))
  
  prp(bfit,
      type= 1,            #Muestra el zoom del �rbol (a partir de que nivel puedes ver)
      nn = T,             #Para que muestre el n�mero de nodos
      fallen.leaves =  T, #Para que aparezcan los nodos hoja alineados y hasta abajo
      faclen =  4,        #Longitud nombres de factores
      varlen = 8,         #Longitud nombres de variables
      shadow.col = 'gray' #Sombra detr�s de cada nodo
  )
  
  
# Variable CPTABLE (muestra resultados comprensibles de los �rboles con diferentes n�meros de nodos, as� como 
                    # promedio y desviaci�n, para cada �rbol)
  bfit$cptable
                # CP -> Factor complejidad del �rbo
                # nsplit -> N�mero de divisiones en el �rbol
  # Se debe sumar el "xerror" + "xstd"
    # buscar el xerror que est� por debajo de la suma anterior
      # Buscar el n�mero de �rbol y utilizar ese
# El siguiente gr�fico muestra que �rbol utilizar
  # Debejo de la l�nea punteada
    plotcp(bfit)
  
# �rbol recortado------------------------------------------------
    
    bfitpruned <- prune(bfit,
                        cp = 0.02804397 ) #Factor de complejidad (tomado del CP de la tabla equivalente al n�mero de �rbol recomendado)

# Sustituir el m�delo de �rbol recortado
    prp(bfitpruned,
        type= 1,            #Muestra el zoom del �rbol (a partir de que nivel puedes ver)
        nn = T,             #Para que muestre el n�mero de nodos
        fallen.leaves =  T, #Para que aparezcan los nodos hoja alineados y hasta abajo
        faclen =  4,        #Longitud nombres de factores
        varlen = 8,         #Longitud nombres de variables
        shadow.col = 'gray', #Sombra detr�s de cada nodo
        roundint = F)
    
# Predecir valores a partir del �rbol recortado-----------------------
    
    # Conjunto de entrenamiento
    preds.t <- predict(bfitpruned, bh[t.id,])
        # C�lculo de los errores 
    sqrt(mean((preds.t-bh[t.id,]$MEDV)^2))
    
    # Conjunto de validaci�n
    preds.v <- predict(bfitpruned, bh[-t.id,])
        # C�lculo de los errores 
        sqrt(mean((preds.v-bh[-t.id,]$MEDV)^2))
    
    # Imprime predicciones
        print(preds.v)
    