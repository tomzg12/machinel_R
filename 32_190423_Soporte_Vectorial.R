### Instalaci�n de paquetes
install.packages('e1071') # Paquete para SVM
install.packages('caret')
library(e1071)
library(caret)


### Importaci�n del dataset
banknote <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')

### Convertir variable "class" a factor
banknote$class = factor(banknote$class)

# Semilla
set.seed(2018)

# Dataset de entrenamiento
t.ids <- createDataPartition(banknote$class,
                             p = 0.7,
                             list = FALSE
                             )

### Construcci�n del modelo de SVM
  # variable dependiente de todas las dem�s (todas las representa el punto)
mod <- svm(class ~.,
           data = banknote[t.ids,])

### Matriz de confusi�n conjunto de entrenamiento 
table(banknote[t.ids,'class'], fitted(mod), dnn = c('Actual', 'Predicho'))

### Predicci�n de todos los dem�s datos (datos de validac�n)
pred <- predict(mod, banknote[-t.ids, ])  #Al poner el menos, excluimos los datos de entrenamiento

#Agregar columna de predicci�n al data frame original (todos los valores) con SVM
mod_total <- svm(class ~.,
           data = banknote[,])

pred_total <- predict(mod_total, banknote[,])

banknote$prediction <- pred_total

### Matriz de confusi�n conjunto de validaci�n
table(banknote[-t.ids,'class'], pred, dnn = c('Actual', 'Predicho'))

# Plot del modelo original mod
plot(mod, data = banknote[t.ids, ], skew~variance)

# Plot del modelo de entrenamiento
plot(mod, data = banknote[-t.ids, ], skew~variance)

# Plot del modelo con todos los datos
par(col.main = 'blue', col.lab = 'red')
plot(mod, data = banknote[ , ], skew~variance)

