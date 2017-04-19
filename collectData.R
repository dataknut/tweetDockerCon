# Collect the twitter data for dockercon - 17 - 21 April, Austin, TX (CDT)
library(data.table)
library(twitteR)
library(readr)

# this needs to be large enough to collect all of them - the API returns a warning if there 
# are less than this but not a wanring if there are more!!

# Only results from the last week (7 days?) will be returned
# https://dev.twitter.com/rest/public/search

maxTweets <- 40000 # let's hope this is enough!

tweetListDT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                        since = "2017-04-16", # exclusive - NB this is UTC
                                        until = "2017-04-22", # inclusive - NB this is UTC
                                        n=maxTweets) 
                                     )
                              )


# save it out
write_csv(tweetListDT, "tweetListDT.csv")
