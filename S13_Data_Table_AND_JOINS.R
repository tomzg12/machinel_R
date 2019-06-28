#Datatable trabaja con una gran cantidad de datos de forma eficiente

# Dataset de autos
auto <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

# utilizar libreria data.table
library(data.table)

# crear un objeto datatable
auto.dt <- data.table(auto)
class(auto.dt)

#La sintaxis de datatable, utiliza el punto y entre parentesis para seleccionar columnas
  # 1 columna
auto.dt[,.(mpg)]

  # Multiples columnas
auto.dt[,.(mpg, 
           horsepower,
           acceleration)]
  
# FILTRAR un tipo de auto---------------------------------------------------------------
auto.dt[cylinders%in%
          c("3C", "4C", "5C"),.(mpg, 
           horsepower,
           acceleration)]
  
  # Filtro ==
auto.dt[cylinders %in% c("3C", "4C", "5C")]
  # Filtro ==
auto.dt[cylinders == "4C" & horsepower>100]
  # Filtro LIKE
auto.dt[car_name %like% "maz"]

  # Filtrar la media de mpg por cilindro
auto.dt[, mean(mpg), by= cylinders]
  # Filtrar la media de mpg por cilindro, agregando nombre de campo
auto.dt[, meanmpg := mean(mpg), by = cylinders]

head(auto.dt)



##.---------------------- USO  DE LISTAS PARA AÑADIR MULTIPLES COLUMNAS (FUNCIÓN LIST ":=")--------------------------
auto.dt[, c("sd_mpg", "z_mpg") := list(
  sd(mpg), round((mpg - mean(mpg))/sd(mpg),2)
), by = cylinders
]
auto.dt[1:5, c(1:3, 9:12), # Filas 1 a 5, columnas de 1 a 3, y de 9 a 12
        with = FALSE]        

# Aplicar una funcion a un conjunto de variables especificas
auto.dt[, lapply(.SD,   # aplicar lapply a todas las filas(calcula una variable llamada .SD) 
                 mean), # funcion promedio 
        .SDcols = c("mpg", "horsepower")] # las columnas de SD


# configurar clave para un dataframe (cual columna será la clave del dataframe)
setkey(auto.dt, cylinders)
# describe los datos de la tabla (nombre, numero de columnas, num filas, mb, etc...)
tables()

# una vez establecida la llave del dt, acceder mediante la clave a las columnas
auto.dt["4C",    # todos los elementos que coinciden con esta clave
        c(1:3, 9:10),  # columnas especifícado
        with = F]  # formato de dataframe (with = F)


# CÁLCULOS CON UN DATA TABLE-----------------------------------------------------------------------------------------
auto.dt[,list(mean = mean(mpg), min = min(mpg),
              max = max(mpg), sd = sd(mpg)),
        by = cylinders]

###DT[i,j,by]   #<- ESTRUCTURA DEL DATATABLE


# En datatable, el concepto de fila no es el mismo que en un dataframe.
# Las filas no tienen nombres de filas, tienen claves.


#----------EN UN DATATABLE, PUEDEN ELEGIRSE MÁS COLUMNAS COMO CLAVES--------------------------------
setkeyv(auto.dt, c("cylinders", "model_year"))
auto.dt[.("4C"), c(1:3, 9:10), with = F]




#-----------------------------------------------------------------------
#-----------------------------------------------------------------------
#TÉCNICAS AVANZADAS SON DATATABLE---------------------------------------


# .N Sirve para CONTAR (por cilindros)
auto.dt[,.N, by = cylinders]

# .N CUENTA los autos de 3C
auto.dt["3C", .N]

# ELIMINAR una columna (agreando NULL)
auto.dt[, meanmpg:=NULL]
head(auto.dt)


#DT[i,j,by]
#----------------JOINS----------------------------------------------------------------------------------------------

empl <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/employees.csv", stringsAsFactors = F)
dept <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/departments-1.csv", stringsAsFactors = F) 

