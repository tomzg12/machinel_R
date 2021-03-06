
# Importar dataframe
housing.data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/housing-with-missing-value.csv',
                         header = TRUE, stringsAsFactors = FALSE)  # stringsfactors Los NA o vac�os los pone en cero


# Herramienta de trabajo para analizar datos
  # Estad�sticos b�sicos de cada una de las variables

summary(housing.data)


# Primera variante para trabajar con datos vacios (Elimina todas las filas completas que contienen un NA)
housing.data.1 <- na.omit(housing.data)
summary(housing.data.1)


# Para eliminar NAs de columnas seleccionadas (ej. rad)
drop_na <- c('rad')
housing.data.2 <- housing.data[ 
          complete.cases(housing.data[,!(names(housing.data))%in% drop_na]),]   # Elimina los NAs de todas las columnas
                                     # ! diferente                              # Excepto de "rad"
summary(housing.data.2)


# Para eliminar toda una columna del dataframe
  # Asignar el valor nulo a toda una columna
housing.data$rad <- NULL
summary(housing.data)

drops <- c('rad', 'ptratio')
housing.data.3 <- housing.data[,!(names(housing.data) %in% drops)]  # Me quedo con todas las filas, salvo las columnas
                                                                   # que est�n en "drops"
summary(housing.data.3)



# Instalar paquetes 
install.packages('Hmisc')
library(Hmisc)

# Funci�n inpute (ayuda a reemplazar NAs con cualquier otro valor)

housing.data.copy <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/housing-with-missing-value.csv',
                         header = TRUE, stringsAsFactors = FALSE) 


View(housing.data.copy)

# Tomar las variables que contienen NA y sustituir
housing.data.copy$ptratio <- impute(housing.data.copy$ptratio, mean)  # Sustituye los NA por la media

housing.data.copy$rad <- impute(housing.data.copy$rad, mean)  # Sustituye los NA por la media
                                                      # Mean puede sustituirse por median, por un valor, 
# Revisar que el data frame ya no tiene NAs
summary(housing.data.copy)

# Segundo m�todo (Usando el dataframe original)

housing.data.copy2 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/housing-with-missing-value.csv',
                              header = TRUE, stringsAsFactors = FALSE)
install.packages('mice')
library(mice)

# Permite saber cuantos est�n completas (466) y cuantas no tienen valor (40)
md.pattern(housing.data.copy2)


# M�todo para ver gr�fico y revisar en que columnas hay vac�os
install.packages('VIM')
library(VIM)

# Funci�n para crear gr�fico con colores personalizados
aggr(housing.data.copy2, col = c('green', 'red'), 
     numbers = TRUE, sortVars = TRUE,
     labels = names(housing.data.copy2), 
     cex.axis = 0.5, 
     gap =1, 
     ylab = c('Histograma de NAs', 'Patr�n'))
 
 # gap = espacio entre gr�ficos (menor n�mero, menos espacio)
 # cex.axis disminuye el tama�o de las fuentes
 # Sortvars ordena de mayor a menor
 # numbers te da los porcentajes (85% de los casos se conocen)
