
# Instalación de paquetes necesarios para trabajar con twitter
install.packages(c('twitteR', 'RColorBrewer', 'plyr', 
                 'ggplot2', 'devtools', 'httr'))
install.packages('Rcpp')
install.packages('sentimentr')
install.packages('slam')
require(devtools)

        # Instalación alternativa, directamente desde la página de R
        #install_url('https://cran.r-project.org/src/contrib/00Archive/Rstem/Rstem_0.4-1.tar.gz')
        #install_url('https://cran.r-project.org/src/contrib/00Archive/slam/slam_0.1-37.tar.gz')

install.packages('http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz')

### Invocación de librerías
library(slam)
library(sentimentr)
library(twitteR)

### Variables para la clave de la aplicación
api_key             <- 'IUeej4NimyAv51CIUbtDoZB8a'
api_secret          <- 'VkRqiFp9ipjLM2bVWLBEtYaAhaLnaiBeiVQFoltP6n4t5YiZh6'
access_token        <- '317107082-C0hEJHIURbThak1V9Wbj5emupVnkIvQQt8ovSr5E'
access_token_secret <- 'ahyBn2GTgtqt6I3AhINNnSUJVdUHMWzZh1VRW2lLpXHtc'

### Instalar conexión con la api de Twitter
setup_twitter_oauth(api_key,
                    api_secret,
                    access_token, 
                    access_token_secret)

### Descargar objeto Tweets
tweets <- searchTwitter('acapulco',      # Hashtag o palabra a buscar
                        n = 1000,        # Cantidad de tweets a descargar
                        lang = 'es')     # Idioma

### Conseguir el texto de los tweets
texts <- sapply(tweets, 
                function(x) x$getText())

head(texts, 20)
zoom <- texts[18]
print(zoom,list.len = 200000)

### Limpieza de los tweets descargados (utiliza expresiones regulares)
clean.data <- function(text){
  
  # eliminar retweets y @ del texto original
  text = gsub('(RT|VIA)((?:\\b\\W*@\\w+)+)', '', text)
  
  # eliminar signos de puntuacion y digitos del 0 al 9
  text = gsub('[[:punct:]]', '', text)
  text = gsub('[[:digit:]]', '', text)
  
  # eliminar links html, tabulaciones y espacios adicionales
  text = gsub('http\\w+','', text)
  
  text = gsub('[ \t]{2,}', '', text)
  
  text = gsub('^\\s+|\\s+$','', text)
  
}

### Ejecutar funcion

texts <- clean.data(texts)

head(texts)
print(texts[2], max = 1000)



handle.error <- function(x){
  # Crear valor omitido
  y = NA
  
  #try catch (intenta encontrar el error)
  try_error <- tryCatch(tolower(x),
                        error = function(e) e)
  # Si no hay error
  if(!inherits(try_error, 'error'))
    y= tolower(x)
  # devolvemos resultado
  return(y)
}

texts <- sapply(texts, handle.error)
head(texts)


texts <- texts[!is.na(texts)]

head(texts)

names (texts) <- NULL

head(texts)


#### Análisis de sentimientos with SENTIMENT R

class_emotion <- sentiment_by(texts)
class_emotion
polarity_proxy <- class_emotion[,4]


dist_data <- aggregate(class_emotion$element_id, by=list(class_emotion$ave_sentiment), FUN = length)
dist_data

library(ggplot2)
qplot(Group.1, x, data=dist_data, geom=c("boxplot", "jitter"), 
      fill=x, main="Análisis de sentimientos",
      xlab="Polaridad", ylab=" Cantidad de textos")


ggplot(dist_data, aes(x=x, y=Group.1)) + geom_point()
