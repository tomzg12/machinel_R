
# Instalar paqueterías
  install.packages('FNN')
  install.packages('dummies')

library(dummies)
library(FNN)    
library(scales)
library(caret)  

# Importar dataset
  edu <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/education.csv')
  
# Creación de variables dummy
  dms <- dummy(edu$region, 
               sep = '')
# Agregar columna de dummys (hacer una columna por región, debido a que es una variable categórica)
  edu<- cbind(edu, dms)
  
# Re escalar variables numéricas (por tener cifras tan grandes)
  edu$urban.s <- rescale(edu$urban)
  edu$income.s <- rescale(edu$income)
  edu$under18.s <- rescale(edu$under18)

# Crear partición de los datos
  set.seed(2018)

  # Conjunto de entrenamiento
  t.id <- createDataPartition(edu$expense, 
                              p =0.6, 
                              list = F)  
  tr <- edu[t.id, ]
  
  # Data set temporal
  temp <- edu[-t.id,]

  # Conjunto de validación y testing (fragmentarlo en 2 partes iguales)
  v.id <- createDataPartition(temp$expense,
                              p = 0.5, 
                              list = F)
  
  val <- temp[v.id, ]   # Validación
  test <- temp[-v.id,]  # Testing     


#---- Modelo K-Nearest Neighbors
  # 1a regresión------------------------------------------
  reg1 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (construídas)
                  val[,7:12], # Conjunto de validación columnas 7 a 12 (construídas) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 1,      # Número de vecinos para predecir
                  algorithm = 'brute')
  
  # Utilizando la función para calcular el valor cuadrático medio
  rmse <- function(actual, predicted){
    
    # Compila la media de las dos columnas
    cat(paste('La media del valor actual es de : \n'))
    print(mean(actual))
    # Imprime espacio
    cat(paste('\n'))
    cat(paste('La media del valor predicho es de :\n'))
    print(mean(predicted))
    # Imprime espacio
    cat(paste('\n'))
    
    
    # Compila el cálculo del error cuadrático medio             
    cat(paste('El error cuadrático medio es de :\n'))
    return(sqrt(mean((actual-predicted)^2)))
  }
  
  #Ejecutar la función para calcular error cuadrático medio
  rmse1 <- rmse(reg1$pred, val$expense)
  
  # 2a regresión----------------------------
  reg2 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (construídas)
                  val[,7:12], # Conjunto de validación columnas 7 a 12 (construídas) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 2,      # Número de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la función para calcular error cuadrático medio
  rmse2 <- rmse(reg2$pred, val$expense)
  
  # 3a regresión----------------------------
  reg3 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (construídas)
                  val[,7:12], # Conjunto de validación columnas 7 a 12 (construídas) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 3,      # Número de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la función para calcular error cuadrático medio
  rmse3 <- rmse(reg3$pred, val$expense)
  
  
  
  # 4a regresión----------------------------
  reg4 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (construídas)
                  val[,7:12], # Conjunto de validación columnas 7 a 12 (construídas) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 4,      # Número de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la función para calcular error cuadrático medio
  rmse4 <- rmse(reg4$pred, val$expense)

  
# Crear vector de errores
  errors <- c(rmse1, 
              rmse2, 
              rmse3, 
              rmse4)
  
  # Graficar vector de errores para saber con cuantos vecinos se predice mejor
  plot(errors,
       type = 'o',
       xlab = 'k',
       ylab = 'RMSE',
       col = 'red')
  

# 5a regresión CONJUNTO DE TESTING
  reg.test <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (construídas)
                  test[,7:12], # Conjunto de validación columnas 7 a 12 (construídas) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 3,      # Número de vecinos para predecir
                  algorithm = 'brute')  # Algoritmo para calcular las distancias
  
  #Ejecutar la función para calcular error cuadrático medio
  rmse5 <- rmse(reg.test$pred,test$expense )
  
  rmse5
  
  
####----------------Regresión sin utilizar conjunto de validación (Menos precisa)
  
  t.ids <- createDataPartition(edu$expense,
                               p = 0.7,
                               l = F)
  
  tr <- edu[t.ids,]  
  val<-edu[-t.ids,]  

  reg <- knn.reg(tr[,7:12],
                 test = NULL,
                 y = tr$expense,
                 k = 3,
                 algorithm = 'brute') 
  
  rmse.reg <- sqrt(mean(reg$residuals^2))
  rmse.reg



#----------FUNCIÓN PARA REGRESIONES CON KNN---------------

rdacb.knn.reg <- function(tr_predictor, val_predictors,
                          tr_target, val_target, k){
  library(FNN)
  res<- knn.reg(tr_predictor, 
                val_predictors,
                tr_target, 
                k,
                algorithm = 'brute')
  
  rmserror <- sqrt(mean((val_target-res$pred)^2))
  cat(paste('RMSE para k = ', toString(k), ":", '\n' , rmserror, '\n' ,sep = ''))
  rmserror
}


  
#---- Función completa (múltiples Ks)
  rdacb.knn.reg.multi <- function(tr_predictor, val_predictors,
                            tr_target, val_target, start_k, end_k){
    
    rms_errors <- vector()
    for (k in start_k:end_k){
      rms_error <- rdacb.knn.reg(tr_predictor, val_predictors,
                                 tr_target, val_target, k)
      rms_errors <- c(rms_errors, rms_error)
    }
    plot(rms_errors, 
         type = 'o',
         xlab = 'k',
         ylab = 'RMSE'
         )
  }
  
  
  
  # Ejecutar la función
  rdacb.knn.reg.multi(tr[,7:12], 
                val[,7:12],
                tr$expense, 
                val$expense, 
                1, 10)
  
  
  # Dataframe de la predicción (valores predichos para conjunto de test)
  df <- data.frame(actual = test$expense, 
                   pred   = reg.test$pred)
  
  plot(df, col = 'red')
  abline(0,1, col = 'blue')  
  