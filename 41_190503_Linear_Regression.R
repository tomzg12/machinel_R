
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

# Creación de un modelo lineal

mod <- lm(mpg ~.,
          data = autos[t.id, -c(1,8,9)]) # Excluye columnas 1, 8 y 9

# Imprimir modelo de regresión
mod

# Una vez obtenidos los coeficientes, se prepara la siguiente fórmula
# Para obtener un valor de millas por galeón (mpg)
  # se multiplica por 0 o 1, en caso de ser de algún cilindraje

#       mpg = 38.607312  (Elegir sumar el cilindraje al que equivale, predice mpg)
#       + 7.212652 * 4c + 3.610350 * 6C + 6.211343  * 8c
#       +  0.006878 * displacement, - 0.072209 * horsepower 
#       - 0.005156 * weight + 0.024852 * acceleration


# Resumen del modelo 
summary(mod)

# Graficar residuos
boxplot(mod$residuals)


# Realizar predicción
pred <- predict(mod,
                autos[-t.id, 
                      -c(1,8,9)])

# Calcular el error cuadrático medio de la predicción
sqrt(mean((pred-autos[-t.id,]$mpg)^2))

# imprimir gráficos de residuales
par(mfrow = c(2,2))  # 2 filasy 2 columnas
plot(mod)


# Cambiar la referencia stándar (en el ejemplo anterior, el modelo utilizó 3c como referencia, todos los demás comparaban contra él)

auto <- within (autos,
                cylinders <- relevel(cylinders, 
                                     ref = '4c'))

mod <- lm(mpg~.,
          data=auto[t.id, -c(1,8,9)])
mod
# Ya no aparece el 4c (porque se tomó como referencia)
pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred-auto[-t.id, ]$mpg)^2))


# SIMPLIFICAR EL MODELO DE REGRESIÓN
library(MASS)

mod
summary(mod)


# ¿Cuales variables nos quedamos y cuales no?
  ## modelo akaike

step.model <- stepAIC(mod, 
                      direction = 'backward') #Forward (añadir variables)

summary(step.model)
step.model$anova
