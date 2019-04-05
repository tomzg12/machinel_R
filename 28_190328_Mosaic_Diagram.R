
## Importar dataset
cp <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/college-perf.csv')

# Ordena la columna de performance con base en el orden que asigno en "levels"
# esto no se ve en el dataset
cp$Perf <- ordered(cp$Perf, 
                   levels = c('Low','Medium', 'High'))

cp$Pred <- ordered(cp$Pred, 
                   levels = c('Low','Medium', 'High'))


## Crea una tabla de doble entrada
table <- table(cp$Perf,    #Crear tabla utilizando 2 columnas
               cp$Pred,
               dnn = c('Actual', 'Predecido'))  # renombramos las columnas
table
# La tabla dice que en el actual (real), alguien saca una nota baja, y 
# en los valores predecidos, el modelo predijo que sacaría otra o esa calificación.

# La tabla original ya tenía la columna de predicciones ("Pred")


prop.table(table)
round(prop.table(table,1)*100,2)
# round = redondear
# prop.table (crea tabla)
# table, 1 = El uno significa que cada fila debe sumar 100
# multipliar por cien,
# el 2 representa los decimales

prop.table(table)
round(prop.table(table,2)*100,2)
# round = redondear
# prop.table (crea tabla)
# table, 2 = El uno significa que cada columna debe sumar 100
# multipliar por cien,
# el 2 representa los decimales

## Gráficos
# Barplot
barplot(table, legend = TRUE,
        xlab = 'Valor predecido por el modelo'
        )

## Diagrama del mosaico
mosaicplot(table, main = 'Eficiencia del modelo')

summary(table)






