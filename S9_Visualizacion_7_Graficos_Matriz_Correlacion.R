
# Matriz de correlaci�n
        library(ggplot2)
        library(corrplot)  # matriz de correlaci�n
        library(reshape2)
        
        
        mtcars <-read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/mtcars.csv')

        
        # M�todo para calcular correlaci�n 
        #pearson, spearman, kendal, etc.
        
          # C�lcular correlaci�n (�nicamente variables num�ricas)
        mtcars$X <- NULL  # quitar columna de strings
        
        # C�lculo de correlaci�n (entre m�s se acerque a uno, la correlaci�n es positiva, viceversa)
        mtcars.cor <- cor(mtcars, method = 'pearson')
        
      
      # redondear
        round(mtcars.cor, digits = 2)
        
        
      # Implementar gr�fico de correlaci�n
         # Ejemplo 1 (c�rculos)
        corrplot(mtcars.cor)
        
        
        # Ejemplo 2 (cuadritos)
        corrplot(mtcars.cor,
                 method = 'shade',
                 shade.col = NA,  # color de sombra
                 tl.col = 'black',  # color de etiquetas
                 tl.srt = 45   # rotaci�n de etiquetas 45 grados
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
                 tl.srt = 45,   # rotaci�n de etiquetas 45 grados
                 col = col(200),  # escalado a 200 valores (de -1 a 1)
                 addCoef.col = 'gray',   # coeficientes dentro del cuadro
                 order = 'AOE'  # ordenar los m�s correlacionados
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
                 type = "upper",  # Podr�a ser lower, pinta la esquina derecha
                 diag = F,        # Puede eliminar la diagonal (d�nde todos son 1)
                 addshade = "all",
               
                 )
        
  ##---MATRIZ DE CORRELACI�N CON GGPLOT2-------------------------------------------
        
        mtcars.melte <- melt(mtcars.cor)
        
        # 1 - fundir los datos de la matriz de correlaci�n
        head(mtcars.melte)  # simplifica la matriz de correlaci�n
                            # transporfa las columnas en filas y una columna de valor
        
        # Crear el lienzo del dibujo y las entradas de datos
        ggplot(data = mtcars.melte,
               aes(x = Var1, 
                   y= Var2, 
                   fill = value))+
          geom_tile()   # incorporar zona de color del gr�fico
          
        
        
        
        
##---MATRIZ DE CORRELACI�N CON GGPLOT2  CLUSTERING JERARQUICO-------------------------------------------
        
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
        
        
        # usar funci�n
        cormat <- reorder_cormat(mtcars.cor)
        
        cormat.ut <- get_upper_triangle(cormat)
        
        cormat.ut.melted <- melt(cormat.ut, na.rm = T)
        
        # Construir gr�fico
        ggplot(cormat.ut.melted,
               aes(Var2, Var1,
                   fill = value))+
          geom_tile(color = 'white')+
          scale_fill_gradient2(low = 'blue',
                               high = 'red',
                               mid = 'gray',
                               midpoint = 0,
                               limit = c(-1,1),  # l�mite de colores
                               space = 'Lab',
                               name = 'Pearson correlation'
                               )+
          theme_minimal()+
          theme(axis.text.x = element_text(angle = 45,
                                           vjust = 1,
                                           size = 12,
                                           hjust = 1))+
          coord_fixed()  # unidades en eje X y Y, tienen la misma longitud
        