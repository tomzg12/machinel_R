
library(randomForest)
library(caret)

    #Dataset
    bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')
    
    set.seed(2018)    
    
    t.id <- createDataPartition(bh$MEDV,
                                p = 0.7,
                                list = F)    
    # Bosque aleatorio (construye varios �rboles de regresi�n)
    mod <- randomForest(x = bh[t.id, 1:13], #Var independientes
                        y = bh[t.id, 14],   #Var dependiente
                        ntree = 1000,       #N�mero de �rboles
                        xtest = bh[-t.id, 1:13], #Validaci�n
                        ytest = bh[-t.id, 14],   #Validaci�n
                        importance = T, #�Tiene que computar puntuaciones de cada variable predictora?
                        keep.forest = T)#�Debe quedarse con los �rboles que resulten del modelo?
    
    
    
    
    # Imprime modelo
    mod
    
    # Variable importance (imprime la importancia de cada predictor)
    mod$importance
    
    # Gr�fico (actuales vs predicci�n)
    plot(bh[t.id, ]$MEDV, 
         predict(mod, newdata = bh[t.id, ]),
         xlab = 'Actual',
         ylab = 'Predichos', 
         col = 'blue')
      
    abline(0,1, col = 'red')    
    
# mtry (cuantos predictores en cada una de las divisiones del bosque aleatorio)
    #mtry = m/3, donde m = n�mero de predictores
    #nodesize = 5 (al menos 5 elementos para formar un nodo, si no, desaparece)
    
    
    
    
    
    