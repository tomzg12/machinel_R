library(nnet)
library(caret)
library(devtools)

    # Importar dataset
    bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')
    
    # Implementar semilla
    set.seed(2018)
    
    # Crear partición
    t.id <- createDataPartition(bh$MEDV, 
                                p = 0.7,
                                list = F)
    
    # Estadísticos básicos
    summary(bh$MEDV)
    
    # Crea la red neuronal (divide entre 50 med para que quede entre rango 0 y 1)
    fit <- nnet(MEDV/50 ~.,
                data = bh[t.id,], # datos
                size = 6,     # Número de nodos intermedios (entre capa de entrada y salida)
                decay =0.1,   # decaimiento que debe sufrir cada nodo para entrar en uno y salir en otro
                maxit = 1000, # para el proceso si no converge (en ese número de iteraciones)
                linout = T)   # Especifica si queremos una salida lineal en función de parámetros de entrada y no logística (False la devuelve logística)
    
    
    #Libreria para traer URL para graficar la red neuronal
    source_url("https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r")
    
    #Graficar red neuronal
    plot(fit,
         max.sp = T) #Espacio entre variables de entrada, nodos y variable predicha
    
    # Validación cruzada
    
    
    ## Calcular error cuadrático medio con la red neuronal
    sqrt(mean(((fit$fitted.values*50)-bh[t.id,'MEDV'])^2))
    
    ## Predicciones sobre conjunto de validación
    pred <- predict(fit, 
                    bh[-t.id, ])
    
    ## Cálculo de errores al cuadrado (predicción multiplicada por 50 vs reales)
    sqrt(mean((pred*50 - bh[-t.id, 'MEDV'])^2))
  
  