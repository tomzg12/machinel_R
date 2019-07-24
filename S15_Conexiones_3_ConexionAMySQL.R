#MySQL
install.packages('RODBC') # R OPEN DATABSE CONECTIVITY
install.packages('RJDBC') # R OPEN JAVA DB CONECTIVITY
install.packages('ROracle')
install.packages('RMySQL')
install.packages('pool')

library(RMySQL)
library(odbc)
library(RODBC)
library(pool)

con = dbConnect(MySQL(), 
                 user='root2', 
                 password= 'pa$$word', 
                 dbname='recommendationsystem', 
                 host='127.0.0.1',
                 port = 3306)

class(con)

# Ejecutar un Query para traer datos
custdata <- dbGetQuery(con, 
                     'Select *
                      From recommendationsystem.rating
                      ')

# desconectar de base de datos
on.exit(dbDisconnect(con)
        
head(custdata)


# INSERTAR DATOS EN MYSQL






