

      # Carga dataset
    protein <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/protein.csv')
    
    rownames(protein) = protein$Country    
    protein$Country = NULL    

      protein.scaled <- as.data.frame(scale(protein))    

  # Carga de librerías
      library(cluster)
      library(ggplot2)
      library(factoextra)

    # Uso de método PAM
    km <- pam(protein.scaled,
              4# Número de medoides
    )

    # Imprimir tablas de clusters en pantalla (muestra MEDOIDES o paises principales)
    km      
            
    # Representación gráfica
    fviz_cluster(km)
    
    
    
#-------- CLARA (Clustering Large Range)
            #Utiliza muestras del set de datos completo y muy grande
    
    # Invocar el algoritmo
    clarafit <- clara(protein.scaled,  # dataset
                      4,               # Número de clúster utilizando las muestras   
                      samples = 5      # Número de muestras del dataset
                      )
    
    # Imprime clústers en pantalla
    clarafit
    
    # imprime gráfico
    fviz_cluster(clarafit)
    