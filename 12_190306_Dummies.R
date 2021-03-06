
# Seleccionar dataframe
students<- read.csv('../tema1/data-conversion.csv')


# Breakpoints ((-Inf) -- de menos infinito a (Inf) Infinito )
#---------------------------------------------------------------------------
bp <- c(-Inf,10000,31000, Inf)   # de menos infinito a 10,000,
                                 # de 10,000 a 31,000
                                 # Arriba de 31,000

names <- c('Low', 'Average', 'High')  # Se marca en alguna categor�a en funci�n a par�metros dados arriba

# Crear una nueva columna con las categor�as correspondientes por nivel de ingreso
#---------------------------------------------------------------------------
students$Income.cat1 <- cut(students$Income, 
                           breaks = bp, 
                           labels = names)
# La funci�n cat utiliza los argumentos de la variable #breaks# 
# Y cataloga cada registro en funci�n al segmento definido por los cortes (breaks)
# Las etiquetas se toman del vector #names#


### DEJAR A R QUE SELECCIONE LOS CORTES
#_________________________________________________________________________________
students$Income.cat2 <- cut(students$Income, 
                           breaks = 4, 
                           labels = c('l1', 'L2', 'L3', 'L4'))

write.csv(students, '/Documentos/R_Entrenamiento/mlearningcourseR/Outputs/exporta.csv')


###DUMMIES#########----------------------------------------------------------------------

# Seleccionar dataframe
students<- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema1/data-conversion.csv')

# Instalar paquete para dummies
install.packages('dummies')
# importar librer�a
library(dummies)

# Crear un nuevo dataframe con DUMMIEs

students.dummy <- dummy.data.frame(students, sep = '.')

# Crear dataframe �nicamente con variables dummy (sin conservar las originales)
students.column <- dummy(students$State, sep = '.')

# Crear dummies �nicamente de una columna
students.dummy.just <- dummy.data.frame(students, sep = '.', all = TRUE)

# Crear dummies �nicamente de m�ltiples columnas
students.dummy.multiple.columns <- dummy.data.frame(students, 
                                                    names = c('State', 'Gender'), sep = '.')

# Nombre de las nuevas columnas
names(students)
names(students.dummy)
names(students.dummy.just)
students.column
students.dummy.multiple.columns







