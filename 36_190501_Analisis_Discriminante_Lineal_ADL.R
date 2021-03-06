
install.packages('MASS')
library(MASS)
library(caret)

bn <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')
bn$class <- factor(bn$class)

set.seed(2018)
t.id <- createDataPartition(bn$class, 
                            p = 0.7, 
                            list = F)

#Funci�n discriminante lineal
  # Alternativa 1 para escribir c�digo del modelo
mod <- lda(bn[t.id, 1:4], # Columnas de entrada
           bn[t.id, 5])   # Columnas de  salida

# Alternativa 2 para escribir c�digo del modelo
#mod <- lda(class~., 
 #          data = bn[t.id,])


# Crea nueva columna con la predicci�n (utiliza �nicamente la variable clase)
bn[t.id,'Pred'] <- predict(mod, 
                            bn[t.id, 1:4])$class

### Matriz de confusi�n (funci�n table)

table(bn[t.id, 'class'], 
      bn[t.id, 'Pred'],
      dnn = c('actual', 'predichos'))

# Rellenar toda la serie de dataset con predicci�n de los valores no de entrenamiento
bn[-t.id,'Pred'] <- predict(mod, 
                           bn[-t.id, 1:4])$class


tabla <- table(bn[-t.id, 'class'], 
      bn[-t.id, 'Pred'],
      dnn = c('actual', 'predichos'))

library(scales) # Libreria para convertir en porcentajes
accuracy <- tabla[1,2] /  tabla[1,1]

# Imprimir con texto
acc <- cat('Precisi�n : ', percent(round(accuracy, 3)))
