
# Importaci�n del dataset
#------------------------------------------------------------------------------
housing <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/BostonHousing.csv')
View(housing)
#------------------------------------------------------------------------------


# Normalizar con Z (distribuci�n normal entre 0 y 1)
#------------------------------------------------------------------------------
  # En cada columna, y a cada valor, resta la media de esa columna, y lo divide entre la desviaci�n std de esa columna
housing.z <- scale(housing, center = TRUE, scale = TRUE)
  # center representa restar la media
  # scale representa dividir entre la desv std

View(housing.z)
#------------------------------------------------------------------------------


# Para estandarizar m�ltiples variables num�ricas (Crear funci�n)
#------------------------------------------------------------------------------
scale.many = function(dataframe, cols){
  names<- names(dataframe)
  for (col in cols){
    name<- paste(names[col], 'z', sep='.')
    dataframe[name] <- scale(dataframe[,col])
  }
  cat(paste('Hemos normalizado', length(cols), 'variable(s)'))
  dataframe 
}


# Llamar a la funci�n
house2 <- scale.many(housing, c(1,3,5:8))
