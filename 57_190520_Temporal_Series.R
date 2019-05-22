
install.packages('quantmod')  # Cargar datos en tiempo real
library(ggplot2)
library(quantmod)

#-----Dataframes descargados de la página de finanzas de Yahoo

      apple <- read.csv('G:/BD/CSV/FinanzasYahoo/AAPL.csv', 
                      stringsAsFactors = F)
      
      amazon <- read.csv('G:/BD/CSV/FinanzasYahoo/AMZN.csv', 
                        stringsAsFactors = F)
      
      google <- read.csv('G:/BD/CSV/FinanzasYahoo/GOOG.csv', 
                           stringsAsFactors = F)
      
      
      
        # Ver estructura del DF (STR)
          str(apple)
        
#-----Castear campo "date" ccomo fecha
        
        abf$Date = as.Date(abf$Date)
          abf$Volume = as.integer(abf$Volume)
        amazon$Date = as.Date(amazon$Date)
        apple$Date = as.Date(apple$Date)        
        google$Date = as.Date(google$Date)       
        
#-----Exploración inicial de datos (Gráfico)
        
        ggplot(apple, aes(Date, Close)) +
          geom_line(aes(color="Apple")) +
          geom_line(data=amazon, aes(color = "Amazon"))+
          geom_line(data=google, aes(color ="Google"))+
          labs(color="Legend")+
          scale_color_manual("", 
                             breaks = c("Apple", "Amazon", "Google" ),
                             values = c("blue", "green", "red"))+
          ggtitle("Comparaciones de cierre de stocks")+
          theme(plot.title = element_text(lineheight = 0.7, face = "bold"))
        
        
        
#-----Datos en Stream (COnsigue los datos de Apple en este ejemplo)
      getSymbols('AAPL')
        
      # Explorar los datos creando un gráfido de la serie temporal
      barChart(AAPL) 
        
      # remove(list='AAPL')
    
      chartSeries(AAPL, 
                  TA = 'NULL')
      chartSeries(AAPL[,4], TA = 'addMACD()') #movin average convergence-divergence
              