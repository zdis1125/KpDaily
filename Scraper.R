library(rvest)
library(dplyr)
library(httr)


# Define the URL and the User Agent
url <- "https://kenpom.com/"


my_ua <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36"
url <- "https://kenpom.com/"

# Use GET with your User Agent
response <- GET(url, user_agent(my_ua))

# Now read the HTML
page <- read_html(response)


Ranks <- page %>%
  html_nodes(".hard_left") %>%
  html_text()

Teams <- page %>%
  html_nodes(".next_left") %>%
  html_text()

dat <- cbind(Ranks,Teams)
write.csv(dat, "cbb_stats.csv", row.names = FALSE)
