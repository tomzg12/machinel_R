

# importar dataframe
usarrests<- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/USArrests.csv',
                       stringsAsFactors = FALSE)

# asignar columna como índice
rownames(usarrests) <- usarrests$X

# Eliminar columna que sobra
usarrests$X <- NULL

head(usarrests, 1)
View(usarrests)

# Varianza de las variables
apply(usarrests, 2, var)  # aplicar a dataframe por columna( se indica con el 2) la función varianza
    # Se demuestra que hay mucha varianza

# Método PRCOMP (resta la media y escala (dividir por desviació típica) cada variable)
  # análisis de componentes principales
acp <- prcomp(usarrests,
              center = TRUE,   # cada variable será restada a la media de cada una 
              scale = TRUE)   # escalar (dividir entre la desviación típica)

# Imprimir acp
print(acp)
  # devuelve la desviación estándar de cada uno de los componentes principales
  # La matriz compone 4 vectores propios (PC1, PC2...)

plot(acp, type= 'l')  # l = linea
# Se genera el gráfico de codo, se deben seleccionar las variables hasta antes del codo
# en este caso, se seleccionan las primeras 2, antes de que se genere el codo (curva)
# en el gráfico.

# resumen de las componentes principales
summary(acp)

## Representar acp en un diagrama
biplot(acp, 
       scale = 0)

# Calcular los componentes principales
pc1 <- apply(acp$rotation[,1]*usarrests,1,sum)
pc1

pc2 <- apply(acp$rotation[,2]*usarrests,1,sum)


# Agregar las columnas de componentes principales al data set
usarrests$pc1 = pc1
usarrests$pc2 = pc2

# Nulificar las columnas que han sido sustituidas por el acp
usarrests[,1:4] <- NULL


