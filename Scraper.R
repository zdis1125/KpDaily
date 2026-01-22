library(dplyr)
library(httr)

# Define the URL and the User Agent
url <- "https://kenpom.com/"
ua <- user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")

# Scrape the data
response <- GET(url, ua)
page <- read_html(response)

 Ranks <- page %>%
        html_nodes(".hard_left") %>%
        html_text()
      
 Teams <- page %>%
        html_nodes(".next_left") %>%
        html_text()

dat <- cbind(Ranks,Teams)
write.csv(dat, "cbb_stats.csv", row.names = FALSE)
