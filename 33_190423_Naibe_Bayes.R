
# NaiveBayes únicamente trabaja con series categóricas (categorías)

### Importar librerías
install.packages('naivebayes')
library(e1071)
library(naivebayes)
library(caret)

### Cargar DF
ep <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/electronics-purchase.csv')

# Semilla
set.seed(2018)

### Conjunto de Entrenamiento
t.ids <- createDataPartition(ep$Purchase,
                             p = 0.67,
                             list = F
                             )

### Construcción del modelo (compra (Purchase) en función de todas las demás variables)
mod <- naiveBayes(Purchase ~., 
                  data = ep[t.ids, ])
mod

### Predicción
pred <- predict(mod, ep[-t.ids,])

### Comprobar con matriz de confusión
tab <- table(ep[-t.ids, ] $Purchase, pred, dnn =c('actual', 'predicha'))
# Parámetros adicionales de la matriz de confusión
confusionMatrix(tab)
