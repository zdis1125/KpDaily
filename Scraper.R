library(rvest)
library(dplyr)
library(httr)

target_url <- "https://kenpom.com/"

# This builds the special "Middleman" URL
proxy_url <- paste0("http://api.scraperapi.com?api_key=", "0cb854720319f36ef4c5e17a9cf4bd57", "&url=", target_url)

# Now, instead of GitHub calling KenPom directly, it calls the API
response <- GET(proxy_url)

# This should now return a 200 (Success) instead of a 403!
page <- read_html(response)


Ranks <- page %>%
  html_nodes(".hard_left") %>%
  html_text()

Teams <- page %>%
  html_nodes(".next_left") %>%
  html_text()
