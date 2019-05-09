
library(randomForest)
library(caret)

    #Dataset
    bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')
    
    set.seed(2018)    
    
    t.id <- createDataPartition(bh$MEDV,
                                p = 0.7,
                                list = F)    
    # Bosque aleatorio (construye varios árboles de regresión)
    mod <- randomForest(x = bh[t.id, 1:13], #Var independientes
                        y = bh[t.id, 14],   #Var dependiente
                        ntree = 1000,       #Número de árboles
                        xtest = bh[-t.id, 1:13], #Validación
                        ytest = bh[-t.id, 14],   #Validación
                        importance = T, #¿Tiene que computar puntuaciones de cada variable predictora?
                        keep.forest = T)#¿Debe quedarse con los árboles que resulten del modelo?
    
    
    
    
    # Imprime modelo
    mod
    
    # Variable importance (imprime la importancia de cada predictor)
    mod$importance
    
    # Gráfico (actuales vs predicción)
    plot(bh[t.id, ]$MEDV, 
         predict(mod, newdata = bh[t.id, ]),
         xlab = 'Actual',
         ylab = 'Predichos', 
         col = 'blue')
      
    abline(0,1, col = 'red')    
    
# mtry (cuantos predictores en cada una de las divisiones del bosque aleatorio)
    #mtry = m/3, donde m = número de predictores
    #nodesize = 5 (al menos 5 elementos para formar un nodo, si no, desaparece)
    
    
    
    
    
    