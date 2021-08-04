## ---------------------------
## Script name: Polite Webscraping
## Purpose of script: Learn how to scrape the web 'politely'
## Author: Mike Gibson 
## Date Created: 2021-07-28
## ---------------------------
##
## Notes:
##   
##
## ---------------------------

## set working directory 

setwd("~/Dropbox/Working/RStudio")


## ---------------------------

## load up the packages we will need:  (uncomment as required)

library(rvest)   # 0.3.5
library(polite)  # 0.1.1
library(dplyr)   # 0.8.5
library(tidyr)   # 1.0.2
library(purrr)   # 0.3.4
library(stringr) # 1.4.0
library(glue)    # 1.4.0
library(rlang)   # 0.4.6
## ------------Scraping the 2021-22 Season teams data---------------

url <- "https://en.wikipedia.org/wiki/Premier_League"

session <- bow(url,
               user_agent = "Ryo's R Webscraping Tutorial")

session

#mw-content-text > div.mw-parser-output > table:nth-child(71)

season2122_node <- scrape(session) %>%
  html_nodes("table.wikitable:nth-child(71)")


season2122 <- season2122_node %>% 
  html_table() %>% 
  flatten_df()

## -----------Basic Cleaning----------------


oldnames <- colnames(season2122)
oldnames

newnames <- c("club","position20_21","FirSeasoninTopDiv","FirSeasoninPL","CountSeasonsinTopDiv",
              "CountSeasonsinPL","FirSeasonofCTopDiv","CoountTopDivTitles","MostRecentTopDivTitle")


season2122<-season2122 %>% rename_at(vars(oldnames), ~ newnames)

season2122 <-season2122 %>% mutate(
  founding_club=ifelse(str_detect(club, "[a]")==TRUE,1,0),
  never_regulated=ifelse(str_detect(club, "[b]")==TRUE,1,0),
  original12=ifelse(str_detect(club, "[c]")==TRUE,1,0)
  )

remove_list <- c("[a]","[b]","[c]")

season2122 <- season2122 %>% 
  mutate(club = str_remove(club,coll("[a]")))%>%
  mutate(club = str_remove(club,coll("[b]")))%>%
  mutate(club = str_remove(club,coll("[c]")))
  
season2122 <- season2122 %>% 
  mutate(position20_21 = ifelse(str_detect(position20_21,"CS")==TRUE,"promoted from CS",position20_21))

season2122 <- season2122 %>% 
  mutate(position20_21 = str_remove(position20_21,coll("rd")))%>%
  mutate(position20_21 = str_remove(position20_21,coll("th")))%>%
  mutate(position20_21 = str_remove(position20_21,coll("st")))%>%
  mutate(position20_21 = str_remove(position20_21,coll("nd")))


