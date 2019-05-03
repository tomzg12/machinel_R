
install.packages('MASS')
library(MASS)
library(caret)

bn <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')
bn$class <- factor(bn$class)

set.seed(2018)
t.id <- createDataPartition(bn$class, 
                            p = 0.7, 
                            list = F)

#Función discriminante lineal
  # Alternativa 1 para escribir código del modelo
mod <- lda(bn[t.id, 1:4], # Columnas de entrada
           bn[t.id, 5])   # Columnas de  salida

# Alternativa 2 para escribir código del modelo
#mod <- lda(class~., 
 #          data = bn[t.id,])


# Crea nueva columna con la predicción (utiliza únicamente la variable clase)
bn[t.id,'Pred'] <- predict(mod, 
                            bn[t.id, 1:4])$class

### Matriz de confusión (función table)

table(bn[t.id, 'class'], 
      bn[t.id, 'Pred'],
      dnn = c('actual', 'predichos'))

# Rellenar toda la serie de dataset con predicción de los valores no de entrenamiento
bn[-t.id,'Pred'] <- predict(mod, 
                           bn[-t.id, 1:4])$class


tabla <- table(bn[-t.id, 'class'], 
      bn[-t.id, 'Pred'],
      dnn = c('actual', 'predichos'))

library(scales) # Libreria para convertir en porcentajes
accuracy <- tabla[1,2] /  tabla[1,1]

# Imprimir con texto
acc <- cat('Precisión : ', percent(round(accuracy, 3)))
