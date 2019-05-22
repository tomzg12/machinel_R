# EPOCH: 1 de enero de 1970

      # Fecha de hoy
        Sys.Date()
        
        # Año podría ser con 2 o 4 dígitos
              # 4 dígitos
              as.Date('1/1/80', 
                      format = '%m/%d/%y')

              
        # Año podría ser con 2 o 4 dígitos
              # 2 dígitos
              as.Date('1/1/1980', 
                      format = '%m/%d/%Y')  #<- Y va en mayúscula
              
        # Formatos de fecha
        # yyyy-mm-dd  
              # yyy/mm/dd
              as.Date('2018-01-06')
              
              fecha <- as.Date("1988/05/19")
              
        # Fecha a número
              as.numeric(fecha) # Días
              
              as.numeric(Sys.Date()-fecha) # Diferencia en días
        
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
        
        
  # Fechas desde días de un punto dado (contando 2018 hacía adelante o atrás con el menos)
        as.Date(-2018, origin = as.Date('1985-12-02'))
        
  # Convertir en diferentes formatos de fecha
        # Año en 4 dígitos
        format(fecha, '%Y')
            # Convertir a numerico
              as.numeric(format(fecha, '%Y'))
              
              format(fecha, '%y')  #<minúscula
          # mes
        format(fecha, '%m')  #95
        format(fecha, '%b')  #may
        format(fecha, '%B')  #mayo
        months(fecha)   # mayo
        
        # dia
        weekdays(fecha) # día completo -- jueves
        
        format(fecha, '%d') # 19
        
        # Trimestre  - En que trimestre se encuentra esta fecha
        quarters(fecha)
        
        
        # julian (días desde el epoch - nacimiento de la informática actual)
        julian(fecha)
        
        
        
              