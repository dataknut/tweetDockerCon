# Collect hashtagged twitter data for a given series of dates
library(data.table)
library(twitteR)
library(readr)

# Only results from the last week (7 days?) will be returned
# https://dev.twitter.com/rest/public/search

# this needs to be large enough to collect all of them - the API returns a warning if there 
# are less than this but not a warning if there are more!!
maxTweets <- 10000 # let's hope this is enough!
# No, it isn't

# we're going to loop through the possible days 1 day at a time
startDay <- as.Date("2018-05-19") # 
endDay <- as.Date("2018-05-20") # allow for post day excitement
hashTag <- "#royalWedding"
filename <- "royalWedding"

tweetsDT <- as.data.table(NULL) # data collector
days <- seq(startDay, endDay, by = "day")
for(d in days){
  print(paste0("Searching ", as.Date.IDate(d), " for ", hashTag))
  s <-  as.Date.IDate(d)
  e <- as.Date.IDate(d+1)
  dt <- data.table(twListToDF(searchTwitter(hashTag, 
                                                  since = as.character(s), # exclusive - NB this is UTC
                                                  until = as.character(e), # inclusive - NB this is UTC
                                                  n=maxTweets)
                              )
                   )
  rbind(dt,tweetsDT)
}

# save it out
print("Saving tweets")
write_csv(tweetsDT, paste0("data/",filename,".csv"))