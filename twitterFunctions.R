# This is a function to install any packages that are not present
# Especially useful when running on virtual machines where package installation is not persistent. Like UoS sve :-(
# It will fail if the packages need to be installed but there is no internet access
# Courtesy of Luke Blunden
lb_myRequiredPackages <- function(x,y){
  for( i in x ){
    #  require returns TRUE if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , repos=y ,
                        #type="win.binary" , comment out so runs on OS X etc
                        quiet=TRUE , dependencies = TRUE , verbose = FALSE )
      #  Load package after installing
      require( i , character.only = TRUE, quietly = TRUE )
    }
  }
}

# libs required by functions in here
reqLibs <- c("data.table", "readr", "twitteR", "lubridate")

print(paste0("Loading the following libraries using lb_myRequiredPackages: ", reqLibs))
# Use Luke's function to require/install/load
lb_myRequiredPackages(reqLibs,"http://cran.rstudio.com/")

ba_collectTweets <- function(maxTweets, startDay, endDay, hashtag, oFile){
  # Only results from the last week (7 days?) will be returned
  # https://dev.twitter.com/rest/public/search
  
  # this needs to be large enough to collect all of them - the API returns a warning if there 
  # are less than this but not a warning if there are more!!
  maxTweets <- maxTweets # let's hope this is enough!
  
  # Collect hashtagged twitter data for a given series of dates
  # expects start date, end date (inclusive) and a hashtag
  # saves &/or returns single data table of all matching tweets
  tweetsDT <- as.data.table(NULL) # data collector
  days <- seq(startDay, endDay, by = "day")
  for(d in days){
    print(paste0("Searching ", as.Date.IDate(d), " for ", hashTag))
    s <-  as.Date.IDate(d)
    e <- as.Date.IDate(d+1)
    # check the day is now or previous
    try(dt <- data.table(twListToDF(searchTwitter(hashTag, 
                                                     since = as.character(s), # exclusive - NB this is UTC
                                                     until = as.character(e), # inclusive - NB this is UTC
                                                     n=maxTweets)
                                                    )
                                         )
    )
    # dt may be empty if no tweets returned
    print(head(dt))
    # save it out to wherever
    f <- paste0(oFile,"_", s,".csv")
    print(paste0("Saving tweets to ", f))
    write_csv(dt, f) # consider gzipping?
    if(nrow(dt) > 0){tweetsDT <- rbind(tweetsDT,dt)}
  }
  
  # save it out to wherever
  print("Saving tweets")
  f <- paste0(oFile,"_allTweets.csv")
  try(write_csv(tweetsDT, f)) # consider gzipping?
  return(tweetsDT)
}


ba_tidyNum <- function(number) { 
  # puts commas in a long number and stops scientific format
  format(number, big.mark=",", scientific=FALSE)
}

# some things we'll use later
ba_setUseFullTimes <- function(dt){
  # set to central time
  dt <- dt[, createdLocal := with_tz(created, tz = timeZone)] # local
  # convert created to minutes
  dt <- dt[,
           obsDateTimeMins := floor_date(createdLocal, # requires lubridate
                                         unit="minutes"
           )
           ]
  dt <- dt[,
           obsDateTimeHours := floor_date(createdLocal, # requires lubridate
                                          unit="hours"
           )
           ]
  dt <- dt[,
           obsDateTime5m := floor_date(createdLocal, # requires lubridate
                                       unit="5 minutes"
           )
           ]
  dt <- dt[,
           obsDateTime10m := floor_date(createdLocal, # requires lubridate
                                        unit="10 minutes"
           )
           ] 
  dt <- dt[,
           obsDateTime15m := floor_date(createdLocal, # requires lubridate
                                        unit="15 minutes"
           )
           ] 
  
  dt <- dt[, obsDate := as.Date(obsDateTimeMins, tz = timeZone)]
  
  # test
  #t <- tweetListDT[, .(createdLocal, obsDate, obsDateTimeMins)]
  
  dt <- dt[, obsHourMin := format(createdLocal, format = "%H:%M")]
  dt <- dt[, obsHourMin := as.POSIXct(strptime(obsHourMin, "%H:%M"))] # convert the char back to a fake date and correct time
 # makes graphs easier (will set date to 'today') - slow - must be a lubridatey way to do this
  
  dt <- dt[, isRetweetLab := ifelse(isRetweet == "FALSE",
                                    "Original tweet",
                                    "Re-tweet"
  )
  ]
  # check
  #table(tweetListDT$isRetweet,tweetListDT$isRetweetLab)
  return(dt)
}

ba_make5MinTimeSeriesChart <- function(dt,byVars,facetForm){
  # obsDateTime5m must be one of the byVars
  # whatever is in facetForm must also be in byVars
  plotDT <- dt[,
               .(
                 nTweets = .N,
                 nTweeters = uniqueN(screenName)
               ), by = eval(byVars)
               ]
  
  
  myPlot <- ggplot(plotDT, aes(x = obsDateTime5m)) +
    geom_line(aes(y = nTweets, colour = "N tweets")) +
    geom_line(aes(y = nTweeters, colour = "N tweeters")) +
    facet_grid(eval(facetForm)) +
    theme(strip.text.y = element_text(size = 9, colour = "black", angle = 90)) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5)) +
    scale_x_datetime(date_breaks = "2 hours", date_labels ="%a %d %b %H:%M") +
    theme(legend.position = "bottom") +
    theme(legend.title = element_blank()) +
    labs(caption = myCaption,
         x = "Time",
         y = "Count"
    )
  return(myPlot)
}
