
#Construye matriz de 16 elementos (secuencia de 1 en 1) en matriz de 4 *4
m <- matrix(seq(1,16),4, 4)
m

# Obtener el mínimo de cada fila en la matriz "m" (1 es para filas, 2 para columnas)
apply(m, 1, min)

# Obtener el mínimo de cada columna en la matriz "m" (1 es para filas, 2 para columnas)
apply(m, 2, min)


# Obtener el producto
apply(m, 2, prod)

# Obtener la suma
apply(m, 2, sum)

# Obtener el cuadrado de cada valor
apply(m, 
      c(1,2), # Por filas y columnas (aplica a todos los valores)
      function(x){x^2})

# 1      <- función aplicada por filas
# 2      <- función aplicada  a columnas
# c(1,2) <- función aplicada a elementos

# Calcular los quantiles de cada valor por filas
apply(m, 1, quantile, probs = c(0.40, 0.60, 0.80))



# Funciones (sumas y promedios por filas y columnas (alternativa adicional a APPLY))
colSums(m)
rowSums(m)

colMeans(m)
rowMeans(m)



# Crear un array de 3 dimensiones (secuencia del 1 al 32 en array de 4 * 4)
array3d <- array(seq(1,32), dim=c(4,4,2))
array3d


