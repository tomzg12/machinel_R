
### Instalaci�n de paquetes para redes neuronales
install.packages('nnet')

library(nnet)
library(caret)



# Predictores num�ricas, dependientes deben ser 0, 1
# nnet construye variables dummy y convierte a categ�ricas

###  Carga de CSV
bn <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')

# Convertir a factor (aunque la paqueter�a la convierte en autom�tico a factor durante el proceso)
bn$class <- factor(bn$class)

### Conjunto de entrenamiento
training.id <- createDataPartition(bn$class, 
                                   p = 0.7, 
                                   list = F)

### Modelo de red neuronal
mod <- nnet(class~., 
            data = bn[training.id,],
            size = 3,   # Espec�fica el n�mero de unidades de la capa m�s interna de la red neuronal (capas ocultas), se recomienda que se aproxime al n�mero de variables de entrada
            maxit = 10000, # N�mero de iteraciones m�ximas para intentar converger (si no converge, se detiene)
            decay = .001, # Controla el "overfitting"
            rang = 0.05,  # Especifica el rango de pesos iniciales a asignar a la red neuronal, 
            na.action = na.omit,  # Omite blancos
            skip = T)

# Funci�n apply  (La regla para elegir el rango (rang) es utilizar el m�ximo y multiplicarlo por un valor que se acerque a 1)
                 # en este ejercicio, el m�ximo es 18 (en columna curtosis, multiplicado por 0.05 da casi 1)
apply(bn,   #Del dataset 
      2,    #Utilizando columnas (1 es para filas)
      max)  #Calcula la funci�n m�ximo

#El modelo converge al encontrar el valor objetivo

### Predicci�n

pred <- predict (mod, 
                 newdata = bn[-training.id, ], 
                 type = 'class')

### Matriz de confusi�n
table(bn[-training.id,]$class , pred, dnn = c('actual', 'predichos'))

# Herramienta muy potente de predicci�n


library(ROCR)
# Calcular valores probabil�sticos en una nueva predicci�n, usando "raw"
pred2 <- predict(mod, 
                 newdata = bn[-training.id, ],
                 type = 'raw')

#Curva ROCR
perf <- performance(prediction(pred2, bn[-training.id, 'class']), 'tpr', 'fpr')
  # Obtenemos una ROC perfecta (ning�n falso positivo)
plot(perf)

