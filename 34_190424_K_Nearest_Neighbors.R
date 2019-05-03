### Carga de librerías
  install.packages('class')
  library(class)
  library(caret)

### Importar datasets
  vac <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/vacation-trip-classification.csv')
  # La variable a predecir siempre debe ser un factor, los predictores deben ser numéricos  
  
### Anadir 2 variables (ingresos  y family size) para normalizar los datos
  #1era columna de normalización
  vac$Income.z <-scale(vac$Income)  #Resta la media y divide por la desviación estándar
  #2a columna de normalización
  vac$Family_size.z <-scale(vac$Family_size)  #Resta la media y divide por la desviación estándar

### Establecer semilla
  set.seed(2018)

### Trainings IDs (3 particiones)
  # Conjunto de testing
  t.ids <-createDataPartition(vac$Result, 
                              p = 0.5, 
                              list = F
                              )
  # Conjunto de entrenamiento
  train <- vac[t.ids,]
  
          # Array temporal para crear 2 nuevos sets(validacion y test)
          temp <- vac[-t.ids,]
  
  # Conjunto de validaciones a partir del 50 % creado en temp
  v.ids <- createDataPartition(temp$Result, 
                               p = 0.5, 
                               list = F)
  val <- temp[v.ids,]
  test <- temp[-v.ids,]
  
  
### Predicción No. 1 (Sobre conjunto de entrenamiento)
  pred1 <- knn(train[,4:5],    #Predecir conjunto de entrenamiento en función variable 4 y 5 (cols)
               val[,4:5],      #Predecir conjunto de validación en función variable 4 y 5 (cols)
               train[,3],      #Variable de categoría, los que están en la tercera columna
               k = 8)   # El vecino más cercano elije (el número de vecinos que elijen)
  
### Matriz de confusión (Entre más vecinos, la predicción es más precisa)
  errmat1 <- table(val$Result, 
                   pred1,
                   dnn = c('actual', 'predichos'))
  errmat1

### Predicción No.2 (Sobre el conjunto de testing)
  pred2 <- knn(train[,4:5],    #Predecir conjunto de entrenamiento en función variable 4 y 5 (cols)
               test[,4:5],      #Predecir conjunto de validación en función variable 4 y 5 (cols)
               train[,3],      #Variable de categoría, los que están en la tercera columna
               k = 8)   # El vecino más cercano elije (el número de vecinos que elijen)

#----------------------------------------------------
  #----- Imprimir predicción renombrando columna
  predict2 <- data.frame(pred2)
  names(predict2) <- c('Prediccion')
  predict2
#----- Asignar columna de predicción al dataset test
test$Prediccion <- predict2
test
#----------------------------------------------------
  
  ### Matriz de confusión (Entre más vecinos, la predicción es más precisa)
  errmat2 <- table(test$Result, 
                   pred2,
                   dnn = c('actual', 'predichos'))
  errmat2

  plot(pred2)  

#....................................................................................................................
### Función de automatización de K-Nearest Neighbors
  knn.automate <- function(tr_predictors,
                           val_predictors,
                           tr_target,
                           val_target,
                           start_k,
                           end_k){
    for (k in start_k:end_k){
      pred<-knn(tr_predictors, val_predictors, 
                tr_target, k)
     tab <- table(val_target, pred, dnn = c('actual', 'predichos'))
     cat(paste('Matriz de confusión para k=', k, '\n'))
     cat('========================================\n')
     print(tab)
     cat('========================================\n')
    }
  }

  
# Ejecutar función  para imprimir matriz de confusión----------------------------------------
  
  knn.automate(train[,4:5],  # Predictores del conjunto de entrenamiento
               val[,4:5],  # Predictores del conjunto de validación
              train[,3], # Columna a predecir conjunto de entrenamiento
              val[,3], # Columna a predecir conjunto de validación
              1, 8 )   # Cantidad de vecinos que seleccionarán (desde, hasta)
  
  
  
  
# Función TRAINCONTROL DEL PAQUETE CARET PARA SABER CUAL ES EL NÚMERO DE VECINOS QUE PREDICEN MEJOR
  # Dato de control
  trcntrl <- trainControl(method="repeatedcv", number = 10, repeats = 3)
  
  caret_knn_fit <- train(Result ~ Family_size + Income, 
                         data = train,
                         method = "knn", 
                         trControl = trcntrl,
                         preProcess = c("center", "scale"),
                         tuneLength = 10)
  

  caret_knn_fit
  # El resultado dice que con 13 K (vecinos), el accuracy es de 85 % ( y es el máximo)
  
  
  # Predicción con K =5
  pred5 <- knn(train[,4:5], 
               val[,4:5],
               train[,3],
               k = 5,
               prob = T)

  