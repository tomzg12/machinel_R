
# Instalar paqueter�as
  install.packages('FNN')
  install.packages('dummies')

library(dummies)
library(FNN)    
library(scales)
library(caret)  

# Importar dataset
  edu <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/education.csv')
  
# Creaci�n de variables dummy
  dms <- dummy(edu$region, 
               sep = '')
# Agregar columna de dummys (hacer una columna por regi�n, debido a que es una variable categ�rica)
  edu<- cbind(edu, dms)
  
# Re escalar variables num�ricas (por tener cifras tan grandes)
  edu$urban.s <- rescale(edu$urban)
  edu$income.s <- rescale(edu$income)
  edu$under18.s <- rescale(edu$under18)

# Crear partici�n de los datos
  set.seed(2018)

  # Conjunto de entrenamiento
  t.id <- createDataPartition(edu$expense, 
                              p =0.6, 
                              list = F)  
  tr <- edu[t.id, ]
  
  # Data set temporal
  temp <- edu[-t.id,]

  # Conjunto de validaci�n y testing (fragmentarlo en 2 partes iguales)
  v.id <- createDataPartition(temp$expense,
                              p = 0.5, 
                              list = F)
  
  val <- temp[v.id, ]   # Validaci�n
  test <- temp[-v.id,]  # Testing     


#---- Modelo K-Nearest Neighbors
  # 1a regresi�n------------------------------------------
  reg1 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (constru�das)
                  val[,7:12], # Conjunto de validaci�n columnas 7 a 12 (constru�das) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 1,      # N�mero de vecinos para predecir
                  algorithm = 'brute')
  
  # Utilizando la funci�n para calcular el valor cuadr�tico medio
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
    
    
    # Compila el c�lculo del error cuadr�tico medio             
    cat(paste('El error cuadr�tico medio es de :\n'))
    return(sqrt(mean((actual-predicted)^2)))
  }
  
  #Ejecutar la funci�n para calcular error cuadr�tico medio
  rmse1 <- rmse(reg1$pred, val$expense)
  
  # 2a regresi�n----------------------------
  reg2 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (constru�das)
                  val[,7:12], # Conjunto de validaci�n columnas 7 a 12 (constru�das) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 2,      # N�mero de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la funci�n para calcular error cuadr�tico medio
  rmse2 <- rmse(reg2$pred, val$expense)
  
  # 3a regresi�n----------------------------
  reg3 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (constru�das)
                  val[,7:12], # Conjunto de validaci�n columnas 7 a 12 (constru�das) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 3,      # N�mero de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la funci�n para calcular error cuadr�tico medio
  rmse3 <- rmse(reg3$pred, val$expense)
  
  
  
  # 4a regresi�n----------------------------
  reg4 <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (constru�das)
                  val[,7:12], # Conjunto de validaci�n columnas 7 a 12 (constru�das) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 4,      # N�mero de vecinos para predecir
                  algorithm = 'brute')
  
  #Ejecutar la funci�n para calcular error cuadr�tico medio
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
  

# 5a regresi�n CONJUNTO DE TESTING
  reg.test <- knn.reg(tr[,7:12],  # Conjunto de entrenamiento columnas 7 a 12 (constru�das)
                  test[,7:12], # Conjunto de validaci�n columnas 7 a 12 (constru�das) 
                  tr$expense, # Predecir del conjunto de entrenamiento, la variable "expense"
                  k = 3,      # N�mero de vecinos para predecir
                  algorithm = 'brute')  # Algoritmo para calcular las distancias
  
  #Ejecutar la funci�n para calcular error cuadr�tico medio
  rmse5 <- rmse(reg.test$pred,test$expense )
  
  rmse5
  
  
####----------------Regresi�n sin utilizar conjunto de validaci�n (Menos precisa)
  
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



#----------FUNCI�N PARA REGRESIONES CON KNN---------------

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


  
#---- Funci�n completa (m�ltiples Ks)
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
  
  
  
  # Ejecutar la funci�n
  rdacb.knn.reg.multi(tr[,7:12], 
                val[,7:12],
                tr$expense, 
                val$expense, 
                1, 10)
  
  
  # Dataframe de la predicci�n (valores predichos para conjunto de test)
  df <- data.frame(actual = test$expense, 
                   pred   = reg.test$pred)
  
  plot(df, col = 'red')
  abline(0,1, col = 'blue')  
  