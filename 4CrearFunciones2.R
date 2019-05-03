opBasic = function(a, b){
  print('Suma') 
  print(a+b)
  
  print('Resta') 
    print(paste(sprintf('%i -%i =', a, b),a-b))
    print(paste(sprintf('%i -%i =', b, a),b-a))
  
  print('Multiplicación') 
  print(a*b)
  print('Cociente') 
      print(paste(sprintf('%i /%i =', a, b),a%/%b))
      print(paste(sprintf('%i /%i =', b, a),b%/%a))
      
  print('Resto de la división entera') 
  print(a%%b)
  print(b%/%a)
}

opBasic(8,2)
