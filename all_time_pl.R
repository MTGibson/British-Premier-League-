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
library(expss)
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

oldnames <- colnames(atpl)
oldnames

newnames <- c("position","club_name","seasons_count","matches_played","matches_won",
              "matches_drawn","matches_lost","goals_for","goals_against","goal_difference",
              "points","cseas_firplace","cseas_secplace","cseas_thirplace","cseas_forplace",
              "relegated_count","best_position")


atpl<-atpl %>% 
  rename_with(~ newnames[which(oldnames == .x)], .cols = oldnames)




atpl = apply_labels(atpl,
                    position = "Position",
                    club_name = "Number of cylinders",
                    seasons_count = "Count of seasons played",
                    matches_played = "Count of matches played",
                    matches_won = "Count of matches won",
                    matches_drawn = "Count of matches resulting in a draw",
                    matches_lost = "Count of matches lost",
                    goals_for = "Count of goals scored by a team in any game across all seasons",
                    goals_against = "Count of goals scored against a team in any game across all seasons",
                    goal_difference = "Net of goals for - goals against",
                    points = "Points earned",
                    cseas_firplace = "Count of seasons team got first place in league",
                    cseas_secplace = "Count of seasons team got second place in league",
                    cseas_thirplace = "Count of seasons team got third place in league",
                    cseas_forplace = "Count of seasons team got fourth place in league",
                    relegated_count = "Count of seasons team was relegated",
                    best_position = "Best position team has earned across all seasons"
                    )


