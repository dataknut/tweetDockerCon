# Collect the twitter data for dockercon EU October 2017
library(data.table)
library(twitteR)
library(readr)

# Only results from the last week (7 days?) will be returned
# https://dev.twitter.com/rest/public/search

# this needs to be large enough to collect all of them - the API returns a warning if there 
# are less than this but not a warning if there are more!!
maxTweets <- 10000 # let's hope this is enough!

tweetListD1DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                        since = "2017-10-16", # exclusive - NB this is UTC
                                        until = "2017-10-17", # inclusive - NB this is UTC
                                        n=maxTweets) 
                                     )
                              )
# save it out
print("Saving day 1")
write_csv(tweetListD1DT, "dockerConEU2017tweetListD1DT.csv")

tweetListD2DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-10-17", # exclusive - NB this is UTC
                                                     until = "2017-10-18", # inclusive - NB this is UTC
                                                     n=maxTweets) 
                                       )
)

# save it out
print("Saving day 2")
write_csv(tweetListD2DT, "dockerConEU2017tweetListD2DT.csv")

tweetListD3DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-10-18", # exclusive - NB this is UTC
                                                     until = "2017-10-19", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
print("Saving day 3")
write_csv(tweetListD3DT, "dockerConEU2017tweetListD3DT.csv")


tweetListD4DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-10-19", # exclusive - NB this is UTC
                                                     until = "2017-10-20", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
print("Saving day 4")
write_csv(tweetListD4DT, "dockerConEU2017tweetListD4DT.csv")

tweetListD5DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-10-20", # exclusive - NB this is UTC
                                                     until = "2017-10-21", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
print("Saving day 5")
write_csv(tweetListD5DT, "dockerConEU2017tweetListD5DT.csv")

tweetListD6DT <- data.table(twListToDF(searchTwitter("#dockercon", 
                                                     since = "2017-10-21", # exclusive - NB this is UTC
                                                     until = "2017-10-22", # inclusive - NB this is UTC
                                                     n=maxTweets) 
)
)

# save it out
print("Saving day 6")
write_csv(tweetListD6DT, "dockerConEU2017tweetListD6DT.csv")