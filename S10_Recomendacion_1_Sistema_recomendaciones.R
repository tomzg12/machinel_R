
  # Sistema de recomendaciones 27-05-2019

  install.packages('recommenderlab')
  library(recommenderlab)
  
  # Carga datset
  data("MovieLense")
    # vista preliminar base de datos
    head(MovieLense)
    
    
    # Filtrar pel�culas mejor valoradas
    rating_movies <- MovieLense[rowCounts(MovieLense)>50,   # personas con m�s de 50 valoraciones
                                colCounts(MovieLense)>100]  # peliculas con m�s de 100 vistas
    
    # Subconjunto de pel�culas (conjunto de entrenamiento -80 y 20 validaci�n)
    t.id <- sample(x= c(T,F),
                   size = nrow(rating_movies),
                   replace = T,
                   prob=c(0.8,0.2))
    
    # Conjuntos de entrenamiento y de validaci�n
    data_train <- rating_movies[t.id, ]
    data_test <- rating_movies[!t.id,]    
    
    # Filtros (t�cnicas de filtrado colaborativo)
          # Basado en �tems
    
          # Cuando son grandes set de datos, se accede a las variables con @
          rating_movies@data  # (matriz sparset)
          
          
          # acceder a coordenadas espec�ficas de la matriz
          rating_movies@data[1,1] # fila 1, columna 1
          
          rating_movies@data[1,]  # 1a columna todas las filas
          
          rating_movies@data[,1]  # todas las filas 1a columna
          
          
#---------- 1er tipo de filtrado (colaborativo en �tems IBCF)----------------------------------
            # Solo valorar� los �tems (productos comprados por el usuario y recomendar� otros)
            # El modelo busca par�metros (calificaciones similares)
            # El modelo buscar� los k m�s similares para cada usuario (basado en las compras del usuario)
          
          ibcf <- Recommender(data = data_train, 
                              method = 'IBCF',
                              parameter = list(k = 30))
          
          
          # Prueba
          ibcf.mod <- getModel(ibcf)
          
          # Imprime matriz sparcet
          ibcf.mod          
          
          #----------ENCONTRAR RECOMENDACIONES QUE PODR�AMOS DAR--------------------------------------
          
          # n�mero de recomendaciones 
          n_rec <-10

          # Tomar 10 recomendaciones con base en predicci�n (tomar todo el modelo ibcf recommender)
          ibcf.pred <- predict(object = ibcf,   # dataset de recomendacion
                               newdata = data_test, # nuevo dataset
                               n = n_rec)   # n�mero de recomendaciones
          
          # imprimir predicci�n
          ibcf.pred
          
          # matriz de recomendaci�n
          ibcf.rec.matrix <- sapply(ibcf.pred@items, 
                                    function(x){
                                      colnames(rating_movies)[x]}
                                    )

          
          ibcf.rec.matrix[,1:3]  # todas las filas, cantidad de usuarios          
          View(ibcf.rec.matrix[,1:3])          
          
    
#---------- 1er tipo de filtrado (colaborativo en usuarios IBCF)----------------------------------   
    
          ubcf <- Recommender(data = data_train, 
                              method = 'UBCF')
          
          # modelo
          ubcf.mod <- getModel(ubcf)
          ubcf.mod
        
          
          # Predicci�n basada en usuarios
          ubcf.pred <- predict(object = ubcf, 
                               newdata = data_test,
                               n = n_rec)  # No. recomendaciones por usuario

          # Matriz de recomendaci�n
          ubcf.rec.matrix <- sapply(ubcf.pred@items,
                                    function(x){
                                      colnames(rating_movies)[x]
                                      
                                    })
          
          View(ubcf.rec.matrix[,1:3])
          
          
          # Head de las predicciones
          head(ubcf.pred@items)
          
          
# -------REPRESENTAR LA MATRIZ DE RECOMENDACIONES--------------------------------------------------------
          
          recommender_models <- recommenderRegistry$get_entries(dataType = 'realRatingMatrix')
          
          # Muestra los algoritmos para poder generar sistemas de recomendaciones
          names(recommender_models)
          
          # Genera un mapa de calor del dataset original de las valoraciones
          image(MovieLense, 
                main = 'Mapa de calor de valoraciones de pel�culas')
          
          
          # Extraer el cuantil m�s alto 
          
          min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
          min_n_users <- quantile(colCounts(MovieLense),0.99)
          
          min_n_movies
          min_n_users
          
          # C�mo ya sabemos a partir de que n�mero inicia el quantil, hacer nuevamente la imagen
            # con usuarios con m�s de 370 pel�culas vistas (quantil) y peliculas vistas por al menos 440 usuarios.
          
          
          image(MovieLense[rowCounts(MovieLense)>min_n_movies,
                                     colCounts(MovieLense)>min_n_users])
          
          ## Aplicar imagen a dataset filtrado anteriormente
          min_r_movies <- quantile(rowCounts(rating_movies), 0.98)
          min_r_users <- quantile(colCounts(rating_movies), 0.98)
          image(rating_movies[rowCounts(rating_movies)>min_r_movies,
                              colCounts(rating_movies)>min_r_users])
          
          
          
          
          
          
          