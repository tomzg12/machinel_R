
### Instalaci�n de paquetes
install.packages(c('rpart','rpart.plot','caret'))
library(caret)
library(rpart.plot)  # Gr�ficos de �rboles de clasificaci�n
library(rpart)   # Construcci�n �rboles de clasificaci�n

### Importa dataframe
banknote <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')


### Partici�n del dataframe (incluyendo semilla)
set.seed(2018)

training.ids <- createDataPartition(banknote$class, # Variable class
                                    p= 0.7,      # Define el 70 % para entrenamiento
                                    list= FALSE) # Devuelve array en lugar de lista

          # class ~., --> equivale a -> variance+skew+curtosis+entropy  (otra forma es indicar con signo menos, con signo menos se indican las que no)
mod <- rpart(class~., # class variable dependiente, depende de todas las otras (se indica con punto)
             data = banknote[training.ids,], #dataframe, del cual solo tomamos conjunto de entrenamiento
             method = 'class',   #M�todo para clasificar (por eso el class, tambi�n podr�a ser regresi�n)
             control = rpart.control(minsplit = 20, cp = 0.01)) # Se indican par�metros adicionales
                                                                # El �rbol solo debe considerar nodos con 
                                                                # al menos 20 casos en su interior
                                                                # cp. ajusta complejidad en 0.01 en casos

### Imprimir mod de �rbol de decisi�n
mod

### Graficar modelo de �rbol
# prp es parte de rpart.plot (paquete para representar el �rbol)
prp(mod,   # Llama al modelo de �rbol de decisi�n
    type = 1, # par�metro 2 es para hacer que cada nodo quede etiquetado
    extra = 104,  # Se utiliza para mostrar probabilidad y casos en los que caemos (porcentaje)
    nn = TRUE, # Se utiliza para mostrar n�mero de nodo (nodo ra�z = 1)
    fallen.leaves = TRUE,  # Nodos hoja (debajo de todo el gr�fico)
    faclen = 4,  # Se utiliza para abreviar el nombre de las clases
    varlen = 12,  # Sirve para abreviar nombre de las variables (campos del modelo de �rbol)
    shadow.col = 'gray', # Sombra de cada rama del �rbol
    roundint = FALSE,
    cex = 0.7) # Font Size

#### Otro paquete para graficar �rboles de decisi�n ###
install.packages('maptree')
library(maptree)
draw.tree(mod, cex = 0.9)

### Podar el �rbol
mod$cptable    # Genera una tabla con los componentes principales
  # Esta tabla funciona para analizar la matriz de validaci�n cruzada
      #a) Buscar el error m�nimo (columna xerror)
      #b) Sumar xerror + xstd y el resultado debe ser menor al error de validaci�n cruzada


# Modelo reducido
mod.pruned <- prune(mod, mod$cptable[3,'CP']) #<- El corte representa la profundidad del �rbol [3]
        # El 8 representa la fila de corte, tomada del cuadro de poda

# Graficar �rbol reducido
prp(mod.pruned,   # Llama al modelo de �rbol de decisi�n (recortado)
    type = 1, # par�metro 2 es para hacer que cada nodo quede etiquetado
    extra = 104,  # Se utiliza para mostrar probabilidad y casos en los que caemos (porcentaje)
    nn = TRUE, # Se utiliza para mostrar n�mero de nodo (nodo ra�z = 1)
    fallen.leaves = TRUE,  # Nodos hoja (debajo de todo el gr�fico)
    faclen = 4,  # Se utiliza para abreviar el nombre de las clases
    varlen = 12,  # Sirve para abreviar nombre de las variables (campos del modelo de �rbol)
    shadow.col = 'gray', # Sombra de cada rama del �rbol
    roundint = FALSE,
    cex = 0.7) # Font Size

### Predicci�n de valores

pred.pruned <- predict(mod, banknote[-training.ids,], # Todos los que no son trainings
                       type = 'class') # Tipo clasificaci�n

# Crear la matriz de confusi�n
table(banknote[-training.ids,]$class, pred.pruned,
      dnn = c('Actual', 'Predicho'))
    # D�nde en 223 casos que ha dicho 0, es cero
      # En 11 caso ha dicho que es cero y es 1
  
### Predicci�n de probabilidades
pred.pruned2 <- predict (mod.pruned, #modelo reducido
                         banknote[-training.ids,], #datos no de entrenamiento y todas las columnas
                         type = "prob") #funci�n de probabilidad

head(pred.pruned2)

# Creaci�n diagrama ROC

library(ROCR)
pred <- prediction(pred.pruned2[,2],
                   banknote[-training.ids, 'class'])

# Gr�fica de la matriz ROC (A partir del 8 )
perf <- performance(pred, 'tpr','fpr')
plot(perf)
