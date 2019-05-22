

# IDENTIFICAR Y ELIMINAR CAMPOS QUE TIENEN ALTA CORRELACIÓN ENTRE SÍ MISMOS DENTRO DE UN DF
 # SE UTULIZA UN GRÁFICO DE CORRELACIÓN ENTRE VARIABLES

    install.packages('corrplot')  # Matriz de correlaciones
    library(corrplot)    

# Técnicas de redimensionamiento con Análisis de Componentes Principales
    
      # Carga de dataframe  
      bh <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/BostonHousing.csv')

      #ACP (Técnica) reducirá variables si se sospecha que están muy correlacionadas
      
    # Matriz de correlaciones
      corr<- cor(bh[,-14])
    
    # Imprime coeficientes de correlación
      corr      

    #Gráfica de matriz de correlaciones
      # Ejemplo 1
      corrplot(corr,
               method = 'color')
      # Correlaciones positivas en azul
      # Correlaciones negativas en rojo (una es contraria a la otra)
      
      # Ejemplo 2
      corrplot(corr,
               method = 'circle')
      
# ---- Análisis de componentes principales (ACP)------------------------------------------------------------------------------------------------
      # Este análisis tiene como objetivo eliminar variables con alta correlación (que no son necesarias)
      
      bh.acp <- prcomp(bh[,-14], # Se quita la última columna que es la de predicción
                       scale. = T   # con True utiliza la matriz de correlación, caso contrario, utiliza matriz de covarianzas
                       )
      
      # Resumen  
      summary(bh.acp)
      
      # Resultado------------
      #                          PC1    PC2     PC3     PC4     PC5     PC6     PC7     PC8    PC9    PC10
      #Standard deviation     2.4752 1.1972 1.11473 0.92605 0.91368 0.81081 0.73168 0.62936 0.5263 0.46930
      #Proportion of Variance 0.4713 0.1103 0.09559 0.06597 0.06422 0.05057 0.04118 0.03047 0.0213 0.01694
      #Cumulative Proportion  0.4713 0.5816 0.67713 0.74310 0.80732 0.85789 0.89907 0.92954 0.9508 0.96778
      
      # Cada componente (PC 1...), acumula la proporción, y hasta llegar a la proporción
      # acumulada, se seleccionan las variables
      
      
      # Gráfico
      plot(bh.acp)
      
      # Método del codo
      plot(bh.acp, 
           type= 'lines')
      
      # Diagráma biplot
      biplot(bh.acp, 
             col=c('gray', 'red'))
              # (De fondo se muestran todos los registros)
              # Zonas negativas y positivas (las positivas aportan más)
      
      # de los 5 primeros datos, sus compomentes principales
      head(bh.acp$x)
      
      # Matriz de rotaciones de cada una de las componentes principales
          # Positivas o negativas (positivas aportan más)
          bh.acp$rotation
          
      # Desviación estándar de cada una  de las componentes principales
      bh.acp$sdev
