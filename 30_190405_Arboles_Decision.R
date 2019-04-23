
### Instalación de paquetes
install.packages(c('rpart','rpart.plot','caret'))
library(caret)
library(rpart.plot)  # Gráficos de árboles de clasificación
library(rpart)   # Construcción árboles de clasificación

### Importa dataframe
banknote <- read.csv('F:/BD/GitHub/mlearningcourseR/r-course/data/tema3/banknote-authentication.csv')


### Partición del dataframe (incluyendo semilla)
set.seed(2018)

training.ids <- createDataPartition(banknote$class, # Variable class
                                    p= 0.7,      # Define el 70 % para entrenamiento
                                    list= FALSE) # Devuelve array en lugar de lista

          # class ~., --> equivale a -> variance+skew+curtosis+entropy  (otra forma es indicar con signo menos, con signo menos se indican las que no)
mod <- rpart(class~., # class variable dependiente, depende de todas las otras (se indica con punto)
             data = banknote[training.ids,], #dataframe, del cual solo tomamos conjunto de entrenamiento
             method = 'class',   #Método para clasificar (por eso el class, también podría ser regresión)
             control = rpart.control(minsplit = 20, cp = 0.01)) # Se indican parámetros adicionales
                                                                # El árbol solo debe considerar nodos con 
                                                                # al menos 20 casos en su interior
                                                                # cp. ajusta complejidad en 0.01 en casos

### Imprimir mod de árbol de decisión
mod

### Graficar modelo de árbol
# prp es parte de rpart.plot (paquete para representar el árbol)
prp(mod,   # Llama al modelo de árbol de decisión
    type = 1, # parámetro 2 es para hacer que cada nodo quede etiquetado
    extra = 104,  # Se utiliza para mostrar probabilidad y casos en los que caemos (porcentaje)
    nn = TRUE, # Se utiliza para mostrar número de nodo (nodo raíz = 1)
    fallen.leaves = TRUE,  # Nodos hoja (debajo de todo el gráfico)
    faclen = 4,  # Se utiliza para abreviar el nombre de las clases
    varlen = 12,  # Sirve para abreviar nombre de las variables (campos del modelo de árbol)
    shadow.col = 'gray', # Sombra de cada rama del árbol
    roundint = FALSE,
    cex = 0.7) # Font Size

#### Otro paquete para graficar árboles de decisión ###
install.packages('maptree')
library(maptree)
draw.tree(mod, cex = 0.9)

### Podar el árbol
mod$cptable    # Genera una tabla con los componentes principales
  # Esta tabla funciona para analizar la matriz de validación cruzada
      #a) Buscar el error mínimo (columna xerror)
      #b) Sumar xerror + xstd y el resultado debe ser menor al error de validación cruzada


# Modelo reducido
mod.pruned <- prune(mod, mod$cptable[3,'CP']) #<- El corte representa la profundidad del árbol [3]
        # El 8 representa la fila de corte, tomada del cuadro de poda

# Graficar árbol reducido
prp(mod.pruned,   # Llama al modelo de árbol de decisión (recortado)
    type = 1, # parámetro 2 es para hacer que cada nodo quede etiquetado
    extra = 104,  # Se utiliza para mostrar probabilidad y casos en los que caemos (porcentaje)
    nn = TRUE, # Se utiliza para mostrar número de nodo (nodo raíz = 1)
    fallen.leaves = TRUE,  # Nodos hoja (debajo de todo el gráfico)
    faclen = 4,  # Se utiliza para abreviar el nombre de las clases
    varlen = 12,  # Sirve para abreviar nombre de las variables (campos del modelo de árbol)
    shadow.col = 'gray', # Sombra de cada rama del árbol
    roundint = FALSE,
    cex = 0.7) # Font Size

### Predicción de valores

pred.pruned <- predict(mod, banknote[-training.ids,], # Todos los que no son trainings
                       type = 'class') # Tipo clasificación

# Crear la matriz de confusión
table(banknote[-training.ids,]$class, pred.pruned,
      dnn = c('Actual', 'Predicho'))
    # Dónde en 223 casos que ha dicho 0, es cero
      # En 11 caso ha dicho que es cero y es 1
  
### Predicción de probabilidades
pred.pruned2 <- predict (mod.pruned, #modelo reducido
                         banknote[-training.ids,], #datos no de entrenamiento y todas las columnas
                         type = "prob") #función de probabilidad

head(pred.pruned2)

# Creación diagrama ROC

library(ROCR)
pred <- prediction(pred.pruned2[,2],
                   banknote[-training.ids, 'class'])

# Gráfica de la matriz ROC (A partir del 8 )
perf <- performance(pred, 'tpr','fpr')
plot(perf)
