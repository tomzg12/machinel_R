
# Instalar paquete scales
install.packages('scales')

# Invocar paquete scales
library(scales)

# Importar CSV
students <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/data-conversion.csv ')

# Revisar tabla
View(students)

# Re escalar
  # Creamos otra variable, llamada "income.rescaled" e invocar la funci�n de re escalamiento
students$Income.rescaled <- rescale(students$Income)

# EL valor m�s peque�o toma el valor 0, y el valor m�s alto se convierte en 1
  # el resto, se escalan en forma proporcional de manera lineal

View(students)


# OTRAS OPCIONES DE RE ESCALADO
# A) 
  # Re escalado manual (resta el minimo al valor, luego se divide entre el maximo menos el minimo)
(students$Income - min(students$Income)) / (max(students$Income)-min(students$Income))
# b)
  # Re escalado d�nde el m�nimo es cero, y el m�ximo 100
rescale(students$Income, to= c(0,100))



# CREAR UNA FUNCI�N PARA RE ESCALAR

rescale.many <- function(dataframe, cols ){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], "rescaled", sep = '.')
    dataframe[name] <- rescale(dataframe[,col])
  }
  cat(paste("Hemos reescalado", length(cols), "Variable(s)"))
  dataframe
}


# Con la funci�n se pueden re escalar diferentes variables al mismo tiempo

students <- rescale.many(students, c(1,4))  #<- Re escalar columnas 1 y 4

View(students)
