
ozone.data <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/ozone.csv')


# Detecci�n r�pida de Outliers (diagrama de caja y bigotes)

 boxplot(ozone.data$pressure_height,  # Selecci�n Datos y columna
        main = 'Pressure Height',    # T�tulo
        boxwex = 0.3      # Ancho de la caja
          )

 
 summary(ozone.data$pressure_height)
 
 
 # Representar dos variables en diagrama de caja y bigores
 boxplot(pressure_height     # la presi�n en funci�n (~) del mes
         ~ Month,
         data = ozone.data,  # El data set se indica en la instrucci�n "data"
         main = 'Pressure highs per month'
         )
 
 # �C�mo se distribuye el Ozono a lo largo del a�o?
 boxplot(ozone_reading ~ Month, # Campo lectura de ozono en funci�n al mes
         data = ozone.data,     # Dataframe proveedor de datos
          main = 'Ozone reading per month'    # T�tulo
 )
 
 
 
 # Se pueden acceder directamente a los outliers
 
 boxplot(ozone_reading ~ Month,                      # Campo lectura de ozono en funci�n al mes
         data = ozone.data,                          # Dataframe proveedor de datos
         main = 'Ozone reading per month',           # T�tulo
         boxwex= 0.9                                 # Ancho de la caja
 )$out                  #<----------- En consola aparecen directamente los outliers
 
 # Pueden escribirse los outliers encima de la caja
 mtext('# 11.06  9.93 22.89 24.29 29.79 ')
 
 
 
 # CORRECCI�N DE OUTLIERS (FUNCI�N - 1er m�todo)
   # Pueden sustituirse los valores por la media o la mediana
 
impute_outliers <-function(x, removeNA = TRUE){
   quantiles <- quantile(x, c(0.05, 0.95),
                         na.rm = removeNA)
   x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
   x[x>quantiles[2]] <- mean(x, na.rm = removeNA)
   x
}
 
imputed_data <- impute_outliers(ozone.data$pressure_height)

 # ordenar gr�ficos en una vista 
 
par(mfrow = c(1,2))    # Una fila, dos columnas

 # Primer boxplot
boxplot(ozone.data$pressure_height, 
         main = 'Presi�n con outliers')
boxplot(imputed_data, main = 'Presi�n sin outliers')
 
 
 
# CORRECCI�N DE OUTLIERS (FUNCI�N - 2o m�todo)
# QUARTILES

replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
  iqr <- qrts[2]-qrts[1]
  h <- 1.5 * iqr
  x[x<qrts[1]-h] <- caps[1]
  x[x>qrts[2]+h] <- caps[2]
  x
}
 

capped_pressure_height <- replace_outliers(ozone.data$pressure_height)

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, 
        main = 'Presi�n con outliers')
boxplot(capped_pressure_height, main = 'Presi�n sin outliers')

 
 