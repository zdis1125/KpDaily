library(rvest)
library(dplyr)
library(httr)

url <- "https://kenpom.com/"
proxy_url <- "69.48.201.94:80"

# 1. Expand your headers. 
# We add 'Accept' and 'Accept-Language' to look like a standard browser.
response <- GET(
  url,
  use_proxy(proxy_url),
  add_headers(
    `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    `Accept` = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
    `Accept-Language` = "en-US,en;q=0.5",
    `Referer` = "https://www.google.com/" # Pretend we came from Google
  )
)

page <- read_html(response)

# 3. Your scraping logic (Keep this the same)
Ranks <- page %>% html_nodes(".hard_left") %>% html_text()
Teams <- page %>% html_nodes(".next_left") %>% html_text()

# KenPom tables often have header rows repeated; let's clean it slightly
dat <- data.frame(Ranks, Teams) %>%
  filter(Ranks != "Rank") # Removes the table headers that look like data

write.csv(dat, "cbb_stats.csv", row.names = FALSE)
