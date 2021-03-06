
#tapply


auto <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/auto-mpg.csv', stringsAsFactors =  F)

# Uso de la funci�n TAPPLY
auto$cylinders <- factor(auto$cylinders, 
                         levels = c(3,4,5,6,8),
                         labels = c("3c", "4c", "5c", "6c", "8c"))

head(auto)

# Inicio (calcula la media por cada factor-- media de millas por gale�n en funci�n del cilindraje)
tapply(auto$mpg, 
      auto$cylinders, 
      mean)

# Una vista diferente (lista)
tapply(auto$mpg, 
       list(cyl = auto$cylinders), 
       mean)

#FUNCI�N BY -------------------------------------------------------------
# cALCULA LA CORRELACI�N DE CILINDROS CONTRA MILLAS POR GALE�N Y ACELERACI�N
by(auto, auto$cylinders, function(row){cor(row$mpg, row$acceleration)})
