library(nnet)
library(caret)
library(devtools)

    # Importar dataset
    bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')
    
    # Implementar semilla
    set.seed(2018)
    
    # Crear partici�n
    t.id <- createDataPartition(bh$MEDV, 
                                p = 0.7,
                                list = F)
    
    # Estad�sticos b�sicos
    summary(bh$MEDV)
    
    # Crea la red neuronal (divide entre 50 med para que quede entre rango 0 y 1)
    fit <- nnet(MEDV/50 ~.,
                data = bh[t.id,], # datos
                size = 6,     # N�mero de nodos intermedios (entre capa de entrada y salida)
                decay =0.1,   # decaimiento que debe sufrir cada nodo para entrar en uno y salir en otro
                maxit = 1000, # para el proceso si no converge (en ese n�mero de iteraciones)
                linout = T)   # Especifica si queremos una salida lineal en funci�n de par�metros de entrada y no log�stica (False la devuelve log�stica)
    
    
    #Libreria para traer URL para graficar la red neuronal
    source_url("https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r")
    
    #Graficar red neuronal
    plot(fit,
         max.sp = T) #Espacio entre variables de entrada, nodos y variable predicha
    
    # Validaci�n cruzada
    
    
    ## Calcular error cuadr�tico medio con la red neuronal
    sqrt(mean(((fit$fitted.values*50)-bh[t.id,'MEDV'])^2))
    
    ## Predicciones sobre conjunto de validaci�n
    pred <- predict(fit, 
                    bh[-t.id, ])
    
    ## C�lculo de errores al cuadrado (predicci�n multiplicada por 50 vs reales)
    sqrt(mean((pred*50 - bh[-t.id, 'MEDV'])^2))
  
  