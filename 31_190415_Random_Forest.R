
###Instalaci�n de paquetes
install.packages('randomForest')
install.packages('caret')
install.packages('lattice')
install.packages('ggplot2')
library(caret)
library(randomForest)

###Importar dataset
banknote <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')

###Convertir en factor columna de clase ('class')
banknote$class <- factor(banknote$class)  # Convertir de n�mero a factor (SI / NO = 1 /0)

###Subconjunto de datos para constru�r el modelo
set.seed(2018)  #Sembrar semilla
training.ids <- createDataPartition(banknote$class,
                                    p = 0.7,  # Porcentaje de datos para el set de entrenamiento
                                    list = FALSE)  #Al poner FALSE, indico que ser� formato array

###Creaci�n del modelo de bosque aleatorio
mod <- randomForest(x = banknote[training.ids, 1:4], # Columnas 1 a 4 independientes
                    y = banknote[training.ids,5], # Columna 5 dependiente
                    ntree = 500,   #Cantidad de �rboles
                    keep.forest = TRUE) #Quedar todos los �rboles intermedios

#Predicci�n
pred <- predict(mod, 
                banknote[-training.ids, ])

###Matriz de confusi�n 
table(banknote[-training.ids, 
              'class'],
              pred,
              dnn = c('Actual', 'Predicho'))  # Nombres de columnas

###Matriz de probabilidades
install.packages('ROCR')
probs <- predict(mod, 
                 banknote[-training.ids,],
                 type = 'prob') #C�lculo de probabilidades
head(probs,5)

library(ROCR)
pred<- prediction(probs[,2],
                  banknote[-training.ids, 'class'])
perf <- performance(pred,'tpr','fpr')
plot(perf)  # Pintar la matriz de precisi�n 
