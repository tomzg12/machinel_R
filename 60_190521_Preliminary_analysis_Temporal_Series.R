
# An�lisis temporal de series de datos
      
  wmt <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/WMT.csv', 
                  stringsAsFactors = F)

# Crear esquema para gr�fico (1 fila y 2 columnas)
  par(mfrow = c(1,1))
  
  
  # Representar la info en un diagr�ma de l�neas
  plot(wmt$Adj.Close,
       type ='l', 
       col= 'blue')
  
  #Calcular diferencia vs d�a anterior
  dif_da <- diff(wmt$Adj.Close)  # tiene un elemento menos que el dset original
  head(dif_da)
  
  plot(dif_da, type = 'l', col = 'red')
  

  # histograma
  hist(dif_da, prob = T, 
       ylim = c(0, 0.8),   # l�mites eje vertival
       xlim = c(-5,5),     # l�mites eje horizontal
       main = 'Walmart Stocks',
       breaks =  30,
       col = 'green')
  
  lines(density(dif_da), 
        lwd = 2) # ancho de la l�nea
  
  
#------TRABAJAR CON UNA SERIE TEMPORAL DE WALMART -------MENSUALIZADA
  
  #Dataset
  wmt.m <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/WMT-monthly.csv')
  wmt.m <- wmt.m[2:nrow(wmt.m), ]
  
  # Crear serie temporal utilizando una columna
  wmt.m.ts <-ts(wmt.m$Adj.Close)
  
  # Crear diferencias de la columna en la serie temporal
  dif_m <- diff(wmt.m.ts)
  dif_m  
  
  # Aplicar funci�n lag (sirve para contar diferencias de 2 en 2, o de 3 en 3 seg�n valor)
  # Incrementos porcentuales
  wmt.m.return <- dif_m / lag((wmt.m.ts), k = -1)
    
  # Gr�fico histograma
  hist(wmt.m.return, prob = T, col = 'blue', breaks = 20)
  
  
  