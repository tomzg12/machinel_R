
library(caret)

# Datos
autos <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/auto-mpg.csv')

# Convertir los cilindros a factor
autos$cylinders <- factor(autos$cylinders, 
                          levels = c(3,4,5,6,8),
                          labels = c('3c', '4c', '5c', '6c', '8c'))

set.seed(2018)

t.id <- createDataPartition(autos$mpg, 
                            p = 0.7, 
                            list = F)
# Nombres de las columnas
names(autos)

# Creaci�n de un modelo lineal

mod <- lm(mpg ~.,
          data = autos[t.id, -c(1,8,9)]) # Excluye columnas 1, 8 y 9

# Imprimir modelo de regresi�n
mod

# Una vez obtenidos los coeficientes, se prepara la siguiente f�rmula
# Para obtener un valor de millas por gale�n (mpg)
  # se multiplica por 0 o 1, en caso de ser de alg�n cilindraje

#       mpg = 38.607312  (Elegir sumar el cilindraje al que equivale, predice mpg)
#       + 7.212652 * 4c + 3.610350 * 6C + 6.211343  * 8c
#       +  0.006878 * displacement, - 0.072209 * horsepower 
#       - 0.005156 * weight + 0.024852 * acceleration


# Resumen del modelo 
summary(mod)

# Graficar residuos
boxplot(mod$residuals)


# Realizar predicci�n
pred <- predict(mod,
                autos[-t.id, 
                      -c(1,8,9)])

# Calcular el error cuadr�tico medio de la predicci�n
sqrt(mean((pred-autos[-t.id,]$mpg)^2))

# imprimir gr�ficos de residuales
par(mfrow = c(2,2))  # 2 filasy 2 columnas
plot(mod)


# Cambiar la referencia st�ndar (en el ejemplo anterior, el modelo utiliz� 3c como referencia, todos los dem�s comparaban contra �l)

auto <- within (autos,
                cylinders <- relevel(cylinders, 
                                     ref = '4c'))

mod <- lm(mpg~.,
          data=auto[t.id, -c(1,8,9)])
mod
# Ya no aparece el 4c (porque se tom� como referencia)
pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred-auto[-t.id, ]$mpg)^2))


# SIMPLIFICAR EL MODELO DE REGRESI�N
library(MASS)

mod
summary(mod)


# �Cuales variables nos quedamos y cuales no?
  ## modelo akaike

step.model <- stepAIC(mod, 
                      direction = 'backward') #Forward (a�adir variables)

summary(step.model)
step.model$anova
