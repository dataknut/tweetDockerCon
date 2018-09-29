## search for 18000 tweets using the rstats hashtag
boty <- rtweet::search_tweets(
  "#birdoftheyear", n = 18000, include_rts = TRUE
)

botyDT <- data.table::as.data.table(boty)

skimr::skim(botyDT)


## search for 18000 tweets using the rstats hashtag
rstats <- rtweet::search_tweets(
  "#rstats", n = 18000, include_rts = FALSE
)

rstatsDT <- data.table::as.data.table(rstats)

skimr::skim(rstatsDT)