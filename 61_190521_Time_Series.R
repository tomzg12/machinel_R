# Ejercicio de prueba utilizando series temporales


    s <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/ts-example.csv')
    
    head(s)
  
    # Construir una serie temporal (agrega tiempo de inicio y fin)
    s.ts <- ts(s)

    # Saber que clase de objeto (class)
    class(s.ts)
    
    head(s.ts)
  
    plot(s.ts)
    
  # Para determinar un valor de inicio
    s.ts.a <- ts(s, start = 2001)
    s.ts.a        
    
    plot(s.ts.a)
    
  # Serie temporal para datos mensuales
    s.ts.m <- ts(s, start = c(2001, 1), frequency = 12)  # 12 muestras cada año
    s.ts.m    
    
  # Serie temporal trimestral (muestras)
    s.ts.1 <- ts(s, start = c(2001, 1), frequency = 4)  # 4 muestras cada año
    s.ts.1    
    
    plot(s.ts.1)
    
# Para saber cuando inicia y cuando termina
    start(s.ts.1)
    end(s.ts.1)    
    frequency(s.ts.1)    

    
#_----------------------EJERCICIO 2--------------------------------
    # precio de la harina en USA y la gasolina
    prices <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema6/prices.csv')

    head(prices)

    # Serie temporal
    prices.ts <- ts(prices, 
                    start = c(1980, 1), 
                    frequency = 12)
    # Observar tabla
    prices.ts       
    
    # Gráfico
    plot(prices.ts)
        
    # Juntar los gráficos
    plot(prices.ts, 
         plot.type = 'single',
         col = 1:2) # Columnas
    legend('topleft',    # Agregar una leyenda en la esquina superior izquierda
           colnames(prices.ts), # nombres de las columnas
           col = 1:2,  # columna 1 y 2
           lty = 1)  # indicar el tamaño y la anchura de las líneas
    
    
    
  