
# Operaciones con fechas

  dt <- as.Date("1/1/2001", format = '%d/%m/%Y')
  
  dt +100  
  
  dt2 <- as.Date("2001/01/02")
  
  dt- dt2
  dt2-dt
  as.numeric(dt2-dt)  
  
  dt2 == dt

  dt2> dt  

  
  # Hacer una secuencia de fechas (mensual)  
  seq(dt, dt2 +365, 'month')  
  
  # Hacer una secuencia de fechas (diaria)  
  seq(dt, as.Date('2001/01/10'), 'day')  
  
  
  # Hacer una secuencia de fechas (diaria)  
  seq(dt, dt + 365, 'months') 
  
  
  seq(from = dt, by='4 months', length.out = 6)
  
  seq(from = dt, by='4 months', length.out = 6)[3]
  