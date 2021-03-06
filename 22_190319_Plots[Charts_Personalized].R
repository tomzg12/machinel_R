# Importar el dataset
auto <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv',
                 stringsAsFactors = FALSE)


# Sobreescribir la variable "cilindros" para que sea una categor�a
auto$cylinders <- factor(auto$cylinders, 
                         levels =c(3,4,5,6,8),
                         labels=c('3cil','4cil','5cil','6cil','8cil'))

# Funci�n attach (para que forme parte el dataset de la estructura principal de R)
attach(auto)

# Para acceder a cualquier columna de auto, se escribe:
head(cylinders)   # Evita escribir el signo de pesos

#-------------------------------------------------------------------------------------
# Crear un HISTROGRAMA (en el ejemplo se utiliza 'aceleraci�n')
hist(acceleration)

# Personalizar histograma (color, etiquetas en ejes y t�tulo)
hist(acceleration, 
     col = rainbow(12),     #<---- Colores diferentes (arcoiris)
     xlab = 'Aceleraci�n',
     ylab= 'Frecuencias',
     main = 'Histograma de las aceleraciones',
     breaks = 16)  # divisiones para el histograma

# Crear un boxplot con porcentajes (frecuencias relativas)
hist(mpg, 
     breaks= 12,
     prob =  T)  #<- cambia frequency por density

density(mpg)
lines(density(mpg))  # Encima el histograma de l�neas, sobre el histograma de barras


#-------------------------------------------------------------------------------------
# Crear un BOXPLOT(caja y bigotes) 
boxplot(mpg,
        xlab = 'Millas por gale�n')

# M�todo 2
boxplot(mpg~model_year,    #Las millas por gale�n en funci�n del a�o
        xlab  = 'Millas por gale�n por a�o')

boxplot(mpg~cylinders,
        xlab= 'Consumo por n�mero de cilindros')


#----------------------------------------------------------------------------------------
# Crear un SCATTERPLOT
#Y(vert)     #X (horizontal)
plot(mpg   ~   horsepower, col = 'blue')  #millas en funci�n de caballos

# Construir recta de regresion lineal a partir del scatterplot (imprime l�nea)
linearmodel<- lm(mpg   ~   horsepower)
abline(linearmodel, col = 'red')

#...............................
# Indicar diferentes colores para cada subconjunto (ej. cilindrada)
plot(mpg   ~   horsepower, type = 'n')  #millas en funci�n de caballos
# Construir recta de regresion lineal a partir del scatterplot (imprime l�nea)
linearmodel<- lm(mpg   ~   horsepower)
abline(linearmodel, col = 'red')
# Agregar colores (crear subset)
with(subset(auto, cylinders =='8cil'), 
     points(horsepower, mpg, col= 'green'))

with(subset(auto, cylinders =='6cil'), 
     points(horsepower, mpg, col= 'blue'))

with(subset(auto, cylinders =='5cil'), 
     points(horsepower, mpg, col= 'gray'))

with(subset(auto, cylinders =='4cil'), 
     points(horsepower, mpg, col= 'magenta'))

with(subset(auto, cylinders =='3cil'), 
     points(horsepower, mpg, col= 'black'))


# 1er subset en color verde
# Cylinders == '8cyl'

# 2o subset en color azul
# Cylinders == '6cyl'

# 3er subset en color gris
# Cylinders == '5cyl'

# 4o subset en color magenta
# Cylinders == '4cyl'

# 4o subset en color black
# Cylinders == '3cyl'


#...............................



# Matriz de SCATTERPLOT (funci�n pairs)
pairs(~mpg+displacement+horsepower+weight, col = 'blue')
