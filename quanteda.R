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

#Word cloud of the top 100 words
if (require(RColorBrewer))
  plot(myDfm, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
barplot(topfeatures(myDfm, 75), horiz=TRUE, cex.names=0.7,las=2, xaxt = "n", lwd = 7, main = "Top 75 unigrams")

#Now ngrams=2
myDfm2 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=2, ignoredFeatures = naughtyWords)
myDfm2<-sort(myDfm2, margin="both")
saveRDS(myDfm2, file = "bigrams.rds")

if (require(RColorBrewer))
  plot(myDfm2, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
barplot(topfeatures(myDfm2, 75), horiz=TRUE, cex.names=0.7,las=2, xaxt = "n", lwd = 7, main = "Top 75 bigrams")

#Now ngrams=3
myDfm3 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=3, ignoredFeatures = naughtyWords)
myDfm3<-sort(myDfm3, margin="both")
saveRDS(myDfm3, file = "trigrams.rds")

if (require(RColorBrewer))
  plot(myDfm3, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
par(mar=c(5,8,4,2)) # increase y-axis margin.
barplot(topfeatures(myDfm3, 75), horiz=TRUE, cex.names=0.8,las=2, xaxt = "n", lwd = 7, main = "Top 75 trigrams")

#Now ngrams=4
myDfm4 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=4, ignoredFeatures = naughtyWords)
myDfm4<-sort(myDfm4, margin="both")
saveRDS(myDfm4, file = "tetragrams.rds")

if (require(RColorBrewer))
  plot(myDfm4, max.words=30, colors = brewer.pal(7, "Set1"))

#Now ngrams=5
myDfm5 <- dfm(corpus(tf), removeURL = TRUE, removeTwitter=TRUE, ngrams=5, ignoredFeatures = naughtyWords)
myDfm5<-sort(myDfm5, margin="both")
saveRDS(myDfm5, file = "pentagrams.rds")

if (require(RColorBrewer))
  plot(myDfm5, max.words=30, colors = brewer.pal(7, "Set1"))


## Do a search for "of_the" in myDfm2 (in one of the corpus documents)
myDfm2[1,"of_the"]

sum(as.matrix(myDfm2)[,"of_the"]) #2239
topfeatures(myDfm2) #of_the =2239

# Matrix calculation of the word "love"
testy<-as.matrix(myDfm)
testy[,"the"]
testy[,"love"]
sum(testy[,"love"])
