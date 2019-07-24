
# Paquete GGMAP

  install.packages(c('ggmap', 'maps'))
  library(ggmap)
  library(maps)

crimes <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema12/chicago-crime.csv')  

crimes$Date <- strptime(crimes$Date, 
                        format = '%m/%d/%y %H:%M')  

head(crimes)


chicago <- get_map(location = 'Chicago', 
                   API_console_key = 'AIzaSyBWuMsLKZ16kpB6XHWyLpfUpyxZe-7zqiA',
                   zoom = 11)
