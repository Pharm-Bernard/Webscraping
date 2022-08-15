library(rvest)
library(tidyverse)


goals <- list()

for (year in 2010: 2021) {
  message("Scrapping goals stat for: ", year, "-", year+1, "season")
  
  season = paste0("https://www.espn.com/soccer/stats/_/league/ENG.1/season/", year, "/view/scoring" ) %>% 
    read_html()
  
  stat= tibble(
    
    Player_name= season%>% 
      html_nodes(".top-score-table .Table__TD:nth-child(2)") %>% 
      html_text(), 
    
    team= season  %>% 
      html_nodes(".top-score-table .Table__TD~ .Table__TD+ .Table__TD .AnchorLink") %>% 
      html_text(), 
    
    year = year, 
    
    games_played= season %>%  
      html_nodes(".top-score-table .Table__TD:nth-child(4) .tar") %>% 
      html_text(), 
    
    scored = season %>% 
      html_nodes(".top-score-table .tar+ .Table__TD .tar") %>% 
      html_text()
  )
  goals[[length(goals)+1]] = stat
}

goals_stat <- do.call(rbind, goals)


#################################################################
#################################################################
#################################################################


assist <- list()

for (year in 2002: 2021) {
  message("Scrapping assist stat for: ", year, "-", year+1, "season")
  season = paste0("https://www.espn.com/soccer/stats/_/league/ENG.1/season/", year, "/view/scoring" ) %>% 
    read_html()
  
  stat= tibble(
    
    Player_name= season%>% 
      html_nodes(".top-assists-table .Table__TD:nth-child(2)") %>% 
      html_text(), 
    
    team= season  %>% 
      html_nodes(".top-assists-table .Table__TD~ .Table__TD+ .Table__TD .AnchorLink") %>% 
      html_text(), 
    
    year = year, 
    
    games_played= season %>%  
      html_nodes(".top-assists-table .Table__TD:nth-child(4) .tar") %>% 
      html_text(), 
    
    assist = season %>% 
      html_nodes(".top-assists-table .tar+ .Table__TD .tar") %>% 
      html_text()
  )
  assist[[length(assist)+1]] = stat
}

assist_stat <- do.call(rbind, assist)


playerstat <- full_join(goals_stat, assist_stat)

