
# Mosaic plot

    library(stats)
    
      # dataframe
      mtcars <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema7/mtcars.csv')
      
      head(mtcars)    
          
    # gr�fico de mosaico 1 (vector de colores)
      mosaicplot(~ gear +carb,  # n�mero de marchas vs carburadores
                 data = mtcars, # dataset
                 color = 2:7,   # vector colores
                 las = 1)       # estilo de los ejes
  
      # gr�fico de mosaico (colores = T)
      mosaicplot(~ gear +carb,  # n�mero de marchas vs carburadores
                 data = mtcars, # dataset
                 color = 'gray',
                 las = 1)+ theme_economist() + scale_fill_economist()      # estilo de los ejes
      