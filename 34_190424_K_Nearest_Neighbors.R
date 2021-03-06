### Carga de librer�as
  install.packages('class')
  library(class)
  library(caret)

### Importar datasets
  vac <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/vacation-trip-classification.csv')
  # La variable a predecir siempre debe ser un factor, los predictores deben ser num�ricos  
  
### Anadir 2 variables (ingresos  y family size) para normalizar los datos
  #1era columna de normalizaci�n
  vac$Income.z <-scale(vac$Income)  #Resta la media y divide por la desviaci�n est�ndar
  #2a columna de normalizaci�n
  vac$Family_size.z <-scale(vac$Family_size)  #Resta la media y divide por la desviaci�n est�ndar

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
  
  
### Predicci�n No. 1 (Sobre conjunto de entrenamiento)
  pred1 <- knn(train[,4:5],    #Predecir conjunto de entrenamiento en funci�n variable 4 y 5 (cols)
               val[,4:5],      #Predecir conjunto de validaci�n en funci�n variable 4 y 5 (cols)
               train[,3],      #Variable de categor�a, los que est�n en la tercera columna
               k = 8)   # El vecino m�s cercano elije (el n�mero de vecinos que elijen)
  
### Matriz de confusi�n (Entre m�s vecinos, la predicci�n es m�s precisa)
  errmat1 <- table(val$Result, 
                   pred1,
                   dnn = c('actual', 'predichos'))
  errmat1

### Predicci�n No.2 (Sobre el conjunto de testing)
  pred2 <- knn(train[,4:5],    #Predecir conjunto de entrenamiento en funci�n variable 4 y 5 (cols)
               test[,4:5],      #Predecir conjunto de validaci�n en funci�n variable 4 y 5 (cols)
               train[,3],      #Variable de categor�a, los que est�n en la tercera columna
               k = 8)   # El vecino m�s cercano elije (el n�mero de vecinos que elijen)

#----------------------------------------------------
  #----- Imprimir predicci�n renombrando columna
  predict2 <- data.frame(pred2)
  names(predict2) <- c('Prediccion')
  predict2
#----- Asignar columna de predicci�n al dataset test
test$Prediccion <- predict2
test
#----------------------------------------------------
  
  ### Matriz de confusi�n (Entre m�s vecinos, la predicci�n es m�s precisa)
  errmat2 <- table(test$Result, 
                   pred2,
                   dnn = c('actual', 'predichos'))
  errmat2

  plot(pred2)  

#....................................................................................................................
### Funci�n de automatizaci�n de K-Nearest Neighbors
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
     cat(paste('Matriz de confusi�n para k=', k, '\n'))
     cat('========================================\n')
     print(tab)
     cat('========================================\n')
    }
  }

  
# Ejecutar funci�n  para imprimir matriz de confusi�n----------------------------------------
  
  knn.automate(train[,4:5],  # Predictores del conjunto de entrenamiento
               val[,4:5],  # Predictores del conjunto de validaci�n
              train[,3], # Columna a predecir conjunto de entrenamiento
              val[,3], # Columna a predecir conjunto de validaci�n
              1, 8 )   # Cantidad de vecinos que seleccionar�n (desde, hasta)
  
  
  
  
# Funci�n TRAINCONTROL DEL PAQUETE CARET PARA SABER CUAL ES EL N�MERO DE VECINOS QUE PREDICEN MEJOR
  # Dato de control
  trcntrl <- trainControl(method="repeatedcv", number = 10, repeats = 3)
  
  caret_knn_fit <- train(Result ~ Family_size + Income, 
                         data = train,
                         method = "knn", 
                         trControl = trcntrl,
                         preProcess = c("center", "scale"),
                         tuneLength = 10)
  

  caret_knn_fit
  # El resultado dice que con 13 K (vecinos), el accuracy es de 85 % ( y es el m�ximo)
  
  
  # Predicci�n con K =5
  pred5 <- knn(train[,4:5], 
               val[,4:5],
               train[,3],
               k = 5,
               prob = T)

  