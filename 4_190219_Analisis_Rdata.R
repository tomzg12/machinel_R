#Limpiar el environment
ls()
remove(list=ls())


# Construir un set y convertir en fecha los valores ingresados
clientes <- c('Juan', 'Pedro', 'Ricardo')
fechas  <- as.Date(c('2017-12-25', '2017-11-22', '2018-01-01'))
pago <- c(315,192.55, 40.15)

# Compilar en un solo dataframe
pedidos = data.frame(clientes, fechas, pago)
View(pedidos)

#Exportar archivo en formato de R
save(pedidos, file = 'F:/Documentos/R_Entrenamiento/mlearningcourseR/Outputs/Pedidos.Rdata')

saveRDS(pedidos, file = 'F:/Documentos/R_Entrenamiento/mlearningcourseR/Outputs/Pedidos1.rds')


remove(pedidos)
