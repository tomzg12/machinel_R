
   # SISTEMAS HIBRIDOS : UBCF + Random Selection
    # 31-05-2019

    # Invocar librer�a
    library(recommenderlab)
      
      # Descarga del dataset directamente de R
      data('MovieLense')
      
      # Dataset (no es un data set tradicional, es un dataset especial de R para grandes vol�menes de datos)
      data_frame <- MovieLense[rowCounts(MovieLense)>50, # por cada fila cada usuario haya valorado al menos 50 pel�culas
                               ]
      
      
      # Datos de entrenamiento
      train <- data_frame[1:10]  # primeros 100 usuarios
      test <- data_frame[101:110] # siguientes 110 usuarios      

      
      # Construcci�n del sistema h�brido
      hybrid_recom <- HybridRecommender(
        Recommender(train, 
                    method = 'UBCF'),
        Recommender(train, 
                    method = 'RANDOM'),
        weights = c(0.75,  # usuarios (UBCF)   # Pueden cambiarse las ponderaciones
                    0.25)  # aleatorio (random)
      )
      
      # Predicci�n (recomendar)
      predicted <- predict(hybrid_recom, # predecir con el conjunto h�brido
              test,   # utilizar el dataset TEST
              3)      # 3 recomendaciones
      
      
      # convertir en lista para su lectura
      as(predicted, 'list')
      
      
      