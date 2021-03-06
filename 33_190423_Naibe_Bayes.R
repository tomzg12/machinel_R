
# NaiveBayes �nicamente trabaja con series categ�ricas (categor�as)

### Importar librer�as
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

### Construcci�n del modelo (compra (Purchase) en funci�n de todas las dem�s variables)
mod <- naiveBayes(Purchase ~., 
                  data = ep[t.ids, ])
mod

### Predicci�n
pred <- predict(mod, ep[-t.ids,])

### Comprobar con matriz de confusi�n
tab <- table(ep[-t.ids, ] $Purchase, pred, dnn =c('actual', 'predicha'))
# Par�metros adicionales de la matriz de confusi�n
confusionMatrix(tab)
