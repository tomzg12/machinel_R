
library(mice)
housing.data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/housing-with-missing-value.csv', 
                         header = TRUE,
                         stringsAsFactors = FALSE)

columns <- c('ptratio', 'rad')

# Informaci�n inferida
                      # DF        # all rows, # Columns = columns
imputed_data <- mice(housing.data[,names(housing.data) %in% columns],  # Columnas de las variables columnas
                     m = 5,                # N�mero de imputaciones que desean llevar a cabo (muestras que se toman)
                     maxit = 10,           # N�mero m�ximo de iteraciones (pruebas a realizar)
                     method = 'pmm',       # Forma en la que se obtienen los datos (la funci�n tiene 4 algoritmos)
                     seed = 2018)          # Semilla

# M�todos
#--------------
#  pmm - comparaci�n predictiva de medias
#  logreg - regresi�n log�stica
#  polireg - regresi�n log�stica polit�mica
#  polr - modelo de probabilidades prorporcionales
#--------------

# La librer�a MICE utiliza un algoritmo predictivo para crear imputaciones (c�lculos multivariantes)
# que intentan obtener el valor probabil�stico de los NAs (datos que no se conocen)
# En la primera etapa utiliza la funci�n MICE para construir un modelo de datos.

#### REVISI�N DE LOS DATOS (SUMARIZADA)
summary(imputed_data)

### GENERAR UN DATAFRAME COMPLETO (SUSTITUYENDO LOS NAN POR LOS DATOS DE LA PREDICCI�N)
  # Funci�n 'complete' del paquete MICE
    # En ocasiones una funci�n tiene el mismo nombre y pertenece a diferentes paquetes (calificar funci�n)

complete.data <- mice::complete(imputed_data)

### COMPLETAR EL DATA SET ORIGINAL, CON LAS VARIABLES DE LA PREDICCI�N
  ### SUSTITUYENDO LAS CLUMNAS
housing.data$ptratio <- complete.data$ptratio
housing.data$rad <- complete.data$rad

# FUNCI�N DE R PARA REVISAR CUANTOS NA CONTIENE EL DATA FRAME QUE SE PASA POR PAR�METRO (BOOLEAN)

anyNA(housing.data)


# Segundo m�todo para sustituir NAs
library(Hmisc)
#----------------------------------------------------------------
impute_arg <- Hmisc:: aregImpute(~ptratio + rad,
                         data =housing.data, 
                         n.impute = 15)

impute_arg


# Conseguir valores calculados
impute_arg$rad
#----------------------------------------------------------------


