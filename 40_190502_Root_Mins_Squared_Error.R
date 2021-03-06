

# Importar el dataset 
  dat <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/rmse.csv')
  
  
  # ---Referencia
  # En el DS existen 2 columnas, la primera contiene valores originales, la segunda contiene valores predichos.
    # La t�cnica consiste en elevar al cuadrado la diferencia de los errores (para que d� positivo)
      # despu�s se calcula el promedio (para conocer el valor promedio del error)
        # Luego se calcula ra�z cuadrada

## C�lculo del error cuadr�tico medio (1)  
rmse <- sqrt(mean((dat$price - dat$pred)^2))
cat(paste('El error cuadr�tico medio es de :', rmse))

## Gr�ficar datos reales vs predicci�n
plot(dat$price,
     dat$pred,
     xlab = 'actual',
     ylab = 'predicho', 
     col = 'green')
# Imprimir recta que pasa por el cero y tiene pendiente 1 (recta perfecta esperada)
  # El objetivo es que las predicciones caigan lo m�s cerca posible de la recta
abline(0,1, 
       col= 'red')

### Creaci�n de funci�n-------------------

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
        

# Compila el c�lculo del error cuadr�tico medio             
  cat(paste('El error cuadr�tico medio es de :\n'))
  return(sqrt(mean((actual-predicted)^2)))
}

#Ejecutar la funci�n
rmse(dat$price, dat$pred)







