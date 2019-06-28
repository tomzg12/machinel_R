#Filtros basados en el contenido
movie_url <- "http://files.grouplens.org/datasets/movielens/ml-100k/u.item"
users_url <- "http://files.grouplens.org/datasets/movielens/ml-100k/u.data"


# Dataset 1 (películas)
movie_title_df <- read.table(movie_url,
                             header=F, 
                             sep = "|",
                             quote = "\"")

# Dataset 2 (valoraciones de usuarios)
users_df <- read.table(users_url, header = F,
                       sep = "\t", quote = "\"")

# Cambiar nombre de los campos del dataset de peliculas
names(movie_title_df) <- c("MovieID", "Title","ReleaseDate",
                           "video_release_date",
                           "IMDb_URL", "unknown", "Action", "Adventure",
                           "Animation", "Childrens", "Comedy", "Crime",
                           "Documentary", "Drama", "Fantasy",
                           "FilmNoir", "Horror", "Musical",
                           "Mystery", "Romance", "SciFi",
                          "Thriller", "War", "Western")

# Head del dataset
head(movie_title_df)


# Anular variables que no influyen en la decisión
movie_title_df$ReleaseDate <- NULL
movie_title_df$video_release_date <- NULL
movie_title_df$IMDb_URL <- NULL

# Sobreescribir para eliminar peliculas duplicadas
movie_title_df <- unique(movie_title_df)

# Nombrar columnas del 2o dataframe

head(users_df)
names(users_df) <- c("UserID", "MovieID", "rating", "timestamp")

# Eliminar columna de nulos
users_df$timestamp <- NULL
str(movie_title_df)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------Método K-MEANS  Y SEGMENTAR A UTILIZANDO EL GÉNERO (CLÚSTERS)-----------------------------------------------------------------------------------------------

      # Función para clusterizar películas
      clusterMovies <- function(df, kclust = 10){
        #set.seed(2018)
        df <- df[,c(-1,-2)]  # Quitar columna 1 y 2
        mclust <- kmeans(df, centers = kclust, nstart = 20)  # correr clúster
        return(mclust)
      }
      
      # Función para culsterizar usuarios
      getUserInfo <- function(df, id){
        myUser <- subset(df, UserID == id, select = c(MovieID, rating))
        cluster <- 0
        activeUser <- data.frame(myUser[order(myUser$MovieID),], cluster)
        return(activeUser)
      }


      
        # Número de clúster a cada película que ha visto el usuario      
        setUserMovieCluster <- function(m_title_df, mclust, activeUser){
          df_aux <- data.frame(cbind(m_title_df$MovieID, 
                                     clustNum = mclust$cluster))
          names(df_aux) <- c("MovieID", "Cluster")
          activeUser$cluster <- df_aux[match(activeUser$MovieID, df_aux$MovieID),2]
          return(activeUser)
        }


getAverageClusterRating <- function(mclust, activeUser, minRating = 3){
  like <- aggregate(activeUser$rating, 
                    by=list(cluster=activeUser$cluster), 
                    mean)
  if(max(like$x)<minRating){
    like <- as.vector(0)
  } else {
    like <- as.vector(t(max(subset(like, x>=minRating, select=cluster))))
  }
  return(like)
}

getRecommendedMovies <- function(like, mclust, m_title_df){
  df_aux <- data.frame(cbind(m_title_df$MovieID, 
                             clusterNum = mclust$cluster)
  )
  names(df_aux) = c("MovieID", "Cluster")
  if(like==0){
    recommend <- m_title_df[sample.int(n = nrow(m_title_df),
                                       size = 100),1]
  } else {
    recommend <- as.vector(
      t(subset(df_aux, 
               Cluster == like, 
               select = MovieID
      )
      )
    )
  }
}


getRecommendations <- function(movie_df, user_df, userID){
  mclust <- clusterMovies(movie_df)
  activeUser <- getUserInfo(user_df, userID)
  activeUser <- setUserMovieCluster(movie_df, mclust, activeUser)
  like <- getAverageClusterRating(mclust, activeUser)
  recomendation <- getRecommendedMovies(like, mclust, movie_df)
  #eliminamos las pelÃ?culas que el usuario ya ha visto
  recomendation <- recomendation[-activeUser$MovieID]
  #aÃ±adimos el tÃ?tulo de la pelÃ?cula
  movieTitle <- movie_df[match(recomendation, movie_df$MovieID),2]
  recomendation <- data.frame(recomendation, movieTitle)
  return(recomendation)
}

suggestMovies <- function(movie_df, user_df, user_id, num_movies){
  suggestions <- getRecommendations(movie_df, user_df, user_id)
  suggestions <- suggestions[1:num_movies,]
  writeLines("Tal vez te gustaría ver también las siguientes películas:")
  write.table(suggestions[2], row.names = F, col.names = F)
}

# Ejecutar sistema de funciones para recomendar películas
suggestMovies(movie_title_df, users_df, 
              205, # Número de usuario
              10)  # Cantidad de películas a recomendar

movie_title_df[match(movie_title_df$MovieID,
                     users_df[users_df$UserID==196,]$MovieID),2]



