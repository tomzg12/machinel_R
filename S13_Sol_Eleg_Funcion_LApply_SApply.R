
# lapply <- 1 = lista, se puede aplicar vectores, lista, data frame

auto <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/auto-mpg.csv', stringsAsFactors =  F)
head(auto)

# Vector
x <- c(1,2,3)
x

# AplicarLapply a cada número del vector (calcular la raíz cuadrada)
lapply(x, sqrt)

# Lista de datos (3 columnas)
x <- list(a=1:10, 
          b=c(1,10,11,1000),
          c= seq(5,50, by =5))
x
#-------------LAPPLY-----------------------------------------------
# SE MUESTRA EN COLUMNAS (TIPO LISTA)
# Utilizando Lapply para calcular la media de cada columna y mostrarlo como lista
lapply(x, mean)

# Tipo de objetivo resultante utilizando lapply
class(lapply(x,mean))



#-------------LAPPLY-----------------------------------------------
# SE MUESTRS EN FILAS (TIPO NUMÉRICO)
# Utilizando Sapply para calcular la media de cada colunma y mostrarlo como fila
sapply(x, mean)

# Tipo de objetivo resultante utilizando sapply
class(sapply(x,mean))


##---------UTILIZANDO EL DATASET DE AUTOS--------------------------

lapply(auto[,2:8], min)
sapply(auto[,2:8], min)

# Summary con sapply devuelve una matriz
sapply(auto[,2:8], summary)

# Summary con sapply devuelve una lista de vectores
lapply(auto[,2:8], summary)

#Sapply con Range
sapply(auto[,2:8], range)

sapply(auto[,2:8], min)

# Cuando solo se toma una columna R interpreta que se trata de un vector, y actúa sobre cada valor de forma individual
sapply(auto[,2], min)

# Para calcular sobre una columna, el vector debe convertirse a dataframe
sapply(as.data.frame(auto[,2]), min)

# Para calcular sobre una columna, el vector debe convertirse a dataframe, y para tener una salida de lista utlizar simplify
sapply(as.data.frame(auto[,2]), min, simplify = F)


