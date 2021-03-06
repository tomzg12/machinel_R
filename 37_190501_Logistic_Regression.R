### Importar librer�a
library(caret)

# Importa dataset
bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema3/boston-housing-logistic.csv')

# Convierte en factor
bh$CLASS <- factor(bh$CLASS, levels = c(0,1))

 set.seed(2018)
t.id<- createDataPartition(bh$CLASS, 
                           p = 0.7, 
                           list = F)

mod <- glm(CLASS~., 
           data = bh[t.id,],
           family = binomial  # Especificar tipo de regresi�n (binomial es "S�" o "No")
           )

summary(mod)

# Calcular las probabilidades de �xito
bh[-t.id, 'prob_exito'] <- predict(mod, 
                                   newdata = bh[-t.id, ],
                                   type = 'response')  # Probabilidad de que clasifique con alta precisi�n

# Discriminar con base en probabilidad de �xito
  # Si la probabilidad es mayor a 0.5, entonces catalogar como 1, en caso contrario, catalogar con 0
bh[-t.id, 'pred_mayor_50'] <-ifelse(bh[-t.id, 'prob_exito']>0.5, 
                                    1, 0)

### Matriz de confusi�n
table(bh[-t.id, 'CLASS'], 
      bh[-t.id, 'pred_mayor_50'], 
      dnn = c('actual', 'predicho'))



