

   # Promedios móviles para series temporales

  s<- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/ts-example.csv')

  plot(s$sales, type = 'l')
  
  # Filtro de 7 periodos (se tiene que elegir la cantidad de periodos a de la serie temporal)
  n <- 7

  # Weights
  weights <- rep(1/n , n)  # repite 1 / 7, 7 veces
  weights  
  
  # primer valor filtrado (Promedios móviles)
  s.fil.1 <- filter(s$sales, 
                    filter = weights,
                    sides = 2)
  # agregar linea a gráfico (linea suavizada)
  lines(s.fil.1, 
        col = 'blue', 
        lwd = 3)
  
#----------------2o técnica filtrado---------------
  s.fil.2 <- filter(s$sales, 
                    filter = weights,
                    sides = 1)
  lines(s.fil.2, col = 'red', lwd = '3')
  
  