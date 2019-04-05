
# Split / Unsplit
data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv',
                 header = TRUE, 
                 stringsAsFactors = FALSE)  # No crear factores


# Para crear subsets con la función SPLIT (devuelve una lista de dataframes)
# Cada dataframe, contiene uno de los datos del dataframe original
# En este caso, se divide por cambios en la variable 'cylinders'
carslist <- split(data, data$cylinders)


# Método para acceder a los subsets
  # No devuelve del dataframe, devuelve una lista de listas
carslist[1]

  # Devuelve el dataframe (subset)
data2 <-carslist[[1]]
View(data2)
str(data2)

#Nombre de las columnas
print(names(data))
print(names(data2))


