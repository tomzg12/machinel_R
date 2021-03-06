# Importar librer�a 'Caret'
install.packages('caret')
library(caret)

# Importar dataframe
data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/BostonHousing.csv')

# Crear dos sets (entrenamiento, validacion)
raining.ids <- createDataPartition(data$MEDV, p = 0.8, list = F)
data.training <- data[training.ids,]
data.validation <- data[-training.ids,]

# Crear tres sets( entrenamiento, validacion, test)
training.ids.2 <- createDataPartition(data$MEDV, p = 0.7, list = F)
data.training.2 <- data[training.ids.2,]
temp <- data[-training.ids.2,]  # Tabla temporal
validation.ids.2 <- createDataPartition(temp$MEDV, p = 0.5, list = F)
data.validation <- temp[validation.ids.2,]
data.testing <- temp[-validation.ids.2,]


# Crear partici�n con variables categ�ricas (factores)
data2 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/boston-housing-classification.csv')

training.ids.3 <- createDataPartition(data2$MEDV_CAT, p = 0.7, list = F)
data.training.3 <- data2[training.ids.3,]
data.validation.3 <- data2[-training.ids.3,]


# Funci�n para 2 particiones
rda.cb.partition2 <- function(dataframe, target.index, prob){
  library(caret)
  training.ids <- createDataPartition(dataframe[,target.index], p=prob, list = FALSE)
  list(train = dataframe[training.ids,], val = dataframe[-training.ids,])
}


# Funci�n para 3 particiones
rda.cb.partition3 <- function(dataframe, target.index,
                              prob.train, prob.val){
  library(caret)
  training.ids <- createDataPartition(dataframe[,target.index], p = prob.train, list = FALSE)
  train.data <- dataframe[training.ids,]
  temp <- dataframe[-training.ids,]
  validation.ids <- createDataPartition(temp[,target.index], p = prob.val, list = FALSE)
  list(train = train.data, val = temp[validation.ids,], test = temp[-validation.ids,])
}


                                 #columna, #probabilidad
data.1 <- rda.cb.partition2(data, 14, 0.8)
                                 #columna, probabilidad primer set, probabilidad set temporal
data.2 <- rda.cb.partition3(data2, 14, 0.7, 0.5)

head(data.1$val)
head(data.2$test)  #train, test, val (sustituir en el head, porque ya hay 3 datasets)

nrow(data) # N�mero de filas
ncol(data) # N�mero de columnas


# Muestra aleatoria de los datos
                #df y columna, # cantidad de datos, False Todos los elementos ser�n diferentes
sample1 <- sample(data$CRIM, 40, replace = F)
View(sample1)
