library(rvest)
library(dplyr)
library(httr)

# Define the URL and the User Agent
url <- "https://kenpom.com/"

user_agent_string <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"

# Wrap your request with the user_agent configuration
page <- read_html(GET(url, user_agent(user_agent_string)))

 Ranks <- page %>%
        html_nodes(".hard_left") %>%
        html_text()
      
 Teams <- page %>%
        html_nodes(".next_left") %>%
        html_text()

dat <- cbind(Ranks,Teams)
write.csv(dat, "cbb_stats.csv", row.names = FALSE)
