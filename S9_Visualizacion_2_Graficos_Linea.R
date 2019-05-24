
  # Gráficos de línea
  library(ggplot2)
  
  # load dataframe
  mtcars
  head(mtcars)
  
  # Crear plot --- 1
  plot <- ggplot(mtcars,
                 aes(x = wt, 
                     y =  mpg))
  # Capas de visualización
  plot +geom_line(linetype = 'dashed',
                  color = 'red')
  
  

  # Crear plot --- 2
  plot <- ggplot(mtcars,
                 aes(x = wt, 
                     y =  mpg))
  # Capas de visualización
  plot +geom_line(linetype = 'dashed', 
                  color = 'red')  # Líneas discontinuas y color
  plot + geom_line(aes(color = as.factor(carb)))  # Para representar
                                                  # basado en el tipo
                                                  # de carburador
  
  

  