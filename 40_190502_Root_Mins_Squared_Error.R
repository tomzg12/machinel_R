

# Importar el dataset 
  dat <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/rmse.csv')
  
  
  # ---Referencia
  # En el DS existen 2 columnas, la primera contiene valores originales, la segunda contiene valores predichos.
    # La técnica consiste en elevar al cuadrado la diferencia de los errores (para que dé positivo)
      # después se calcula el promedio (para conocer el valor promedio del error)
        # Luego se calcula raíz cuadrada

## Cálculo del error cuadrático medio (1)  
rmse <- sqrt(mean((dat$price - dat$pred)^2))
cat(paste('El error cuadrático medio es de :', rmse))

## Gráficar datos reales vs predicción
plot(dat$price,
     dat$pred,
     xlab = 'actual',
     ylab = 'predicho', 
     col = 'green')
# Imprimir recta que pasa por el cero y tiene pendiente 1 (recta perfecta esperada)
  # El objetivo es que las predicciones caigan lo más cerca posible de la recta
abline(0,1, 
       col= 'red')

### Creación de función-------------------

rmse <- function(actual, predicted){

# Compila la media de las dos columnas
  cat(paste('La media del valor actual es de : \n'))
  print(mean(actual))
              # Imprime espacio
               cat(paste('\n'))
  cat(paste('La media del valor predicho es de :\n'))
  print(mean(predicted))
              # Imprime espacio
               cat(paste('\n'))
        

# Compila el cálculo del error cuadrático medio             
  cat(paste('El error cuadrático medio es de :\n'))
  return(sqrt(mean((actual-predicted)^2)))
}

#Ejecutar la función
rmse(dat$price, dat$pred)







