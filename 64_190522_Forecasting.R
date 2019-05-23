

# Pronósticos con series temporales
    inf <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/infy-monthly.csv')
    tail(inf)
    
    
    inf.ts <- ts(inf$Adj.Close,
                 start = c(1999,3),  # A partir de marzo 1999
                 frequency = 12)    # 12 series por año

        plot(inf.ts)

# Suavizado con Holt Winters
        
        inf.hw <- HoltWinters(inf.ts)
        head(inf.hw)        
        
  plot(inf.hw, 
       col = 'blue',
       col.predicted = 'red')

  # suma de cuadrados de los errores al cuadrado entre valores reales y ajustados
  inf.hw$SSE

  inf.hw$alpha

  inf.hw$beta
  
  inf.hw$gamma
  

### ---fitted (valores ajustados)
  head(inf.hw$fitted)
  
  
### Predicciones con la librearia forecast
#  install.packages('forecast')
  library(forecast)

  infy.fore <- forecast(inf.hw ,
                         h = 12) # predecir 24 meses

    # 95 % de confianza en tono obscuro
    # 85 % en tono más claro
  plot(infy.fore)  
    
  # Mostrar datos predichos de lower & upper (intervalos de confianza)
  infy.fore$lower  # Zona inferior
  infy.fore$upper  # zona superior
  
  
  
  
  
  