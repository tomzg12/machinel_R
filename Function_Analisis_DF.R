
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

# Imprime n�mero de filas y de columnas del dataset
cat(paste('TAMA�O DEL DATASET', ' \n',
          'Filas:'    , rowsC,    '\n' ,
          'Columnas:' , columnsC, '\n'))

#------Crea FUNCI�N para obtener n�mero de filas y columnas en dataset
dataFSize <-function(dfname){
 
  # Longitud de filas
  rowsC     <- sum(complete.cases(dfname))
  # Longitud de columnas
  columnsC  <- length(dfname)
  
  # Imprime n�mero de filas y de columnas del dataset
  cat(paste('TAMA�O DEL DATASET', ' \n',
            'Filas:'    , rowsC,    '\n' ,
            'Columnas:' , columnsC, '\n\n'))
  
  # Imprime nombres de columnas y tipos de datos en cada uno
  print(paste('NOMBRES DE COLUMNAS Y TIPOS DE DATOS'), quote = F)
  print((sapply(dfname, typeof)))
  
  }

# Ejecuta funci�n
dataFSize(data)
#----------------------------------------------------------------------


