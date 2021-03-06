

# Etiquetas y leyendas
library(ggplot2)

      #ggtitle(titulo)
      

      # Carga dataframe
      toot <- ToothGrowth
      
      head(toot)

       # box plot  (utilizando t�tulos y etiquetas)
      ggplot(toot,
             aes(x = dose,
                 y = len,
                 fill = as.factor(dose)))+
        geom_boxplot()+                 # boxplot (cajas y bigotes)
        ggtitle('Crecimiento dental en funci�n a la dosis de vit C')+ # T�tulo
        xlab('Dosis de vitamina C')+    # etiqueta eje X
        ylab('Crecimiento dental') +    # etiqueta eje Y
        labs(fill = 'Dosis en mg/dia')+ # T�tulo en la leyenda
        theme(legend.position = 'top')+  # Muchos usos, en este ejempo posici�n de la leyenda
        guides(fill = F)
      
      
  # gr�fico 2 (TEMAS)
      plotex <- ggplot(toot, 
             aes(x = dose,
                 y = len))+
        geom_boxplot()
        
      
      # theme black & white
      plotex  + theme_bw()
      
      # theme dark
      plotex +theme_dark()
      
      # theme classic
      plotex + theme_classic()      
      
      # theme gray
      plotex + theme_gray()
      
      # par�metros de configuraci�n (color de fondo)
      plotex + theme(plot.background = element_rect(fill = 'red'))
      
      # Configuraci�n de textos (negritas, colores, tipo de letra)
      plotex + theme(axis.text.y = element_text(face = 'bold',   # puede ser Y
                                                family = 'Times',
                                                size = 14,
                                                angle = 45,
                                                color = '#995566'),
                     axis.text.x = element_text(face = 'italic',
                                                family = 'Courier',
                                                size = 16,
                                                color = '#449955'))+
        theme(panel.border =element_blank())+  # eliminar borde de otro panel
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank()) # elimina lineas detr�s del gr�fico
        
      
      
      
      
      
      
      
      
      
      
      
      