
  # Sistema de recomendaciones 27-05-2019

  install.packages('recommenderlab')
  library(recommenderlab)
  
  # Carga datset
  data("MovieLense")
    # vista preliminar base de datos
    head(MovieLense)
    
    
    # Filtrar películas mejor valoradas
    rating_movies <- MovieLense[rowCounts(MovieLense)>50,   # personas con más de 50 valoraciones
                                colCounts(MovieLense)>100]  # peliculas con más de 100 vistas
    
    # Subconjunto de películas (conjunto de entrenamiento -80 y 20 validación)
    t.id <- sample(x= c(T,F),
                   size = nrow(rating_movies),
                   replace = T,
                   prob=c(0.8,0.2))
    
    # Conjuntos de entrenamiento y de validación
    data_train <- rating_movies[t.id, ]
    data_test <- rating_movies[!t.id,]    
    
    # Filtros (técnicas de filtrado colaborativo)
          # Basado en ítems
    
          # Cuando son grandes set de datos, se accede a las variables con @
          rating_movies@data  # (matriz sparset)
          
          
          # acceder a coordenadas específicas de la matriz
          rating_movies@data[1,1] # fila 1, columna 1
          
          rating_movies@data[1,]  # 1a columna todas las filas
          
          rating_movies@data[,1]  # todas las filas 1a columna
          
          
#---------- 1er tipo de filtrado (colaborativo en ítems IBCF)----------------------------------
            # Solo valorará los ítems (productos comprados por el usuario y recomendará otros)
            # El modelo busca parámetros (calificaciones similares)
            # El modelo buscará los k más similares para cada usuario (basado en las compras del usuario)
          
          ibcf <- Recommender(data = data_train, 
                              method = 'IBCF',
                              parameter = list(k = 30))
          
          
          # Prueba
          ibcf.mod <- getModel(ibcf)
          
          # Imprime matriz sparcet
          ibcf.mod          
          
          #----------ENCONTRAR RECOMENDACIONES QUE PODRÍAMOS DAR--------------------------------------
          
          # número de recomendaciones 
          n_rec <-10

          # Tomar 10 recomendaciones con base en predicción (tomar todo el modelo ibcf recommender)
          ibcf.pred <- predict(object = ibcf,   # dataset de recomendacion
                               newdata = data_test, # nuevo dataset
                               n = n_rec)   # número de recomendaciones
          
          # imprimir predicción
          ibcf.pred
          
          # matriz de recomendación
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
        
          
          # Predicción basada en usuarios
          ubcf.pred <- predict(object = ubcf, 
                               newdata = data_test,
                               n = n_rec)  # No. recomendaciones por usuario

          # Matriz de recomendación
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
                main = 'Mapa de calor de valoraciones de películas')
          
          
          # Extraer el cuantil más alto 
          
          min_n_movies <- quantile(rowCounts(MovieLense), 0.99)
          min_n_users <- quantile(colCounts(MovieLense),0.99)
          
          min_n_movies
          min_n_users
          
          # Cómo ya sabemos a partir de que número inicia el quantil, hacer nuevamente la imagen
            # con usuarios con más de 370 películas vistas (quantil) y peliculas vistas por al menos 440 usuarios.
          
          
          image(MovieLense[rowCounts(MovieLense)>min_n_movies,
                                     colCounts(MovieLense)>min_n_users])
          
          ## Aplicar imagen a dataset filtrado anteriormente
          min_r_movies <- quantile(rowCounts(rating_movies), 0.98)
          min_r_users <- quantile(colCounts(rating_movies), 0.98)
          image(rating_movies[rowCounts(rating_movies)>min_r_movies,
                              colCounts(rating_movies)>min_r_users])
          
          
          
          
          
          
          