# Run the twitter authentication for this app
# Runs interactively and needs internet access as it uses browser based authentication
# Should only ever need to run once as it creates an .oauth file in this directory

# You will need:
# uncomment to install if needed
#install.packages(c("devtools", "rjson", "bit64", "httr")

# uncomment to install twitteR if needed
#library(devtools)
#install_github("twitteR", username="geoffjentry", force = TRUE)
library(twitteR)

source("~/twitterAuthDataknut.R") # location of twitter secrets for dataknut

setup_twitter_oauth(api_key,api_secret)