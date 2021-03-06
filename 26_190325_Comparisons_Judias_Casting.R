

data<-read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/daily-bike-rentals.csv')

# Modificar 3 columnas (convertirlas a categ�ricas o factores)
data$season <- factor(data$season,
                      levels= c(1,2,3,4),
                      labels = c('Invierno',
                                 'Primavera',
                                 'Verano',
                                 'Oto�o'))

data$workingday <- factor(data$workingday,
                      levels= c(0,1),
                      labels = c('Festivo',
                                 'De_trabajo'
                                 ))

data$weathersit <- factor(data$weathersit,
                          levels= c(1,2,3),
                          labels = c('Despejado',
                                     'Nublado',
                                     'LLuvia_ligera'
                          ))

# Adjuntar el dataset "data"
attach(data)

# Frame con 2 filas y 2 columnas (4 gr�ficos)
par(mfrow = c(2,2))

# Crear subsets
winter <- subset(data, 
                 season == 'Invierno')$cnt  #<-- Indica que solo queremos la columna de conteo

sprint <- subset(data, 
                 season == 'Primavera')$cnt  #<-- Indica que solo queremos la columna de conteo

summer <- subset(data, 
                 season == 'Verano')$cnt  #<-- Indica que solo queremos la columna de conteo

fall   <- subset(data, 
                 season == 'Oto�o')$cnt  #<-- Indica que solo queremos la columna de conteo



# Histograma de frecuencias relativas (true) INVIERNO
hist(winter, prob = TRUE,
     xlab = 'Alquiler diario en invierno',
     main = '') # Anular t�tulo

    # Curva de densidad
lines(density(winter))
abline(v = mean(winter), col = 'red')  # v = vertical (linea vertical en el valor del promedio de winter)
abline(v = median(winter), col = 'blue')  # v = vertical (linea vertical en el valor del promedio de winter)


# Histograma de frecuencias relativas (true) PRIMAVERA
season = sprint
hist(season, prob = TRUE,
     xlab = 'Alquiler diario en primavera',
     main = '') # Anular t�tulo

# Curva de densidad
lines(density(season))
abline(v = mean(season), col = 'red')  # v = vertical (linea vertical en el valor del promedio de winter)
abline(v = median(season), col = 'blue')  # v = vertical (linea vertical en el valor del promedio de winter)


# Histograma de frecuencias relativas (true) VERANO
season = summer
hist(season, prob = TRUE,
     xlab = 'Alquiler diario en verano',
     main = '') # Anular t�tulo

# Curva de densidad
lines(density(season))
abline(v = mean(season), col = 'red')  # v = vertical (linea vertical en el valor del promedio de winter)
abline(v = median(season), col = 'blue')  # v = vertical (linea vertical en el valor del promedio de winter)



# Histograma de frecuencias relativas (true) OTO�O
season = fall
hist(season, prob = TRUE,
     xlab = 'Alquiler diario en oto�o',
     main = '') # Anular t�tulo

# Curva de densidad
lines(density(season))
abline(v = mean(season), col = 'red')  # v = vertical (linea vertical en el valor del promedio de winter)
abline(v = median(season), col = 'blue')  # v = vertical (linea vertical en el valor del promedio de winter)

# Gr�fico de las jud�as
install.packages('beanplot')
library(beanplot)

# Gr�fico
par(mfrow = c(1,1)) # Para hacer m�s grande (1 columna por 1 fila)
beanplot(data$cnt~data$season,
         col = c('blue','red','green'))


# Castear una columna 
data$dteday <- as.Date(data$dteday, format = '%Y-%m-%d') # M mayuscula para minutos


# An�lisis de causalidad
library(lattice)
# Boxplot de lattice
bwplot(cnt~weathersit, #<- Conteo por tipo de clima
       data = data, 
       layout = c(1,1),  # <- Tama�o
       xlab = 'Pron�stico del tiempo',
       ylab = 'Frecuencias',
       panel = function(x,y,...){
         panel.bwplot(x,y,...)
         panel.stripplot(x,y,jitter.data = TRUE,...) # Qtt puntos por categoria
       },
       par.settings = 
         list(box.rectangle = list(fill =c( 'red'
                                           ,'yellow',
                                            'green')))) #<- colores de cajas




