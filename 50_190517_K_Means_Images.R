

    # Carga de librer�as
    install.packages(c('OpenImageR', 'ClusterR'))
    
    library(OpenImageR)
    library(gtools)
    library(ClusterR)
    

    # Carga de imagen (El tama�o son los p�xeles y se crea un array)
    img <- readImage('G:/BD/GitHub/mlearningcourseR/r-course/data/tema5/bird.jpg')
    
    # Redimiensionar la imagen para hacerla de un tama�o diferente (en este caso menor tama�o)
    img.resize <- resizeImage(img, 
                              350,   # Ancho
                              350,   # Alto
                              method = 'bilinear')   # Existen m�s m�todos ('nearest')
    
    # Mostrar la imagen    
    imageShow(img.resize)
    
    # Convertir la imagen en vectores (vectores de 3 en 3)
          # Rojo, verde y Azul
    img.vector <- apply(img.resize, 
                        3,   #Cantidad filas y columnas como vector (una columna para Rojos, otra para Verdes y otra para Azules)
                        as.vector)
    
    # Dimensiones de la imagen vectorizada    
    dim(img.vector)  #122500 filas (pixeles originales) + 3 columnas
    
    

#------------Cl�sterizaci�n...............
    
    cluster = 350
    
    #uso de minibatch k-means
    kmmb <- MiniBatchKmeans(img.vector,
                            clusters = cluster, 
                            batch_size = 20,   # Tama�o de cl�sters
                            num_init = 5,      # Num m�x de it del algoritmo hasta encontrar los centroides
                            max_iters = 100,
                            init_fraction = 0.2,
                            initializer = 'kmeans++',
                            early_stop_iter = 10,
                            verbose= F)  # indicar si queremos que se imprima el progreso en pantalla
    
    
    kmmb
    
    # Correr predicci�n    
    prmb <- predict_KMeans(img.vector,
                           kmmb$centroids)  #Centroides para que se identifiquen los colores
    
    
    # Visualizar imagen predicha utilizando los centroides
    get.cent.mb <- kmmb$centroids  #<- convierte en variable los centroides
    
    # La nueva imagen se almacena en una variable
    new.img <- get.cent.mb[prmb, ]
    
    # Se dimensiona (al original)
    dim(new.img) <- c(nrow(img.resize), 
                      ncol(img.resize),
                      3)
    
    # Ver la predicci�n de la imagen        
    imageShow(new.img)
    
    
    
    
    
    
        
    
    
    
    
    
    