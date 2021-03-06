

# Inputs para DataFrame
family.salary <-  c(40000,60000,50000,80000,60000,70000,60000)
family.size   <-  c(4,3,2,2,3,4,3)
family.car    <-  c('Lujo', 'Compacto', 'Utilitario'
                    , 'Lujo', 'Compacto', 'Compacto', 'Compacto')

# DataFrame

family = data.frame(family.salary, family.size, family.car)

# Funci�n unique
  #Devuelve los �nicos del dataframe, objetos del mismo tipo

unique(family)

# Construye otro dataFrame sin duplicados
family.unique <- unique(family)

# Para saber d�nde hay duplicados se utiliza la funci�n DUPLICATED (Boolean)

duplicated(family)  # La primera ocurrencia no se muestra, solo los siguientes duplicados

# Otra manera de revisar los duplicados
family[duplicated(family),]


