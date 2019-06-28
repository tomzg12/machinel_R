
# Gráficos en 3D
  install.packages('plot3D')
  library(plot3D)  

# Dataset
  mtcars <-read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/mtcars.csv')
  head(mtcars)
  
# Cambiar el índice 
  rownames(mtcars) = mtcars$X

  mtcars$X <- NULL

  head(mtcars)  
  
  # Construcción del gráfico
    # Recomendable hacer gráficos con variables continuas (no categóricas)
  
  scatter3D(x = mtcars$disp,     # desplazamiento
            y = mtcars$wt  ,     # Peso en miles de libras
            z = mtcars$mpg ,     # profundidad (Millas por galeón)
            clab = c('Millas por galeón'),  # Leyenda
            pch = 19,                      # tipo de punto
            cex = 0.5,                       # tamaño de los puntos
            theta = 25,          # rotación eje vertical (azimutal)
            phi = 4,                         # rotación eje horizontal (colatitud)
            main = 'Autos de los 70s',       # Título
            xlab = 'Displacement (cu.ci)',
            ylab = 'Peso (x1000lb)',
            zlab = 'Millas por galeón',
            bty = 'g'              # COnfiguración de la caja 
                                      # f (cubo completo), #d (cubo incompleto) # g (fondo gris)
              )
  
  
# Texto en gráfico 3D------------------------------------------------------------------------------------------------
  text3D(x = mtcars$disp,     # desplazamiento
         y = mtcars$wt  ,     # Peso en miles de libras
         z = mtcars$mpg,
         labels = rownames(mtcars),
         add = TRUE,          # Agregar capa al gráfico anterior
         colkey = F,
         cex = 0.5
          )
  
  # HISTOGRAMA TRIDIMENSIONAL ----------------------------------------------------------------------------------------
    # Carga dataframe0
  data("VADeaths")
  head(VADeaths)  
  
    # Histograma
    hist3D(z = VADeaths, 
           scale = FALSE,
           expand =0.008,
           bty = 'g',
           phi = 30,
           col='#1188CC',
           border = 'black',
           shade = 0.5,
           ltheta = 80,
           space = 0.3,
           ticktype = 'detailed'
           )
  

    scatter3D(x = mtcars$disp,
              y = mtcars$wt,
              z = mtcars$mpg,
              type = 'h')  # l, # h, 
    