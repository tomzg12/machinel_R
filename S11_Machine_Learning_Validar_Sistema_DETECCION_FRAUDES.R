# Genera información sintética (simulada) función DMWR - SMOTE
# 05-06-2019

        # Librerías
          library(caret)
          install.packages(c('pROC', 'DMwR','caTools'))
          library(pROC)
          library(DMwR)
          library(caTools)
          
          
        # Dataset
            #Descomprimir
          zipF <- ('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/creditcard.csv.zip')
          outdir <- ('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8')
          unzip(zipF, exdir = outdir)
          
          # Datos de tarjetas de crédito
          ccdata <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/creditcard.csv')
            
          head(ccdata)
          
          # Convertir una columna (class) en factores (se refiere a si es fraudulenta actualmente o no)
          ccdata$Class <- factor(ifelse(
            ccdata$Class==0,'0','1'
          ))
          
          # Revisar la columna en una tabla (cuenta por factor)
          table(ccdata$Class)
          
          # Sets de entrenamiento y validación
          t.id <- createDataPartition(ccdata$Class,
                                      p = 0.4,
                                      list = F,
                                      times = 1
                                      )
          training <- ccdata[t.id, ]
          test <- ccdata[-t.id,]
                    
          # Table de  training
          table(training$Class)
          table(test$Class)          
          
          # Simular tarjetas de crédito fraudulentas con función SMOTE
          training <- SMOTE(Class~.,
                           training, 
                           perc.over =100,     #casos extras a la clase minoritaria
                          perc.under = 200)    #casos extras de la clase mayoritaria

          table(training$Class)          
          
          # Convertir en numérica nuevamente la columna CLASS
          training$Class <- as.numeric(training$Class)

          trControl <- trainControl(method = 'cv',
                                    number = 10)   
          
          # Crear modelo
          model <- train(Class~.,
                         data = training, 
                         method = 'treebag',
                         trControl = trControl)
          
          
          model
          model$results
                coef(model)
                summary(model)
          
          # Variables predictoras (excluye la variable class, que se debe predecir)
          predictors <- names(training)[names(training)!='Class']

          # predicción
          pred <- predict(model$finalModel, 
                          test[,predictors])                    

          #Curva ROC (en cuantos casos se acertó y en cuantos se falló)
          auc <- roc(test$Class,
                     pred)
          auc
          
          # Graficar curva ROC (matriz de confusión)
          plot(auc,
               ylimit =c(0,1),   # define límites de eje Y
               print.thres = T,   # imprime el valor más óptimo
               main = paste('AUC con SMOTE: ', round(auc$auc[[1]],2))
               )
          abline(h=1,
                 col = 'green',
                 lwd = 2)
                    
          abline(h=0,
                 col = 'red',
                 lwd = 2)
          
          