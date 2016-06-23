library(quanteda)
tf <- textfile("*.txt", cache=FALSE)


# Make a dfm (document feature matrix)
# Converts to lower case and removes numbers, separators, punctuation by default.
# Also remove Twitter and perform profanity filtering (word list courtesy of http://www.bannedwordlist.com)

naughtyFile<- file("swearwords", "r") 
naughtyWords = readLines(naughtyFile)
close(naughtyFile)

myDfm <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=1, ignoredFeatures = naughtyWords)
myDfm<-sort(myDfm, margin="both")
saveRDS(myDfm, file = "unigrams.rds")

#Now ngrams=2
myDfm2 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=2, ignoredFeatures = naughtyWords)
myDfm2<-sort(myDfm2, margin="both")
saveRDS(myDfm2, file = "bigrams.rds")

#Now ngrams=3
myDfm3 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=3, ignoredFeatures = naughtyWords)
myDfm3<-sort(myDfm3, margin="both")
saveRDS(myDfm3, file = "trigrams.rds")

#Now ngrams=4
myDfm4 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=4, ignoredFeatures = naughtyWords)
myDfm4<-sort(myDfm4, margin="both")
saveRDS(myDfm4, file = "tetragrams.rds")

#Now ngrams=5
myDfm5 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=5, ignoredFeatures = naughtyWords)
myDfm5<-sort(myDfm5, margin="both")
saveRDS(myDfm5, file = "pentagrams.rds")


