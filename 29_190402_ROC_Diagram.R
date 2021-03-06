# Instala paquete ROCR
install.packages('ROCR')

# Cargar paquete
library(ROCR)

# lectura del dataframe
data1 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/roc-example-1.csv')

# mismo dataframe con variables categ�ricas
data2 <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/roc-example-2.csv')


##### Creando la curva ROC
## Hacer predicci�n con el 1er dataframe
  # 0 = fallo, 1 = �xito
pred1 <- prediction(data1$prob, data1$class)  # Genera predicci�n usando probabilidad en funci�n de la clase

## Funci�n performance
perf1 <- performance(pred1, 'tpr', 'fpr')  #true positive rates (tpr)- false positive rate (fpr)

## Representar el performance en un plot
plot(perf1)
# Agregar l�nea diagonal al gr�fico
lines(par()$usr[1:2],par()$usr[3:4])


### Crear dataframe extrayendo los valores del performance
# Al ser elemento de R, se usa @
prob.cuts.1 <- data.frame(cut = perf1@alpha.values[[1]],  #Valores de curte
                          fpr = perf1@x.values[[1]],   # Probabilidad de falso positivo
                          tpr = perf1@y.values[[1]])   # Probabilidad de verdadero positivo
                          
# Head del dataframe creado
head(prob.cuts.1) * 100

# tail del dataframe creado
tail(prob.cuts.1) * 100

### Seleccionar los TRUE POSITIVE RATES mayores a 80% 
prob.cuts.1[prob.cuts.1$tpr>=0.8,]



###### PREDICCI�N CON 2o CSV (CATEG�RICAS)
pred2 <- prediction(data2$prob, 
                    data2$class,
                    label.ordering = c("non-buyer","buyer"))

perf2 <- performance(pred2, 'tpr', 'fpr')

plot(perf2)
lines(par()$usr[1:2], par()$usr[3:4])
