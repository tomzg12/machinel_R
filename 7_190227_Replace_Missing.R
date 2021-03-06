

# Cargar data set y reemplazar los vac�os con ''

data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/missing-data.csv',
                 na.strings = '')


#---------------------------------------------------------------------------------------
# Proceso de reemplazo de los vac�os por el promedio (Variables num�ricas)

  # 1) Creamos nueva columna llamada 'income.mean'
  # 2) La funci�n 'ifelse', eval�a si la columna tiene vac�os
  # 3) En caso de haber vac�os, pondr� el promedio de income
  # 4) En caso de no haber vac�os, dejar el valor que ya estaba

data$Income.mean <- ifelse(is.na(data$Income), mean(data$Income,
                                                    na.rm = TRUE),
                            data$Income
                           )


#---------------------------------------------------------------------------------------
# PROCESO PARA REEMPLAZAR VARIABLES CATEG�RICAS POR UNA MUESTRA ALEATORIA

rand.impute <- function(x){  # Par�metro de entrada | x es un vector de datos que podr�a contener NAs
  missing <- is.na(x)        # Missing es un vector del mismo tama�o de x, pero contiene booleanos para saber si tiene o no, NAs
  n.missing <- sum(missing)   # Proceso de suma de missings (regresa la suma de los verdaderos) dentro de X
  x.obs <- x[!missing]       # Representa los valores que tienen dato (FALSE), no existen NAs (Contrarios de missing)
  imputed <- x               # Por defecto devuelve lo que entr� por par�metro (para comenzar con el reemplazo)
  
  # En los valores que faltaban, los reemplazamos por una muestra de los que s� conocemos
  imputed[missing] <- sample(x.obs, n.missing, replace = TRUE)  # muestra de variables conocidas, del tama�o de missing, y reemplaza
  return(imputed) # regresa el dataframe con los reemplazos
}


# Para hacer uso de la funci�n, se utiliza la siguiente funci�n:
 # Se construye para unir la columna que se crea con los datos aleatorios

random.impute.data.frame <- function(dataframe,cols){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], "imputed", sep= '.')
    dataframe[name] = rand.impute(dataframe[,col])
  }
  dataframe
}


##### EJECUTAR FUNCI�N
     
  # Llamar CSV
data1 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/missing-data.csv',
                 na.strings = '')

  # Ver datos de CSV
View(data1)

  # Remplazar los 0 con NA
data1$Income [data1$Income == 0] <- NA

  # Ver datos de CSV con reemplazos de 0 por NA
View(data1)

  # Invocar la funci�n
data1 <- random.impute.data.frame(data1, c(1,2))   # data = dataframe, c(1,2), se ejecutar� en columna 1 y 2
  
  # Ver datos con reemplazos aleatorios
View(data1)



install.packages('translations')



