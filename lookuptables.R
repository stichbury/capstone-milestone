## Read in the ngram files
myDfm<-readRDS("unigrams.rds")
myDfm2<-readRDS("bigrams.rds")
myDfm3<-readRDS("trigrams.rds")
myDfm4<-readRDS("tetragrams.rds")
myDfm5<-readRDS("pentagrams.rds")


# For each of the 4 word phrases in tetragrams
## Look to see if this phrase starts any pentagrams
### If it does, look at final word
### Find out how many times it features
### Build a probability table


# List all 4 word phrases and look at next word likely to be typed
tetras<-myDfm4@Dimnames$features

df<-data.frame(phrase=character(), tetra_count=numeric(), final=character(), count=numeric())
tets<-as.matrix(myDfm4)
tetra_count<-0
for (tetra in tetras)
{
  # Get a set of 5 word phrases that start with the tetra phrase
  phrases<-grep(paste("^", tetra, "_", sep=""),myDfm5@Dimnames$features)
  tetra_count<-sum(tets[,tetra])
  # What is the final word in each 5 word phrase? How many times is is used?
  x<-0
  while (x < length(phrases) )
  {
    x<-x+1
    phrase<-myDfm5@Dimnames$features[phrases[x]]
    final<-substr(phrase, nchar(tetra)+2, nchar(phrase))
    df<-rbind(df,data.frame(phrase=tetra, tetra_count=tetra_count, final=final, count=sum(myDfm5[,phrase]) )   )
  }
  
}

saveRDS(df, file = "pentdf.rds")


##########################################################

# List all 3 word phrases and look at next word likely to be typed
triads<-myDfm3@Dimnames$features

df3<-data.frame(phrase=character(), triadcount=numeric(), final=character(), phrasecount=numeric())
trios<-as.matrix(myDfm3)
triad_count<-0
for (triad in triads)
{
  # Get a set of 4 word phrases that start with the triad phrase
  phrases<-grep(paste("^", triad, "_", sep=""),myDfm4@Dimnames$features)
  triad_count<-sum(trios[,triad])
  # What is the final word in each 4 word phrase? How many times is is used?
  x<-0
  while (x < length(phrases) )
  {
    x<-x+1
    phrase<-myDfm4@Dimnames$features[phrases[x]]
    final<-substr(phrase, nchar(triad)+2, nchar(phrase))
    df3<-rbind(df3,data.frame(phrase=triad, triadcount=triad_count, final=final, phrasecount=sum(myDfm4[,phrase]) )   )
  }
  
}

saveRDS(df3, file = "tetradf.rds")

##########################################################

# List all 2 word phrases and look at next word likely to be typed
bigrams<-myDfm2@Dimnames$features

df2<-data.frame(phrase=character(), triadcount=numeric(), final=character(), phrasecount=numeric())
duos<-as.matrix(myDfm2)
bigram_count<-0
for (bigram in bigrams)
{
  # Get a set of 3 word phrases that start with the bigram phrase
  phrases<-grep(paste("^", bigram, "_", sep=""),myDfm3@Dimnames$features)
  bigram_count<-sum(duos[,bigram])
  # What is the final word in each 3 word phrase? How many times is is used?
  x<-0
  while (x < length(phrases) )
  {
    x<-x+1
    phrase<-myDfm3@Dimnames$features[phrases[x]]
    final<-substr(phrase, nchar(bigram)+2, nchar(phrase))
    df2<-rbind(df2,data.frame(phrase=bigram, bigramcount=bigram_count, final=final, phrasecount=sum(myDfm3[,phrase]) )   )
  }
  
}

saveRDS(df2, file = "triaddf.rds")


##########################################################

# List all words and look at next word likely to be typed
bigrams<-myDfm@Dimnames$features

df<-data.frame(phrase=character(), triadcount=numeric(), final=character(), phrasecount=numeric())
duos<-as.matrix(myDfm)
bigram_count<-0
for (bigram in bigrams)
{
  # Get a set of 2 word phrases that start with the word
  phrases<-grep(paste("^", bigram, "_", sep=""),myDfm2@Dimnames$features)
  bigram_count<-sum(duos[,bigram])
  # What is the final word? How many times is is used?
  x<-0
  while (x < length(phrases) )
  {
    x<-x+1
    phrase<-myDfm2@Dimnames$features[phrases[x]]
    final<-substr(phrase, nchar(bigram)+2, nchar(phrase))
    df<-rbind(df,data.frame(phrase=bigram, bigramcount=bigram_count, final=final, phrasecount=sum(myDfm2[,phrase]) )   )
  }
  
}

saveRDS(df, file = "bigramdf.rds")







