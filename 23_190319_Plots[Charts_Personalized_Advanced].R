# Importar el dataset
auto <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv',
                 stringsAsFactors = FALSE)


# Sobreescribir la variable "cilindros" para que sea una categoría
auto$cylinders <- factor(auto$cylinders, 
                         levels =c(3,4,5,6,8),
                         labels=c('3cil','4cil','5cil','6cil','8cil'))

# Función attach (para que forme parte el dataset de la estructura principal de R)
attach(auto)

# Para acceder a cualquier columna de auto, se escribe:
head(cylinders)   # Evita escribir el signo de pesos

#-------------------------------------------------------------------------------------
# Crear un HISTROGRAMA (en el ejemplo se utiliza 'aceleración')
hist(acceleration)

# Personalizar histograma (color, etiquetas en ejes y título)
hist(acceleration, 
     col = rainbow(12),     #<---- Colores diferentes (arcoiris)
     xlab = 'Aceleración',
     ylab= 'Frecuencias',
     main = 'Histograma de las aceleraciones',
     breaks = 16)  # divisiones para el histograma

# Crear un boxplot con porcentajes (frecuencias relativas)
hist(mpg, 
     breaks= 12,
     prob =  T)  #<- cambia frequency por density

density(mpg)
lines(density(mpg))  # Encima el histograma de líneas, sobre el histograma de barras


#-------------------------------------------------------------------------------------
# Crear un BOXPLOT(caja y bigotes) 
boxplot(mpg,
        xlab = 'Millas por galeón')

# Método 2
boxplot(mpg~model_year,    #Las millas por galeón en función del año
        xlab  = 'Millas por galeón por año')

boxplot(mpg~cylinders,
        xlab= 'Consumo por número de cilindros')


#----------------------------------------------------------------------------------------
# Crear un SCATTERPLOT
#Y(vert)     #X (horizontal)
plot(mpg   ~   horsepower, col = 'blue')  #millas en función de caballos

# Construir recta de regresion lineal a partir del scatterplot (imprime línea)
linearmodel<- lm(mpg   ~   horsepower)
abline(linearmodel, col = 'red')

#...............................
# Indicar diferentes colores para cada subconjunto (ej. cilindrada)
plot(mpg   ~   horsepower, type = 'n')  #millas en función de caballos
# Construir recta de regresion lineal a partir del scatterplot (imprime línea)
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



# Matriz de SCATTERPLOT (función pairs)
pairs(~mpg+displacement+horsepower+weight, col = 'blue')


#...............................
# Combinación de Plots con PAR

old.par <- par()
old.par

# asignar a mfrow la instrucción de crear una vista de 1 fila y 2 columnas
par(mfrow=c(1,2))  # con mfrow se indica primero la fila (con mfrow primero la columna) 

    # Crear dos plots
with(auto, {
  plot(mpg~weight, 
       main = 'Peso vs consumo')
  
  plot(mpg~acceleration, 
       main= 'Aceleracion vs consumo')
})

# Restaurar el par original

par(old.par)

