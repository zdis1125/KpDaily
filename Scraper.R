library(rvest)
library(dplyr)
library(httr)
library(polite)

# Define the URL and the User Agent
url <- "https://kenpom.com/"




session <- bow("https://kenpom.com/", user_agent = "zdis1125@gmail.com")
page <- scrape(session)

Ranks <- page %>%
  html_nodes(".hard_left") %>%
  html_text()

Teams <- page %>%
  html_nodes(".next_left") %>%
  html_text()

dat <- cbind(Ranks,Teams)
write.csv(dat, "cbb_stats.csv", row.names = FALSE)
