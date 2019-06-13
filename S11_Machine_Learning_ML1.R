# Machine learning
  # 04-06-2019

   # Consulta de repositorios dónde descargar librerías para R
repos <- getOption("repos")
repos["mxnet"]<- NULL
repos["mxnet"] <- 'https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/CRAN/'
repos
options(repos = repos)
install.packages("mxnet")
install.packages("jpeg")
install.packages("png")

library(devtools)
devtools::install_github("rich-iannone/DiagrammeR")
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")

   
   library(mxnet)
   library(png)
   library(jpeg)
   library(EBImage)
    
  #---------------------------------------------------------------------------------------------------------------------
   

if(!file.exists('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/synset.txt')){
  download.file("http://data.dmlc.ml/mxnet/models/imagenet/inception-bn.tar.gz",
                destfile = "G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/inception-bn.tar.gz")
  untar("G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/inception-bn.tar.gz",
        exdir = "G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/")
  file.remove("G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/inception-bn.tar.gz")
}


# Cargar modelo (el modelo ya está entrenado de origen)

  model <- mx.model.load('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/Inception-BN',
                         iteration = 126
                         )

# Leer modelo synset (categorías que pertenecen a cada red neuronal)
  synsets <- readLines('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/synset.txt')
  synsets  
  
  
  ## Carga de imágenes a detectar
    elephant <- readImage('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/elephant.jpg')
    kangaroo <- readImage('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/kangaroo.jpg')
    leopard <- readImage('G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/leopard.jpg')
    
  # Función para preprocesar la imágen  (re dimensionar y crear array de colores)
    
    preproc.image <- function(image, isPng = F){
      n_channels = 3
      if(isPng){
        n_channels = 4
      }
      resized <- resize(image, 224, 224)
      arr <- as.array(resized) * 255
      dim(arr) <- c(224,224,n_channels)
      m <- mean(arr)
      print(paste("Color promedio de la imagen: ",m, sep = " "))
      norm <- arr - m
      dim(norm) = c(224,224,n_channels,1)
      #norm <- norm[,,1:3,]
      return(norm)
    }
    
    ### Utilizar la función con una imagen para preprocesar
    elephant.n <- preproc.image(elephant,   # nombre de la imagen
                                isPng = F   # indicar si es PNG
                                )
    
    
    ### Clasificar la imagen
    classify.image <- function(image, isPNG = F){
      image.n <- preproc.image(image, isPNG)
      prob <- predict(model, X = image.n)
      #De todas las categorÃ?as, nos quedamos el top 5 de mÃ¡s probables
      sorted.p <- order(prob[,1], decreasing = T)
      max.idx <- sorted.p[1:5]
      result <- data.frame(cat=synsets[max.idx], 
                           prob = 100.0*prob[sorted.p[1:5]])
      
      display(image)
      result
    }
    
    
    # Con la función, indica que tipo de imagen se refiere y su probabilidad de éxito
    elephant.n <- elephant.n[,,1:3,]
    prob <- predict(model, X = elephant.n)
    display(elephant)
    classify.image(elephant)
    
    classify.image(kangaroo)
    display(leopard)
    classify.image(leopard)
    
    policy <- readImage("G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/girl.jpg")
    display(policy)
    classify.image(policy)
    
    
    trump <- readImage("G:/BD/GitHub/mlearningcourseR/r-course/data/tema8/Trump.jpg")
    display(trump)
    classify.image(trump)
    
    