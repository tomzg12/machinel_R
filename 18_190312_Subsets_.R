
# Importar dataset
data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv',
                 header = TRUE, 
                 stringsAsFactors = FALSE)

head(data,1)

# Extraer subconjunto basado en índices (index)
  
# Método 1
# filas de la 1 a la 5, columnas de la 8 a la 9
data[1:5, 8:9]

# Método 2
# filas de la 1 a la 5, columnas de la 8 a la 9
data[1:5, c(8,9)]  #<---- También se utiliza para columnas alternas

# Index por nombre
data[1:4, c('model_year', 'car_name')]


#Min / Max de 'mpg'
  # Seleccionar mínimo ó máximo (filas), y todas las columnas
data[data$mpg == max(data$mpg) | data$mpg == min(data$mpg), ]


# Filtros con condiciones (todas las columnas)
data[data$mpg >30 & data$cylinders == 6,]

# Seleccionar filtros en filas y seleccionar 2 columnas
data[data$mpg >30 & data$cylinders == 6, c('car_name', 'mpg')]


#  Para reducir el nombre de la columna (cylinder por cyl); R infiere a que columna se refiere
data[data$mpg>30 & data$cyl == 6 , c('car_name', 'mpg')]


### USO DE LA FUNCIÓN SUBSET (PARA FILAS)

subset(data,                    # dataframe
       mpg>30  &                # condiciones
       cylinders == 6,
       select=c('car_name', 
                'mpg'))         # nombre de las columnaspara mostrar



subset(data,                    # dataframe
       mpg>30  &                # condiciones
       cylinders == 6,
       select=c('car_name', 
                'mpg'))         # nombre de las columnaspara mostrar

# Excluir columnas

# &  AND
# |  OR
# !  NOT
# == IGUAL (Comprobar)

 #1
data[1:5, c(-1,-9)]
 #2
data[1:5, -c(1,9)]
 #3 (Nombres de columnas de data que no están en "No" y "car_name")
data[1:5, !names(data) %in% c('No', 'car_name')]



# Otro método de subset %in
    # Autos que como valor mpg, tienen 15 y 20, solo de las columnas 'car..., mpg'
data[data$mpg %in% c(15,20), c('car_name', 'mpg')]



# Otro método (reciclaje de vectores)
# Trae cada tercera columna (la toma como verdadera)
data[1:2, c(F,F,T)]
      
data[c(F,F,F,F,T), c(F,F,T)]
