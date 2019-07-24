
# Paquete maps
install.packages('maps')
library(maps)
  
    #Mapa del mundo (sin color)
    map('world', interior = F,  # Interior = F, elimina las fronteras
        fill = T, col = palette(rainbow(124)))

    
      # Buscar un país en específico      
      map('world', 'Mexico')
    
      map('france')
      map('italy')
      
      # Mapa de USA
      map('usa')  # trae el pais
        map('state') # Delimita los estados
          map('county')
      
          
      