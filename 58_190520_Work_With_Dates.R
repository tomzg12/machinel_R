# EPOCH: 1 de enero de 1970

      # Fecha de hoy
        Sys.Date()
        
        # A�o podr�a ser con 2 o 4 d�gitos
              # 4 d�gitos
              as.Date('1/1/80', 
                      format = '%m/%d/%y')

              
        # A�o podr�a ser con 2 o 4 d�gitos
              # 2 d�gitos
              as.Date('1/1/1980', 
                      format = '%m/%d/%Y')  #<- Y va en may�scula
              
        # Formatos de fecha
        # yyyy-mm-dd  
              # yyy/mm/dd
              as.Date('2018-01-06')
              
              fecha <- as.Date("1988/05/19")
              
        # Fecha a n�mero
              as.numeric(fecha) # D�as
              
              as.numeric(Sys.Date()-fecha) # Diferencia en d�as
        
        # Nombre de los meses              
          as.Date("Enero 6, 2018", 
                      format = "%b %d, %Y")
              
        # Nombre de los meses              
              as.Date("Enero 6, 18", 
                      format = "%b %d, %y")
              
              
      # Calcular diferencia con set de fecha (date) a partir del epoch
        dt <- 2018
        class(dt) <- 'Date'
        dt                      
        
        # Calcular diferencia con set de fecha (date) a partir del epoch
        dt <- -2018
        class(dt) <- 'Date'
        dt                      
        
        
  # Fechas desde d�as de un punto dado (contando 2018 hac�a adelante o atr�s con el menos)
        as.Date(-2018, origin = as.Date('1985-12-02'))
        
  # Convertir en diferentes formatos de fecha
        # A�o en 4 d�gitos
        format(fecha, '%Y')
            # Convertir a numerico
              as.numeric(format(fecha, '%Y'))
              
              format(fecha, '%y')  #<min�scula
          # mes
        format(fecha, '%m')  #95
        format(fecha, '%b')  #may
        format(fecha, '%B')  #mayo
        months(fecha)   # mayo
        
        # dia
        weekdays(fecha) # d�a completo -- jueves
        
        format(fecha, '%d') # 19
        
        # Trimestre  - En que trimestre se encuentra esta fecha
        quarters(fecha)
        
        
        # julian (d�as desde el epoch - nacimiento de la inform�tica actual)
        julian(fecha)
        
        
        
              