# Collect the twitter data for dockercon - 17 - 21 April, Austin, TX (CDT)
library(data.table)
library(twitteR)
library(readr)

tweetListDT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                        since = "2017-04-16", # exclusive - NB this is UTC
                                        until = "2017-04-22", # inclusive - NB this is UTC
                                        n=40000)
                                        )
                              )


# save it out
write_csv(tweetListDT, "tweetListDT.csv")
