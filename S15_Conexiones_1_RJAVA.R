# Conectar R con Java  11-07-2019

    # Java instalaci�n de librer�a
    install.packages('rJava')
    library(rJava)
    
    # Validar la versi�n de la instalaci�n de JAVA LIBRARY  
    .jinit()
    .jcall('java/lang/System',
           'S',
           'getProperty',
           'java.runtime.version')    
    
    setwd("G:/Programacion/R_Entrenamiento/mlearningcourseR/Outputs")
    
    # Activar directorio para trabajar con JAVA
    .jaddClassPath(getwd())
    # Validar directorio de trabajo de clases en JAVA
    .jclassPath()    
    
    
    

  
