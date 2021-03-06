
library(forecast)
# Modelos autoregresivos de media m�vil para series temporales
# se utiliza para corto plazo (los intervalos son muy amplios)

  inf <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/infy-monthly.csv')

  inf.ts <- ts(inf$Adj.Close, 
               start = c(1999, 3),
               frequency = 12)  

  inf.arima <- auto.arima(inf.ts)  
  
  summary(inf.arima)
  
  # predicci�n
  inf.fore <- forecast(inf.arima, 
                       h = 12) # n�mero de periodos
  
  plot(inf.fore, col = 'red',
       fcol = 'yellow') # color del forecast
  