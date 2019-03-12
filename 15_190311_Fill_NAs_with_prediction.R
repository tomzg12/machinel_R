
library(mice)
housing.data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/housing-with-missing-value.csv', 
                         header = TRUE,
                         stringsAsFactors = FALSE)

columns <- c('ptratio', 'rad')

# Información inferida
                      # DF        # all rows, # Columns = columns
imputed_data <- mice(housing.data[,names(housing.data) %in% columns],  # Columnas de las variables columnas
                     m = 5,                # Número de imputaciones que desean llevar a cabo (muestras que se toman)
                     maxit = 10,           # Número máximo de iteraciones (pruebas a realizar)
                     method = 'pmm',       # Forma en la que se obtienen los datos (la función tiene 4 algoritmos)
                     seed = 2018)          # Semilla

# Métodos
#--------------
#  pmm - comparación predictiva de medias
#  logreg - regresión logística
#  polireg - regresión logística politómica
#  polr - modelo de probabilidades prorporcionales
#--------------

# La librería MICE utiliza un algoritmo predictivo para crear imputaciones (cálculos multivariantes)
# que intentan obtener el valor probabilístico de los NAs (datos que no se conocen)
# En la primera etapa utiliza la función MICE para construir un modelo de datos.

#### REVISIÓN DE LOS DATOS (SUMARIZADA)
summary(imputed_data)

### GENERAR UN DATAFRAME COMPLETO (SUSTITUYENDO LOS NAN POR LOS DATOS DE LA PREDICCIÓN)
  # Función 'complete' del paquete MICE
    # En ocasiones una función tiene el mismo nombre y pertenece a diferentes paquetes (calificar función)

complete.data <- mice::complete(imputed_data)

### COMPLETAR EL DATA SET ORIGINAL, CON LAS VARIABLES DE LA PREDICCIÓN
  ### SUSTITUYENDO LAS CLUMNAS
housing.data$ptratio <- complete.data$ptratio
housing.data$rad <- complete.data$rad

# FUNCIÓN DE R PARA REVISAR CUANTOS NA CONTIENE EL DATA FRAME QUE SE PASA POR PARÁMETRO (BOOLEAN)

anyNA(housing.data)


# Segundo método para sustituir NAs
library(Hmisc)
#----------------------------------------------------------------
impute_arg <- Hmisc:: aregImpute(~ptratio + rad,
                         data =housing.data, 
                         n.impute = 15)

impute_arg


# Conseguir valores calculados
impute_arg$rad
#----------------------------------------------------------------


