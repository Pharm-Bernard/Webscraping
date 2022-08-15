  
  
  league <- list()
  
  for (year in 2002: 2003) {
    message("League table at the end of : ", year, "-", year+1, " season")
    season = paste0("https://www.espn.com/soccer/standings/_/league/eng.1/season/", year) %>% 
      read_html()
    
    table= data.frame(
      
      standing= c(1:20), 
     
      Team= season%>% 
        html_nodes(".hide-mobile .AnchorLink") %>% 
        html_text(), 
      
      W= season  %>% 
        html_nodes(".Table__TD:nth-child(2) .stat-cell") %>% 
        html_text(), 
      
      D= season%>% 
        html_nodes(".Table__TD:nth-child(3) .stat-cell") %>% 
        html_text(),
        
      L = season%>% 
        html_nodes(".Table__TD:nth-child(4) .stat-cell") %>% 
        html_text(),
        
      For= season%>% 
        html_nodes(".Table__TD:nth-child(5) .stat-cell") %>% 
        html_text(),
      
      Against= season%>% 
        html_nodes(".Table__TD:nth-child(6) .stat-cell") %>% 
        html_text(),
        
      Points= season%>% 
        html_nodes(".Table__TD:nth-child(8) .stat-cell") %>% 
        html_text(),
        
      year = year 
      
      )
    
    
    table$position=case_when(
      standing==1 ~ "League Champion",
      standing <= 4 ~ "Champions league", 
      standing <= 6 ~ "Europa league ",
      standing <= 10 ~ "Top half"
      standing <= 17 ~ "Bottom half",
      TRUE~"Relegation"
    )
      
    league[[length(league)+1]] = table
  }
