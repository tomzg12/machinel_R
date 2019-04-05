# Importar dataset
  auto <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema2/auto-mpg.csv', 
                   stringsAsFactors =FALSE )

# Cambiar columna "cylinders" a factores
  auto$cylinders = factor(auto$cylinders,
                          levels = c(3,4,5,6,8),
                          labels = c("3c", "4c", "5c", "6c", "8c"))  

# Importar libreria
  library(lattice) 
  
# Crear un gráfico (BOXPLOT) Método 1 (Y~X)
  bwplot(~auto$mpg | auto$cylinders,   #<- MPG de autos en función cilindros
         main = 'MPG segun cilindrada',
         xlab = 'Millas por galeón',
         layout = c(2,3), aspect = 1)

# Crear un gráfico (SCATTERPLOT)
    # La barra vertical separa variables y factores
  xyplot(mpg~weight|cylinders, data = auto,
         main = 'Pesos vs consumo vs cilindrada',
         xlab = 'Peso(weight)',
         ylab = 'Consumo (mpg)')

  # bwplot, xyplot, densityplot, splom

    
# Para cambiar el tema de colores
  trellis.par.set(theme = col.whitebg())
  
  
  
  
  