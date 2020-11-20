install.packages('tm')
install.packages('tidytext')
install.packages('stringr')
install.packages('wordcloud2')
install.packages('wordcloud')
install.packages('RColorBrewer')
install.packages('syuzhet')

library(NLP)
library(tm)
library(slam)
library(sentimentr)
library(twitteR)
library(tidytext)
library(stringr)
library(wordcloud2)
library(RColorBrewer)
library(wordcloud)



### Instalar conexión con la api de Twitter
  setup_twitter_oauth(api_key,
                    api_secret,
                    access_token, 
                    access_token_secret)

### Palabra a buscar y cantidad de tweets
  word.t <- '#AMLOMxTeReclama'
  n = 1000

#-----> Descargar objeto por texto en el Tweeter <-------------------------------------------------
  tweets <- searchTwitter(word.t,      # Hashtag o palabra a buscar
                        n = n,        # Cantidad de tweets a descargar
                        lang = 'es')     # Idioma
  
  ### Inspección de twitters
  # Crear un dataframe
  df.t <- do.call("rbind", lapply(tweets, as.data.frame))
  
  # Revisar los nombres del dataframe
  names(df.t)
  
  # Exportar dataframe en un CSV
  # df <- do.call("rbind", lapply(tws, as.data.frame))

#---> Descargar objeto por usuario de tweeter <---------------------------------------------------  
  t_user <- getUser('ViajaBonito')
  timeline_user <- userTimeline(t_user,n=100)
  #Transformar en dataframe
  df.user <- twListToDF(timeline)
#-------------------------------------------------------------------------------------------------  

#- Limpieza de datos
    # Eliminar retweets y crear un nuevo dataset
    df_clean <- df.t[df.t$isRetweet == 'FALSE',]
    
    # Limpieza del dataset (columna de texto)
    df.cl_txt <- Corpus(VectorSource(df_clean$text))
      # df.cl_txt <- tm_map(df.cl_txt, content_transformer(tolower))
        # df.cl_txt<- tm_map(df.cl_txt, removeWords, stopwords('spanish'))
          # df.cl_txt<- tm_map(df.cl_txt, removeNumbers)
            df.cl_txt<- tm_map(df.cl_txt, removePunctuation)
          
          removeURL <- function(x) gsub('http[[:alnum:]]*','',x)
              df.cl_txt<- tm_map(df.cl_txt, content_transformer(removeURL))
          
          removeURL <- function(x) gsub('edua[[:alnum:]]*','',x)
          df.cl_txt<- tm_map(df.cl_txt, content_transformer(removeURL))
                                                    
          removeASCII <- function(x) textclean::replace_non_ascii(x)
          df.cl_txt<- tm_map(df.cl_txt, content_transformer(removeASCII))
          
          #df.cl_txt<- tm_map(df.cl_txt, removeWords,
                             #c('amp', 'ufef', 'ufeft', 'uufefuufefuufef', 'uufef','s'))
                             
          df.cl_txt <- tm_map(df.cl_txt, stripWhitespace)
          str_trim(df.cl_txt)
          
          #inspect(df.cl_txt[1:10])
  
## Agregar columna de texto limpio al dataset original
                
                # Convertir en columna la lista limpia
          clean_column <- ldply(df.cl_txt, data.frame)
                # Agregar al data set original
          df_clean$clean_column <- clean_column
                    #Nombres de columnas
                    names(df_clean)          
                    
    
##-------Sentiment analysis--------------------
                    
            emotions <- get_nrc_sentiment(df.cl_txt$content,
                                          language = 'spanish')
              
            barplot(colSums(emotions), 
                    cex.names = .7,
                    col = rainbow(10),
                    main = paste('Rango sentimental de tweets para la palabra','- ', 
                                 word.t,' -', '\n',Sys.Date())
                    )
            
            
            
                    
### ---- Sentiment positive / negative rating
            inspect(df.cl_txt[1:10])
            get_sentiment(df.cl_txt$content[1:10])
            
            
            sentimiento <- get_sentiment(df.cl_txt$content)
            df_clean <- dplyr::bind_cols(df_clean, data.frame(sentimiento))
            
            # Borrar columna del dataframe
            # df_clean = subset(df_clean, select = -c(sent) )
        
            # Función para analizar los sentimientos en la columna de sentimientos      
            meansent <- function(i,n){
              mean(df_clean$sentimiento[i:n])
            }
            
            # Ejecuta función (rango de filas)
            scores_by_range <- meansent(400,500)
            scores_by_range     
          
            # WordCloud
        wordcloud(df.cl_txt, min.freq = 100, random.order = FALSE)
            
            
### ---- Cluster analisis
            # convertir a palabras base
            twitterCorpus <- tm_map(df.cl_txt, stemDocument)
            # Construir matriz de términos del documento
            dtm <- DocumentTermMatrix(twitterCorpus)
            dtm            
            mat <- as.matrix(dtm)
            # Crear matriz de distancias
            d<- dist(mat)
            # Incrustar matriz de distancias en un cluster, mediante el método ward.D
            groups <- hclust(d, method = 'ward.D')
            #Graficar el cluster
            plot(groups, hang= 1)
            # Podar el árbol
            cut = cutree(groups, k = 6)            
            newMat <- dplyr::bind_cols(df_clean, data.frame(cut))
            table(newMat$screenName,
                  newMat$cut)            
            
