# Collect the twitter data for dockercon - 17 - 21 April, Austin, TX (CDT)
library(data.table)
library(twitteR)
library(readr)

# Only results from the last week (7 days?) will be returned
# https://dev.twitter.com/rest/public/search

# this needs to be large enough to collect all of them - the API returns a warning if there 
# are less than this but not a wanring if there are more!!
maxTweets <- 10000 # let's hope this is enough!

tweetListD1DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                        since = "2017-04-16", # exclusive - NB this is UTC
                                        until = "2017-04-17", # inclusive - NB this is UTC
                                        n=maxTweets) 
                                     )
                              )
# save it out
write_csv(tweetListD1DT, "tweetListD1DT.csv")

tweetListD2DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-04-17", # exclusive - NB this is UTC
                                                     until = "2017-04-18", # inclusive - NB this is UTC
                                                     n=maxTweets) 
                                       )
)

# save it out
write_csv(tweetListD2DT, "tweetListD2DT.csv")

tweetListD3DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-04-18", # exclusive - NB this is UTC
                                                     until = "2017-04-19", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
write_csv(tweetListD3DT, "tweetListD3DT.csv")


tweetListD4DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-04-19", # exclusive - NB this is UTC
                                                     until = "2017-04-20", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
write_csv(tweetListD4DT, "tweetListD4DT.csv")

tweetListD5DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-04-20", # exclusive - NB this is UTC
                                                     until = "2017-04-21", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
write_csv(tweetListD5DT, "tweetListD5DT.csv")
