# Conectar R con Java  11-07-2019

    # Java instalación de librería
    install.packages('rJava')
    library(rJava)
    
    # Validar la versión de la instalación de JAVA LIBRARY  
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
    
    
    

  
