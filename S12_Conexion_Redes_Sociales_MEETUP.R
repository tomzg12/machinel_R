

  # API Meetup
    api_key <- 'n62d0h4n7vmo6l2n0iml6urelv'
  
    topic <- "mathematics"
    country <- "ES"
    city <- "Mexico City"
    radius <- 500
    fields <- "id,name,members"
    
    url <- paste("https://api.meetup.com/2/groups?&topic=",topic,
                 "&country=",country,
                 "&city=",city,
                 "&radius=",radius,
                 "&only=",fields,
                 "&key=",api_key,
                 sep="")
    url
    
    #-------------------DESDE JSON
    library(jsonlite)
    meetup.data <- fromJSON('G:/BD/GitHub/mlearningcourseR/r-course/data/tema9/meetup-mathematics.json')
    groups <- meetup.data$results
    head(groups)
#-----------------------------------CREAR FUNCIÓN PARA CONSULTA DE API----------
    
    
    
    meetup.getUsers <- function(groups, api_key){
      users <- as.data.frame(NULL)
      for (i in 1:nrow(groups)) {
        url <- paste0("https://api.meetup.com/2/members?group_id=", groups$id[i],
                      "&only=id&key=",api_key)
        while (url!= "") {
          temp_json <- fromJSON(RCurl::httpGET(url))
          if(class(temp_json$results) == "data.frame"){
            tests <- cbind(group_id=groups$id[i],member_id=temp_json$results)
            users <- rbind(users,tests)
          }
          url <- temp_json$meta$`next`
        }
        print(paste0("Hemos recuprado los miembros del grupo ",i))
      }
      u <- data.frame(group_id = users$group_id, user_id = users$id)
      u
    }

  # Ejecutar la función
    members <- meetup.getUsers(groups, api_key)
    members
    
    