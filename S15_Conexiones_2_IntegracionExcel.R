
# xlsx, EXcel, XLConnect  (Librerias para trabajar con Excel)
install.packages('xlsx')
library(xlsx)

auto <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema13/auto-mpg.csv',
                 stringsAsFactors = F) # carga de csv


write.xlsx(auto,  # nombre del dataframe a guardar en excel
           file='G:/Programacion/R_Entrenamiento/mlearningcourseR/auto.xlsx', # ruta
           sheetName = "rw_data_autos",  # nombre de la hoja
           row.names = F) # nombre en las filas

# Crear dos columnas adicionales en el dataset
auto$kpg <- auto$mpg *1.609
auto$z.mpg <- (auto$mpg - mean(auto$mpg))/sd(auto$mpg)

# crear nuevo excel-----------------------------INICIA CÓDIGO
auto.wb <- createWorkbook()  # Indica que abre un nuevo excel
sheet1  <- createSheet(auto.wb, 'auto1')  # crea el nombre de la pestaña
rows    <- createRow(sheet1, rowIndex = 1)  # que hoja y que columna se fija como index
cell.1  <- createCell(rows, colIndex = 1)[[1,1]]  # seleccionar celda 1, 1 de excel
setCellValue(cell.1, 'Hola dataframe de autos')  # poner valor en la celda seleccionada
addDataFrame(auto, # carga dataframe de autos
             sheet1,  # a partir de la hoja1
             startRow = 3,  # comenzar a cargar el dataset a partir de la fila 3
             row.names = F  # para no indicar nombres de las filas
             )

# configuración de la celda
cs <- CellStyle(auto.wb)+
  Font(auto.wb, isBold = T, color = 'red')
setCellStyle(cell.1, cs)




# guardar excel creado
saveWorkbook(auto.wb,'G:/Programacion/R_Entrenamiento/mlearningcourseR/auto2.xlsx' )

# Agregar nuevas columnas al excel
wb <- loadWorkbook('G:/Programacion/R_Entrenamiento/mlearningcourseR/auto2.xlsx')

# listar nombres de las pestañas del excel
sheets <- getSheets(wb)
list(sheets)

# Seleccionar hoja
sheet <- sheets[[1]]

# agrega dos columnas adicionales (10 y 11) del dataframe de autos
# a partir de la columna 10 del excel
addDataFrame(auto[,10:11], sheet, startColumn = 10, startRow = 3, row.names = F)
saveWorkbook(wb,'G:/Programacion/R_Entrenamiento/mlearningcourseR/auto_new.xlsx' )


# para leer el archivo

new.auto <- read.xlsx('G:/Programacion/R_Entrenamiento/mlearningcourseR/auto2.xlsx',
                      sheetIndex = 1)   # puede ser sheetname

head(new.auto)

# para leer el archivo delimitando filas y columnas

new.auto.select <- read.xlsx('G:/Programacion/R_Entrenamiento/mlearningcourseR/auto2.xlsx',
                      sheetIndex = 1,   # puede ser sheetname
                      rowIndex = 3:10, 
                      colIndex = 1:9)

head(new.auto.select)



#--------------TERMINA CÓDIGO DE CREACIÓN DE EXCEL------------------









