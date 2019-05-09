# Predictores categóricos (Árbol de regresión)
library(caret)
library(rpart)
library(rpart.plot)

    # Carga del dataset
    edu <-read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/education.csv')
    
    # Conversión a factor columna de región        
    edu$region <- factor(edu$region)
    
    # Elegir datos de entrenamiento
    t.id<- createDataPartition(edu$expense, 
                               p = 0.7,
                               list = F)
    # Modelo ajustado
    fit <- rpart(expense ~ region+urban+income+under18,
                 data =edu[t.id,])

    # Árbol de regresión
    prp(fit, 
        type = 2,
        nn = T,
        fallen.leaves = T,
        faclen = 4,
        varlen = 8,
        shadow.col = 'gray')
    
#Árbol de regresión con el métido de ensamblaje (bagging and boosting)
    
# Bagging<--------------(efectivo para métodos de alta varianza)
    install.packages('ipred')
    library(ipred)
        
    # Dataset
    bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/BostonHousing.csv')
    
    # Partición (variable a predecir MEDV - variable de costo prom de vivienda)
    t.id_bh <- createDataPartition(bh$MEDV, 
                                p = 0.7,
                                l = F)
    ## Ajustar con bagging
    bagging.fit <- bagging(MEDV~.,
                           data = bh[t.id_bh,])
    ## Predicción con bagging
    prediction.t <- predict(bagging.fit,
                            bh[t.id_bh,])
    # Cálculo de errores
    sqrt(mean((prediction.t-bh[t.id_bh,]$MEDV)^2))

    
# Boosting<--------------(efectivo para métodos de alta varianza)
    install.packages('gbm') #gradient booster machine
    library(gbm)    

    gbm.fit  <- gbm(MEDV ~.,
                    data = bh[t.id_bh, ],
                    distribution = 'gaussian')
    #prediction
    prediction.b <- predict(gbm.fit, 
                            bh[t.id_bh,], type = 'link',  
                            single.tree = F,
                            n.trees = 100)
    
    sqrt(mean((prediction.b-bh[t.id_bh,]$MEDV)^2))        
        