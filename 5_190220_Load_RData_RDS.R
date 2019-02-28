
ls()
remove(list = ls())



# Cargar archivos RDATA
load('F://Documentos/R_Entrenamiento/mlearningcourseR/Outputs/Pedidos.Rdata')


# Los archivos RDS son archivos con un solo formato, y se debe indicar
# una instrucción para gardar el archivo

orders <- readRDS('F:/Documentos/R_Entrenamiento/mlearningcourseR/Outputs/Pedidos1.rds')
View (orders)


# Cargar datasets disponibles R
data("iris")
data("cars")

# Guardar todos los objetos de una sesión

save.image(file = 'F://Documentos/R_Entrenamiento/mlearningcourseR/Outputs/alldata.Rdata')

# PARA GUARDAR MÁS DE UN OBJETO DENTRO DEL MISMO DIRECTORIO

primes <- c(1,3,5,6,7,9,9)
pow2 <- c(2,4,8,12,24)
save(list = c('primes', 'pow2'), file = 'F:/Documentos/R_Entrenamiento/mlearningcourseR/guardar_lista.Rdata')

# PARA CARGAR RDATAS CON LA POSIBILIDAD DE SABER SI ES CÓDIGO QUE YA TENEMOS CARGADO
# lanza un mensaje en pantalla e indica que son variables que ya están cargadas en pantalla

attach('F:/Documentos/R_Entrenamiento/mlearningcourseR/guardar_lista.Rdata')

#DATA SET DISPONIBLES
data()
