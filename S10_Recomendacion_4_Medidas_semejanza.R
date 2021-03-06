
###  Medidas de semejanza

      install.packages('lsa')
      
    
      library(SnowballC)
      library(lsa)      
#--------------------------------------------------------------------      
      # dataset
      data(mtcars)
      
      head(mtcars)      
      
      # eliminar columna X
      mtcars$X <- NULL

      
#--------------------------------------------------------------------      
 # DISTANCIA EUCL�DEA (entre m�s parecidos, la distancia es 0)
      
      coche1 <- mtcars[1,]
      coche2 <- mtcars[2,]      
      # Dados 2 coches, definir que tanto se parecen
      
      # Calcular la distancia eucl�eda entre 2 coches
      dist(coche1, coche2, 
           method = 'euclidean')
      # C�lculo manual de la distancia eucl�dea
      sqrt(sum((coche1-coche2)*(coche1-coche2)))
      
    # Ejercicio
      x1 <- rnorm(100)
      x2 <- rnorm(100)      
        
        # C�lculo de distancias
        dist(rbind(x1,x2),
             method = 'euclidean')      

        
#--------------------------------------------------------------------      
# COSENO
        # dos vectores
        v1 <- c(1,0,1,1,0,1,0,1,1,0,0,1)
        v2 <- c(1,1,1,0,1,1,1,1,0,1,1,0)
        
        # Calcular el coseno entre ellos
        cosine(v1,v2)        
        
        
        
#--------------------------------------------------------------------      
# Coeficiente de correlaci�n de Pearson
        pear <- cor(mtcars,
                    method = 'pearson')
        
        pear        
        
        
