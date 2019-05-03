
# Establecer directorio
setwd("~/3Seguimiento/Analytics/R")

# Importar dataset
data <- read.csv('../R/190522_VtaDiaria.csv')

# Nombre de columnas
cols <-colnames(data, 
         do.NULL = TRUE, 
         prefix = "col")

# Nombre de filas
attributes(data)

# Longitud de filas
rowsC <- sum(complete.cases(data))

# Longitud de columnas
columnsC <- length(data)

# Imprime número de filas y de columnas del dataset
cat(paste('TAMAÑO DEL DATASET', ' \n',
          'Filas:'    , rowsC,    '\n' ,
          'Columnas:' , columnsC, '\n'))

#------Crea FUNCIÓN para obtener número de filas y columnas en dataset
dataFSize <-function(dfname){
 
  # Longitud de filas
  rowsC     <- sum(complete.cases(dfname))
  # Longitud de columnas
  columnsC  <- length(dfname)
  
  # Imprime número de filas y de columnas del dataset
  cat(paste('TAMAÑO DEL DATASET', ' \n',
            'Filas:'    , rowsC,    '\n' ,
            'Columnas:' , columnsC, '\n\n'))
  
  # Imprime nombres de columnas y tipos de datos en cada uno
  print(paste('NOMBRES DE COLUMNAS Y TIPOS DE DATOS'), quote = F)
  print((sapply(dfname, typeof)))
  
  }

# Ejecuta función
dataFSize(data)
#----------------------------------------------------------------------


