
### Crear una secuencia de datos (seq)
#-----------------------------------------------------------------------
d_ini <- 0.01
d_fin <- 0.99
skip  <- 0.01 

s <- seq(d_ini, d_fin, skip) # De 0.01 a 0.99 con saltos de 0.01
s

# Devolver los percentiles de la base de datos
qn <- qnorm(s)
qn

# Crear dataframe  (primera columna = p, segunda columna = q)
df <- data.frame(p= s, q = qn)
df

# Muestras aleatorias siguiendo distribución normal
sample <- rnorm(200)   # con 200 muestras
quantile(sample, probs = s)
#-----------------------------------------------------------------------

### Gráfico QQ Plot  / QQ Norm
    # qqnorm
        trees  # dataframe gratuito en R (parámetros de árboles)
        head(trees,1)  # Solo encabezados
        par(mfrow = c(1,1))   # parámetro 
        qqnorm(trees$Height)

    # qqplot
        randu   # dataset gratuito distribución uniforme
        n <- length(randu$x)  # longitud del df
        n        
        
        y <- qunif(ppoints(n))
        y        
        qqplot(y, randu$x)
      
    # normal de 30 puntos
        n30 <- qnorm(ppoints(30))
          
    # Distribución de cauchy
        cauchy <- qcauchy(ppoints(30))
        qqplot(n30, cauchy)
        
  
  # Formas de distribuciones en R
        # vector
        par(mfrow = c(1,2))
        x <- seq (-3, 3, 0.01)
        plot(x, dnorm(x))   # No acumulativa (usando d)
        plot(x, pnorm(x))   # Acumulativa (usando p)     
        