#split -> apply -> combine
#plyr 
#XYply X,Y = a -> array, d -> data.frame, l -> list, _ -> no output

auto <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

# Instalaci�n de librer�a-------------------------------------------------------------------------------
install.packages("plyr")
library(plyr)

# T�cnica de SPLIT / APPLY / COMBINE  (Map Filter Reduce)-----------------------------------------------

# Calcular el promedio de la variable MPG por cada tipo de cilindro
ddply(auto,              #<- df de entrada
      "cylinders",       #<- Variable a trabajar
      function(df) { mean(df$mpg)}) #<- al df completo aplicar la funci�n mean en la columna MPG


# Otra forma de haacer el c�lculo
ddply(auto, ~cylinders, function(df){ mean(df$mpg)})


# HACER UNA MATRIZ, COMBINANDO A�O Y MODELO, CALCULAR EL MINIMO, MAXIMO Y LA MEDIA----------------------
ddply(auto, c("cylinders", "model_year"),
      function(df){
        c(mean= mean(df$mpg),
          min = min(df$mpg),
          max = max(df$mpg))
      })


# OTRA T�CNICA PARA HACER EL MISMO C�LCULO ANTERIOR
ddply(auto, ~cylinders + model_year,
      function(df){
        c(mean= mean(df$mpg),
          min = min(df$mpg),
          max = max(df$mpg))
      })



#---------funci�n SUMMARIZE CON DDPLY----------------------------------
ddply(auto, .(cylinders),       # utiliza la variable cilindros
      summarize,                #Resumen
      freq = length(cylinders), #Par�metros (cuantos cilindros hay de cada tipo)
      meanmpg = mean(mpg))      #media de millas por gale�n


#...una 3 filas, dos columnas------------------------------------------
par(mfrow=c(3,2))

#...Resumen por cilindrada y crear un hitograma
d_ply(auto, 
      "cylinders", 
      summarise,
      hist(mpg, 
           xlab="Millas por gale�n", 
           main = "Histograma de frecuencias", 
           breaks = 5))



#... crear un dataframe dummie duplicando el df de autos
autos <- list(auto, auto) # crear una lista duplicando el df auto
auto.big <- ldply(autos, 
                  I)  #<- funci�n I (identidad) tambi�n duplica la lista



# Crear una matriz
mat <- matrix(seq(1,9),3,3)
mat
# sumar la matriz y mostrarlo en una fila
apply(mat, 1, sum) 

# crear una lista
x <- list(a=1, b= 1:5, x= 10:50)
x
#calcula la longitud de cada columna con la funci�n (FUN) length
lapply(x, FUN = length)
#muestra el mismo resultado pero en fila
sapply(x, FUN = length)




#----------FUNCI�N MAPPLY------------------------------------------------------------------
mapply(sum, 1:5, 1:10, 1:20, 1:100)
  # Suma n�meros de cda lista (los suma entre ellos ej. 1+1+1+1; 2+2+2+2, 3+3+3+3, ...)


#----------FUNCI�N TAPPLY------------------------------------------------------------------

x <- 1:25 # lista
y <- factor(rep(letters[1:5], each = 5)) #crea factores de letras (de la 1 a la 5, repetir 5 veces)
y
tapply(x, y, sum) # suma por factor



#----------FUNCIONES GROUPBY PARA MAYOR EFICIENCIA EN DATASETS M�S GRANDES-------------------------

#----------------------------------->  dplyr <------------------------------------------------

#SELECT   -> select()
#WHERE    -> filter()
#GROUP BY -> group_by() / summarise()
#ORDER BY -> arrange()
#JOIN     -> join()
#COLUMN ALIAS -> mutate()

install.packages("dplyr")
library(dplyr)

# CREAR UN SUBSET CON SELECCI�N ESPECIAL DE COLUMNAS
subset.auto <- select(auto, mpg, horsepower, acceleration)
head(subset.auto)

# FILTRAR EL DATA SET CON AUTOS CUYO MODELO ES MAYOR AL 80
auto.80 <- filter(auto, model_year>80)
head(auto.80)

# NORMALIZAR LOS DATOS (MUTATE CREA UNA NUEVA VARIABLE)
auto.norm <- mutate(auto,  # DATAFRAME
                    mpg.norm = round((mpg-mean(mpg)) 
                                     /sd(mpg), # DIVIDE LA RESTA ENTRE LA DESVIACI�N EST�NDAR
                                     2)) # CREA VARIABLE CONSUMO NORMALIZADO
head(auto.norm)


# FUNCI�N SUMMARISE PARA HACER AGRUPACIONES DEL DF (GROUPBY)
summarise(group_by(auto, 
                   cylinders), 
          mean(mpg))

summarise(group_by(auto, 
                   model_year), 
          mean(mpg))


auto %>%
  filter(model_year<78) %>%
  group_by(cylinders) %>%
  summarise(mean(mpg))

