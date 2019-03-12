# Corrección de datos

install.packages('tidyr') # Paquete para ordenar
library(tidyr)

crime.data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/USArrests.csv', 
                       stringsAsFactors =False)


# Añadir columna adicional al dataset

    # Función para añadir una o más columnas al datraframe (cbind)
crime.data <- cbind(state = rownames(crime.data), crime.data)  #<- agrega una columna llamada 'state'
                                                               # a esta columna se agregan los nombres de las filas
                                                               # como no tienen nombre, usa los índices
                                                               # En el dataset crime.data

### CONVERTIR NOMBRES DE COLUMNAS A FILAS (GATHER) ####

# Utilizando un diccionario con el titulo de dos columnas nuevas (cryme_type ; arrest_estimate)
  # Con la función gather(reunir), convierte los titulos en filas que repite, con el valor que contenía y 
    # el valor es acomodado en otra columna (arrest_estimate)

crime.data.1 <- gather(crime.data,    # DATAFRAME DE PARTIDA
                       key = 'crime_type',    # NOMBRE PARA LA COLUMNA CLAVE
                       value = 'arrest_estimate',  # NOMBRE DE LA COLUMNA VALOR
                       Murder:UrbanPop)   # NOMBRES DE LAS COLUMNAS (DESDE MURDER HASTA URBANPOP)



crime.data.2 <- gather (crime.data, 
                        key = 'crime_type',
                        value = 'arrest_estimate',
                        - state )    # Al agregar un menos decimos "todas las columnas excepto"
                                     # Todas las columnas se colapsan, excepto STATE


crime.data.3 <- gather(crime.data,
                       key = 'crime_type',
                       value= 'arrest_estimate',
                       Murder, Assault)   # Indica solo las variables que deseamos colapsar


### CONVERTIR  FILAS A COLUMNAS (CONTRARIO A GATHER --- SPREAD) ####

crime.data.4 <- spread(crime.data.2, 
                       key = 'crime_type',
                       value= 'arrest_estimate')



##### FUNCIÓN UNIT  #########################################################
# Une el valor de dos columnas en una sola

crime.data.5 <- unite(crime.data,     # dataframe original
                      col= 'Muerder_Assault',   # nombre de la columna nueva
                      Murder, Assault,   # columnas a unir
                      sep = '_')  # separador de los datos a unir



# Separar algo que se unió con un separador concreto
crime.data.6 <- separate(crime.data.5,     # dataframe original
                      col= 'Muerder_Assault',   # nombre de la columna a separar
                      into= c('Murder', 'Assault'),   # Nuevas columnas a crear
                      sep = '_')  # separador de los datos para separarlos




