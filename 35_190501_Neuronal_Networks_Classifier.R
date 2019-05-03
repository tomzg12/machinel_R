
### Instalación de paquetes para redes neuronales
install.packages('nnet')

library(nnet)
library(caret)



# Predictores numéricas, dependientes deben ser 0, 1
# nnet construye variables dummy y convierte a categóricas

###  Carga de CSV
bn <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')

# Convertir a factor (aunque la paquetería la convierte en automático a factor durante el proceso)
bn$class <- factor(bn$class)

### Conjunto de entrenamiento
training.id <- createDataPartition(bn$class, 
                                   p = 0.7, 
                                   list = F)

### Modelo de red neuronal
mod <- nnet(class~., 
            data = bn[training.id,],
            size = 3,   # Específica el número de unidades de la capa más interna de la red neuronal (capas ocultas), se recomienda que se aproxime al número de variables de entrada
            maxit = 10000, # Número de iteraciones máximas para intentar converger (si no converge, se detiene)
            decay = .001, # Controla el "overfitting"
            rang = 0.05,  # Especifica el rango de pesos iniciales a asignar a la red neuronal, 
            na.action = na.omit,  # Omite blancos
            skip = T)

# Función apply  (La regla para elegir el rango (rang) es utilizar el máximo y multiplicarlo por un valor que se acerque a 1)
                 # en este ejercicio, el máximo es 18 (en columna curtosis, multiplicado por 0.05 da casi 1)
apply(bn,   #Del dataset 
      2,    #Utilizando columnas (1 es para filas)
      max)  #Calcula la función máximo

#El modelo converge al encontrar el valor objetivo

### Predicción

pred <- predict (mod, 
                 newdata = bn[-training.id, ], 
                 type = 'class')

### Matriz de confusión
table(bn[-training.id,]$class , pred, dnn = c('actual', 'predichos'))

# Herramienta muy potente de predicción


library(ROCR)
# Calcular valores probabilísticos en una nueva predicción, usando "raw"
pred2 <- predict(mod, 
                 newdata = bn[-training.id, ],
                 type = 'raw')

#Curva ROCR
perf <- performance(prediction(pred2, bn[-training.id, 'class']), 'tpr', 'fpr')
  # Obtenemos una ROC perfecta (ningún falso positivo)
plot(perf)

