

      # Carga dataset
    protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
    
    rownames(protein) = protein$Country    
    protein$Country = NULL    

      protein.scaled <- as.data.frame(scale(protein))    

  # Carga de librer�as
      library(cluster)
      library(ggplot2)
      library(factoextra)

    # Uso de m�todo PAM
    km <- pam(protein.scaled,
              4# N�mero de medoides
    )

    # Imprimir tablas de clusters en pantalla (muestra MEDOIDES o paises principales)
    km      
            
    # Representaci�n gr�fica
    fviz_cluster(km)
    
    
    
    
    
    
    