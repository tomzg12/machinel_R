
# Importar dataset
data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv',
                 header = TRUE, 
                 stringsAsFactors = FALSE)

# Convertir variable a categoria
  # levels son la cantidad de agrupadores o niveles de agrupaci�n
    # labels son los datos que sustituir�n a los datos en los agrupadores
data$cylinders <- factor(data$cylinders, 
                         levels = c(3,4,5,6,8),
                         labels= c('3cil', '4cil', '5cil', '6cil', '8cil')) 

# Funci�n SUMMARIZE (variables num�ricas y categ�ricas)
summary(data)
  # Summary one column
summary(data$cylinders)
summary(data$mpg)

# Funci�n str (structure)
  # Indica el tipo de objetos que contiene la estructura
str(data)
  # str one column
str(data$cylinders)


### Paquetes para estad�sticos b�sicos
install.packages(c('modeest', 'raster', 'moments'))

library(modeest)  # moda
library(raster)   # quantiles, cv
library(moments)  # asimetria, curtosis


# Crear vector para analizar
X <- data$mpg

# Media de columna mpg (millas por gale�n)
mean(X)
  # Media (m�todo de bajo nivel)
  sum(X) / length(X)

# Mediana [el valor que se encuentra justo en medio de la serie de datos]
median(X)

# Moda [muestra num�rica que m�s aparece]
  # mfv = most frequent value
raster::modal(X)  

# Calculo de quantiles (permite conocer los niveles de variabilidad)
quantile(X)

# OPERADORES (MEDIDAS DE DISPERSI�N)

# Varianza
var(X)

# desviaci�n est�ndard
sd(X)

# Coeficiente de variaci�n (desviaci�n tipica / media)
cv(X)


##### Medidas de asimetria

# Asimestr�a de Fisher
skewness(X) # Positiva, quiere decir que la media est� por encima del resto de valores

# Coeficiente de Curtosis
kurtosis(X)   # Si es positiva, quiere decir que es leptocurtica
              # Concentra los valores en torno a la media y a la izquierda



# Histograma para ver la distribuci�n de X
hist(X)






