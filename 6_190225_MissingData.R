

# CARGMOS EL ARCHIVO EN CSV
data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/missing-data.csv',
                 na.strings = "")


# ELIMINA LAS FILAS QUE CONTIENEN NA
data.cleaned <- na.omit(data)

# FUNCIÓN ISNA
  # Devuelve la respuesta al preguntar si existen NAs
is.na(data[4,2])  #Fila 4, columna 2


is.na(data[4,1])  #Fila 4, columna 1

# Para revisar si existen NAs en una serie de datos (colección completa)
is.na(data$Income)

# LIMPIEZA SELECTIVA--------------------------------------------------

# Para eliminar las filas que en la columna "income" tienen NAs
# Aunque si existan en las siguientes columnas

data.income.cleaned <- data[!is.na(data$Income),]

# Muestra las filas completas, es decir, que no tienen NAs
complete.cases(data)

#----- Limpieza selectiva 2------
# Únicamente conserva las filas dónde no hay NAs, y todas las columnas 
data.cleaned.2 <- data[complete.cases(data), ]

# Convertir los ceros de ingresos en NAs
  # Filtrado de columnas en R
data$Income[data$Income == 0] <- NA   # Se filtra, y se sustituyen los ceros por NAs

# Revisamos la tabla (con filas eliminadas, a las que agregamos NAs)
data.cleaned.3 <- data[complete.cases(data), ]


# Medidas de centralización y disperación

mean(data$Income)   # Si pedimos la media a la serie que tiene NAs, primero saldrá NA

mean(data$Income, na.rm = TRUE)   # Indicar que no incluya NAs

sd(data$Income, na.rm = TRUE)     # Desviación típica
