library(rvest)
library(dplyr)
library(httr)

url <- "https://kenpom.com/"
my_ua <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# If you use a service like ScraperAPI (they have a free tier), 
# you literally just change the URL:
api_key <- "8482d338-e81b-4295-ada1-8b0d950ef5d7"
proxy_url <- paste0("http://api.scraperapi.com?api_key=", api_key, "&url=", url)

response <- GET(proxy_url) # The API uses its own clean IPs to hit KenPom for you
page <- read_html(response)

# 3. Your scraping logic (Keep this the same)
Ranks <- page %>% html_nodes(".hard_left") %>% html_text()
Teams <- page %>% html_nodes(".next_left") %>% html_text()

# KenPom tables often have header rows repeated; let's clean it slightly
dat <- data.frame(Ranks, Teams) %>%
  filter(Ranks != "Rank") # Removes the table headers that look like data

write.csv(dat, "cbb_stats.csv", row.names = FALSE)
