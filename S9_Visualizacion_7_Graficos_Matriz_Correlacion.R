
# Matriz de correlación
        library(ggplot2)
        library(corrplot)  # matriz de correlación
        library(reshape2)
        
        
        mtcars <-read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/mtcars.csv')

        
        # Método para calcular correlación 
        #pearson, spearman, kendal, etc.
        
          # Cálcular correlación (únicamente variables numéricas)
        mtcars$X <- NULL  # quitar columna de strings
        
        # Cálculo de correlación (entre más se acerque a uno, la correlación es positiva, viceversa)
        mtcars.cor <- cor(mtcars, method = 'pearson')
        
      
      # redondear
        round(mtcars.cor, digits = 2)
        
        
      # Implementar gráfico de correlación
         # Ejemplo 1 (círculos)
        corrplot(mtcars.cor)
        
        
        # Ejemplo 2 (cuadritos)
        corrplot(mtcars.cor,
                 method = 'shade',
                 shade.col = NA,  # color de sombra
                 tl.col = 'black',  # color de etiquetas
                 tl.srt = 45   # rotación de etiquetas 45 grados
                 )
        
        
#--------- Ejemplo 3 (cuadritos con paleta de colores y texto sobre los cuadros)
          # paleta de colores
        col <- colorRampPalette(c('#BB4444',
                                    '#EE9988',
                                    '#FFFFFF',
                                    '#77AADD',
                                    '#4477AA'))
        
        corrplot(mtcars.cor,
                 method = 'shade',
                 shade.col = NA,  # color de sombra
                 tl.col = 'black',  # color de etiquetas
                 tl.srt = 45,   # rotación de etiquetas 45 grados
                 col = col(200),  # escalado a 200 valores (de -1 a 1)
                 addCoef.col = 'gray',   # coeficientes dentro del cuadro
                 order = 'AOE'  # ordenar los más correlacionados
        )
#------------------------------------------------------------------------------------------------------------------------------
        
        
        #--------- Ejemplo 4 (cuadritos con paleta de colores y texto sobre los cuadros)        
        corrplot(mtcars.cor, 
                 method = "square", # circle # shade # square # ellipse # pie
                 tl.col = "black",
                 tl.srt = 45, 
                 col = col(200), 
                 addCoef.col = "black",
                 order = "FPC",   # angular orderer engine vectors (AOE - FPC - hclust)
                 type = "upper",  # Podría ser lower, pinta la esquina derecha
                 diag = F,        # Puede eliminar la diagonal (dónde todos son 1)
                 addshade = "all",
               
                 )
        
  ##---MATRIZ DE CORRELACIÓN CON GGPLOT2-------------------------------------------
        
        mtcars.melte <- melt(mtcars.cor)
        
        # 1 - fundir los datos de la matriz de correlación
        head(mtcars.melte)  # simplifica la matriz de correlación
                            # transporfa las columnas en filas y una columna de valor
        
        # Crear el lienzo del dibujo y las entradas de datos
        ggplot(data = mtcars.melte,
               aes(x = Var1, 
                   y= Var2, 
                   fill = value))+
          geom_tile()   # incorporar zona de color del gráfico
          
        
        
        
        
##---MATRIZ DE CORRELACIÓN CON GGPLOT2  CLUSTERING JERARQUICO-------------------------------------------
        
        # triangulo inferior
          get_lower_triangle <- function(cormat){
            
            cormat[upper.tri(cormat)] <- NA
            return (cormat)
            
          }
        
        
        
        # triangulo superior
        get_upper_triangle <- function(cormat){
          
          cormat[lower.tri(cormat)] <- NA
          return (cormat)
          
        }
        
        
        # distancias (cuando 100% corr la distancia es 0, factor entre 0 y 1)
        reorder_cormat <- function(cormat){
          dd <- as.dist((1-cormat)/2)
          hc <- hclust(dd)
          cormat <- cormat[hc$order, hc$order]
          
        }
        
        
        # usar función
        cormat <- reorder_cormat(mtcars.cor)
        
        cormat.ut <- get_upper_triangle(cormat)
        
        cormat.ut.melted <- melt(cormat.ut, na.rm = T)
        
        # Construir gráfico
        ggplot(cormat.ut.melted,
               aes(Var2, Var1,
                   fill = value))+
          geom_tile(color = 'white')+
          scale_fill_gradient2(low = 'blue',
                               high = 'red',
                               mid = 'gray',
                               midpoint = 0,
                               limit = c(-1,1),  # límite de colores
                               space = 'Lab',
                               name = 'Pearson correlation'
                               )+
          theme_minimal()+
          theme(axis.text.x = element_text(angle = 45,
                                           vjust = 1,
                                           size = 12,
                                           hjust = 1))+
          coord_fixed()  # unidades en eje X y Y, tienen la misma longitud
        