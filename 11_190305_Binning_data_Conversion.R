
# Seleccionar dataframe
students<- read.csv('../tema1/data-conversion.csv')


# Breakpoints ((-Inf) -- de menos infinito a (Inf) Infinito )
#---------------------------------------------------------------------------
bp <- c(-Inf,10000,31000, Inf)   # de menos infinito a 10,000,
                                 # de 10,000 a 31,000
                                 # Arriba de 31,000

names <- c('Low', 'Average', 'High')  # Se marca en alguna categoría en función a parámetros dados arriba

# Crear una nueva columna con las categorías correspondientes por nivel de ingreso
#---------------------------------------------------------------------------
students$Income.cat1 <- cut(students$Income, 
                           breaks = bp, 
                           labels = names)
# La función cat utiliza los argumentos de la variable #breaks# 
# Y cataloga cada registro en función al segmento definido por los cortes (breaks)
# Las etiquetas se toman del vector #names#


### DEJAR A R QUE SELECCIONE LOS CORTES
#_________________________________________________________________________________
students$Income.cat2 <- cut(students$Income, 
                           breaks = 4, 
                           labels = c('l1', 'L2', 'L3', 'L4'))

write.csv(students, '/Documentos/R_Entrenamiento/mlearningcourseR/Outputs/exporta.csv')
