## ---------------------------
## Script name: All time premier league stats
## Purpose of script: Learn how to scrape the web 'politely'
## Author: Mike Gibson 
## Date Created: 2021-07-28
## ---------------------------
##
## Notes:
##   https://ivelasq.rbind.io/blog/politely-scraping/
##   https://ryo-n7.github.io/2020-05-14-webscrape-soccer-data-with-R/
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

url <- "https://en.wikipedia.org/wiki/Premier_League_records_and_statistics#All-time_Premier_League_table"
session <- bow(url,
               user_agent = "Ryo's R Webscraping Tutorial")

session

atpl_node <- scrape(session) %>%
  html_nodes("table.wikitable:nth-child(76)")


atpl <- atpl_node %>% 
  html_table() %>% 
  flatten_df()


## ---------------- Basic Cleaning ------------


#test 
ß
