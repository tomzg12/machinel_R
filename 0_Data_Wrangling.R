
  devtools::install_github('rstudio/EDAWR') 
  
 
  install.packages('gsubfn')
  install.packages('proto')
  install.packages('RSQLite')
  install.packages('sqldf')
  
# import library
  library(ggplot2)
  library(dplyr)
  library(tidyverse)
  library(EDAWR)
  library(scales)
    library(gsubfn)
    library(proto)
    library(RSQLite)
  library(sqldf)
  
  # Import datset
  data <- read.csv('G:/BD/GitHub/mlearningcourseR/r-course/data/tema4/education.csv')
  
  names(data)
        
          # Transformar en dataset
          as_tibble(data)
          
          # Ver el dataset completo
          View(data)
          
        
                # Data Wrangling
                data$state  #<- 1 column
                
                names(data)   # columns names
                names(data)[-1]  # columns names except last one
                
                unlist(data[1:3, 2:5]) #Transpose rows : columns
                
                # Create a calculated field
                data$ratio <- percent(round((data$expense / 
                                       data$income),4))
                
                
              # Spread and Gather
                #---- GATHER (Reunir)
              
                # Try dataset
                cases
                
                t.df <-gather(cases, # Dataset name
                     year, # Name of the category column (original names of columns)
                     account,   # Name of the new column (with values)
                     2:4)  # Columns range to transpose
                
                t.df
                
                # ---- SPREAD
                # Try dataset
                
                spread(t.df,    #Dataset name
                       year,    #Column to transpose
                       account) #Column with data to transpose 
                
                # ---- SPREAD
                # Try dataset
                pollution
                  
                spread(pollution, 
                       size,
                       amount)
          
          #---- SPLIT COLUMNS    
          
          # Test dataset
          storms
                        
          # Split columns   
          storms2 <- separate(storms,     # dataset name 
                   date,       # column to split
                   c('year',   # name of the new columns
                     'month',
                     'day'),
                   sep = '-')  # separator
          
          
          
          #---- UNITE COLUMNS    
          
          storms3 <- unite(storms2,     # dataset name 
                   'date',
                   year,
                   month, 
                   day, 
                   sep = '-')  # separator
          
          
  ## WAYS TO ACCESS INFORMATION
          # Extract existing variables          = select()
          # Extract existing observations       = filter()
          # Derive new variables                = mutate()
          # Change the unit of analysis         = summarise()
          
          
          # Try dataset
          storms
          
          
          # Select (by column name, or index column)
          
          select(storms,
                 1,4)
          
          select(storms,
                 pressure)
          
          select(storms,
                 1:4)
          
          select(storms, 
                 -storm)
          
          select(storms, 
                 -3:-4)
          
  #--------FILTER
          
          storms
          
          filter(storms,
                 wind >= 50)
          
          filter(storms,
                 wind >= 10,
                 storm %in% c('Alberto',
                              'Alex',
                              'Allison'))
          
          filter(storms,
                 wind >= 50 &
                   pressure == 1007)
          
          # Efficient
          storms %>% filter(wind >= 50)
          
  #------- MUTATE (Copy of a df with new field columns)
          mutate(storms,
                 ratio1  = pressure / wind,   # New calculated field
                 ratio2 = ratio1^2)           # New calculated field
          
          
           cumsum(storms$wind)  # Cummulative sum
            storms$wind
            
            cummean(storms$wind)
  
            
  #----------SUMMARISE
              pollution
              
              pollution %>%
                summarise(median = median(amount),     #Mediana
                          variance = var (amount),     #Varianza
                          n = n(),                     #Numero de filas
                          n_distinct(pollution$size),   #Numero de distintas
                          sum(amount))
                          
            # Distinct counts with SQL Package
              
              sqldf("select distinct(size) 
                    from pollution")
              
              
              
 #-----ARRANGE (SORT)
              arrange(pollution, 
                      (amount))
              
              arrange(pollution, 
                      desc(amount))
              
              arrange(pollution, 
                      desc(amount),
                      desc(size))
              
              # Efficient
              pollution %>% arrange(desc(amount))
              
              
              
 # ADVANCED FILTERS-------------------------------------
              names(storms)
              storms %>%
                filter (wind >= 50) %>%
                select(storm, pressure)
              
              
              storms %>%
                mutate(ratio = pressure / wind) %>%
                select(storm, ratio)
              
              
              #    %>%    (Ctrl + Shift + M)
              
  ##-----------group by
              
              pollution
              
              pollution %>% group_by(city)  
              
              pollution %>% group_by(city) %>% 
                summarise(mean = mean(amount),
                          sum = sum(amount),
                          n = n(),
                          unique = n_distinct(city))
              
            tb
            cases
          
            tb %>% 
              group_by(country, year) %>% 
              summarise(cases = sum(child))
            
#-------------JOINING DATA----------------
              
              y  #df1
              z  #df2             

                new_df_cols <-bind_cols(y, z) #add of datasets by column
                colnames(new_df_cols)<-c('a','b','c','d')  # Change names
                new_df_cols              #Dataset with changed names
              
                
                new_df_rows <-bind_rows(y,z) # add of dsets by rows
                new_df_rows  # New datset with add by rows
                
                
                ## --UNION--
                union(y,z)  # union of rows appears in both dataframes
                
                ## -- INTERSECT--
                intersect(y,z)  # Keep the rows with same value
                
                ## --SETDIFF--
                setdiff(y,z) # Show the different rows in two dframes
                
          #DATAFRAMES  ---- JOINS
            
          songs
          artists                
          
          #-- Left join
          left_join(songs, 
                    artists,
                    by = 'name')
                
                
                
          #df 
          songs2
          artists2
          
          artists2[1:2,1:2]
                
          # Advanced left join
          left_join(songs2,
                    artists2,
                    by = c('first', 'last'))
          
          ####----INNER JOIN  (Just keep rows appear in both df)
          inner_join(songs,
                     artists,
                     by ='name')
          
          ####-----SEMI JOIN (keeps left df filtered by rows appears in another df)
                              #Not show value from the other df
          semi_join(songs,
                    artists,
                    by = 'name')
          
          ###----ANTI JOIN (keeps rows doesnt appear in right dframe)
            anti_join(songs,
                      artists,
                      by='name')
          
          ## right join----
            right_join(songs, 
                       artists,
                       by = 'name')
          
              