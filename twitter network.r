#Twitter Network Sript

#Philip Bard 
#Created: 25 June 2021
#email: pmylesb@gmail.com

#----Setup----

rm(list=ls()) #remove any previous vars in environment
setwd('')

#load data analysis libraries
library(tidyverse)

# load twitter library
library(rtweet)

# text mining/analysis libraries
library(tidytext)
library(quanteda.textstats)
library(quanteda.textplots)
library(quanteda)
library(stopwords)

#word cloud
#library(wordcloud) #not used in this script
library(wordcloud2)
library(RColorBrewer)

## check to see if the token is loaded
get_token()

# some code skipped here for Twitter API security reasons

# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)

#----Get Tweets----

rawTweets <- search_tweets(q='""', lang='en', include_rts = FALSE, 
                           retryonratelimit = TRUE, type = "popular", n = 500)

#----Network----

rawText <- tokens(rawTweets$text, remove_punct = TRUE, 
                  what='word', remove_symbols = TRUE)

rawText <- tokens_remove(rawText, pattern=stopwords('en'))

rawDFM <- dfm(rawText)

network <- textplot_network(rawDFM,
                 vertex_labelsize = 3,
                 edge_color = 'red',
                 vertex_size = 1,
                 edge_alpha = .15) #usually doesn't work if tweets > 500

#----Most RT----
rtTable <- unique(data.frame(rawTweets$text, rawTweets$retweet_count))
