names.first <- c("Juan Gabriel", "Zach", "Jack", "Sansa")
names.last <- c("Gomila", "Effron", "Sparrow", "Stark")

#La funciÃ³n paste, combina los dos vectores como si 
#hubieramos hecho un bucle for
paste(names.first, names.last)

single.surname <- c("Zuccherberg", 'Rose')

#La funciÃ³n paste sirve para combinar incluso
#vectores de diferente tamaÃ±o!
paste(names.first, single.surname)


username <- function(first, last){
  tolower(paste0(last, substr(first, 1, 2)))
}

username(names.first, names.last)


auto <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/auto-mpg.csv")

head(auto)

# Para multiplicar una variable por un número
auto$dmpg <- auto$mpg * 2.0
auto$kmpg <- auto$mpg * 1.609

# Revisar dataframe con las nuevas columnas
head(auto)

# Suma de una columna
sum(auto$mpg)

# Mínimo de una columna
min(auto$mpg)

# Máximo de una columna
max(auto$mpg)

# rango de una columna
range(auto$mpg)

# Producto de una columna
prod(auto$mpg)




mean(auto$mpg)
median(auto$mpg)
var(auto$mpg)
sd(auto$mpg)

(auto$mpg - mean(auto$mpg))/sd(auto$mpg)