# CONVERTIR EN DATATABLE
empl.dt <- data.table(empl)
dept.dt <- data.table(dept)

# ESTABLECER KEY (SIRVE PARA HACER EL JOIN)
setkey(empl.dt, "DeptId")

# JOIN UTILIZANDO LA FUNCIÓN "COMBINE"
combine <- empl.dt[dept.dt]  #OUTER JOIN
head(combine) # CONSULTA DEL DATA TABLE
combine[,.N] # CONSULTA DE CUANTOS ELEMENTOS EXISTEN (.N SE USA PARA CONTAR , LA COMA INDICA QUE SON FILAS (CUENTA DE FILAS))




# SEGUNDA COMBINACIÓN DE  DATATABLES (INNER)--------------------------------------------------------------------------------
dept2 <- read.csv("G:/BD/GitHub/mlearningcourseR/r-course/data/tema11/departments-2.csv", stringsAsFactors = F)
# CREA DATATABLE CON OTRO DATASET DE DEPARTAMENTOS, EL CUAL INCLUYE UN DEPARTAMENTO DÓNDE NADIE TRABAJA
dept2.dt <- data.table(dept2)

# COMBINAR LOS 2 DATATABLES (EL PRODUCTO CARTESIANO PERMITE RELLEAR LO QUE FALTE CON "NA")
combine <- empl.dt[dept2.dt, allow.cartesian = T, 
                   nomatch = 0] # ELIMINA LAS FILAS QUE NO TENGAN DATO EN OTRA TABLA (Nas)

# cuenta los registros de la tabla 
combine[,.N]


# JOINS (INNER, LEFT, RIGHT, FULL)---------------UTILIZANDO LA FUNCIÓN MERGE (PAQUETE STATS)
merge(empl.dt, dept2.dt, by = "DeptId") #InnerJoin # SI HAY nAs QUE NO APAREZCAN
merge(empl.dt, dept2.dt, by = "DeptId", all.x = T) #Left Join  # LOS QUE ESTÁN EN LA TABLA IZQUIERDA
merge(empl.dt, dept2.dt, by = "DeptId", all.y = T) #Right Join # LOS QUE ESTÁN EN LA TABLA DERECHA
merge(empl.dt, dept2.dt, by = "DeptId", all = T) # Full Join  # TODOS LOS ELEMENTOS CON TODOS


#.----SIMBOLOS Y OPERACIONES ESPECIALES PARA UTILIZAR EN DATATABLES----------------------------------------------------
#DT[i,j,by]
#.SD -> hace referencia a todas las columnas (salvo las del by)
#.SDcols -> la referencia guardada a las columnas (son las que se pueden incluir o excluir en la 'j')
#.EACHI -> para agrupar por claves
#.N -> numero de filas 
#.I -> los indices indicados en el DT


#Sueldo maximo de cada departamento usando un JOIN directo
empl.dt[dept2.dt,        # datatables a utilizar
        max(.SD),        # función a aplicar en .SDCols (todas las columnas)
        by = .EACHI,     # para agrupador se utiliza la propia clave (departamento)
        .SDcols = "Salary" ] # la columna a aplicar la función es "SALARIO"



#Sueldo promedio por departamento

empl.dt[, .(AvgSalary = lapply(.SD, mean)),# nueva columna llamada AvgSalary
        by = "DeptId",    # filtrado por departamentoid
        .SDcols = "Salary"] # la función aplicar a la columna salario

# Sueldo promedio por departamento agrupando por 2 columnas

empl.dt[dept2.dt,    # datatables a utilizar
        list(DeptName, # lista del nombre del departamento (DptName - 2o datatable) y sueldo promedio (columna nueva)
             AvgSalary = lapply(.SD, mean)),  # función de promedio
        by = .EACHI,   # agrupar por .eachI (identificador), ya que los Keys son más rápidos para procesar
        .SDcols = "Salary"] # columna a la cual aplicar la función

