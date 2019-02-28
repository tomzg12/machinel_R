

# Cargar data set y reemplazar los vacíos con ''

data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/missing-data.csv',
                 na.strings = '')


#---------------------------------------------------------------------------------------
# Proceso de reemplazo de los vacíos por el promedio (Variables numéricas)

  # 1) Creamos nueva columna llamada 'income.mean'
  # 2) La función 'ifelse', evalúa si la columna tiene vacíos
  # 3) En caso de haber vacíos, pondrá el promedio de income
  # 4) En caso de no haber vacíos, dejar el valor que ya estaba

data$Income.mean <- ifelse(is.na(data$Income), mean(data$Income,
                                                    na.rm = TRUE),
                            data$Income
                           )


#---------------------------------------------------------------------------------------
# PROCESO PARA REEMPLAZAR VARIABLES CATEGÓRICAS POR UNA MUESTRA ALEATORIA

rand.impute <- function(x){  # Parámetro de entrada | x es un vector de datos que podría contener NAs
  missing <- is.na(x)        # Missing es un vector del mismo tamaño de x, pero contiene booleanos para saber si tiene o no, NAs
  n.missing <- sum(missing)   # Proceso de suma de missings (regresa la suma de los verdaderos) dentro de X
  x.obs <- x[!missing]       # Representa los valores que tienen dato (FALSE), no existen NAs (Contrarios de missing)
  imputed <- x               # Por defecto devuelve lo que entró por parámetro (para comenzar con el reemplazo)
  
  # En los valores que faltaban, los reemplazamos por una muestra de los que sí conocemos
  imputed[missing] <- sample(x.obs, n.missing, replace = TRUE)  # muestra de variables conocidas, del tamaño de missing, y reemplaza
  return(imputed) # regresa el dataframe con los reemplazos
}


# Para hacer uso de la función, se utiliza la siguiente función:
 # Se construye para unir la columna que se crea con los datos aleatorios

random.impute.data.frame <- function(dataframe,cols){
  names <- names(dataframe)
  for(col in cols){
    name <- paste(names[col], "imputed", sep= '.')
    dataframe[name] = rand.impute(dataframe[,col])
  }
  dataframe
}


##### EJECUTAR FUNCIÓN
     
  # Llamar CSV
data1 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/missing-data.csv',
                 na.strings = '')

  # Ver datos de CSV
View(data1)

  # Remplazar los 0 con NA
data1$Income [data1$Income == 0] <- NA

  # Ver datos de CSV con reemplazos de 0 por NA
View(data1)

  # Invocar la función
data1 <- random.impute.data.frame(data1, c(1,2))   # data = dataframe, c(1,2), se ejecutará en columna 1 y 2
  
  # Ver datos con reemplazos aleatorios
View(data1)



install.packages('translations')



