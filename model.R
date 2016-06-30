# 4 words plus suggested 5th "pentdf.rds"
# 3 words plus suggested 4th "tetradf.rds"
# 2 words plus suggested 3rd "triaddf.rds" 
# 1 word plus suggested 2nd "bigramdf.rds"

# TO DO
# Remove phrases that have already been seen in previous loops 
# What about stripping punctuation?
# ALlow for typos?

library(stringr)
# Allocate the data frame that'll hold the results
suggestions <-data.frame(finalWord=character(), probability=numeric(), level=numeric())

# Get a phrase
phrase<-"If THIS isn't THe cutest thING you've ever seen, then you must be"

# Take last 4 words 
seek<-paste(stringr::word(phrase, -4), "_", stringr::word(phrase, -3), "_", stringr::word(phrase, -2), "_", stringr::word(phrase, -1), sep="")

# Look in pentdf.rds and identify rows that match those words
df5<-readRDS("pentdf.rds")
res5<-df5[df5$phrase==seek,]

# Use rows to calculate probabilities
if (nrow(res5)>0)
{
  count<-nrow(res5)
  i<-1
  while (i <= count)
  {
    prob<-(res5[i,])$phrasecount/(res5[i,])$tetracount  
    suggestions<-rbind(suggestions,data.frame(finalWord=as.character(res5[i,]$final), probability=prob, level=1))
    i<-i+1
  }
}

# If less than 5 options suggested, back off and take last 3 words
if (nrow(suggestions)<5)
{
  
  # Take last 3 words 
  seek<-paste(stringr::word(phrase, -3), "_", stringr::word(phrase, -2), "_", stringr::word(phrase, -1), sep="")
  
  # Look in tetradf.rds and identify rows that match those words
  df4<-readRDS("tetradf.rds")
  
  res4<-df4[df4$phrase==seek,]
  
  # Use rows to calculate probabilities
  if (nrow(res4)>0)
  {
    count<-nrow(res4)
    i<-1
    while (i <= count)
    {
      prob<-(res4[i,])$phrasecount/(res4[i,])$triadcount 
      prob<-prob*0.4 # Back off factor
      suggestions<-rbind(suggestions,data.frame(finalWord=as.character(res4[i,]$final), probability=prob, level=2))
      i<- i+1
    }
  }

  # If still less than 5 options suggested, back off and take last 2 words
  if (nrow(suggestions)<5)
  {
    # Take last 2 words 
    seek<-paste(stringr::word(phrase, -2), "_", stringr::word(phrase, -1), sep="")
    
    # Look in triaddf.rds and identify rows that match those words
    df3<-readRDS("triaddf.rds")
    
    res3<-df3[df3$phrase==seek,]
    
    # Use rows to calculate probabilities
    if (nrow(res3)>0)
    {
      count<-nrow(res3)
      i<-1
      while (i <= count)
      {
        prob<-(res3[i,])$phrasecount/(res3[i,])$bigramcount  
        prob<-prob*0.4*0.4 # back off factor
        suggestions<-rbind(suggestions,data.frame(finalWord=as.character(res3[i,]$final), probability=prob, level=3))
        i<-i+1
      }
    }
  
    # If still less than 5 options, back off and take last word typed
    if (nrow(suggestions)<5)
    {
      seek<-paste(stringr::word(phrase, -1), sep="")
      
      # Look in bigramdf.rds and identify rows that match the word
      df2<-readRDS("bigramdf.rds")
      res2<-df2[df2$phrase==seek,]
      
      # Use rows to calculate probabilities
      if (nrow(res2)>0)
      {
        count<-nrow(res2)
        i<-1
        while (i <= count)
        {
          prob<-(res2[i,])$phrasecount/(res2[i,])$bigramcount  
          prob<-prob*0.4*0.4*0.4 #back off factor
          suggestions<-rbind(suggestions,data.frame(finalWord=as.character(res2[i,]$final), probability=prob, level=4))
          i<-i+1
        }
      }
    }
  }
}












