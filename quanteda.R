library(quanteda)
tf <- textfile("*.txt", cache=FALSE)


# Make a dfm (document feature matrix)
# Converts to lower case and removes numbers, separators, punctuation by default.
# Also remove Twitter and perform profanity filtering (word list courtesy of http://www.bannedwordlist.com)

naughtyFile<- file("swearwords", "r") 
naughtyWords = readLines(naughtyFile)
close(naughtyFile)

myDfm <- dfm(corpus(tf),removeTwitter=TRUE, ngrams=1, ignoredFeatures = naughtyWords)

#Word cloud of the top 100 words
if (require(RColorBrewer))
  plot(myDfm, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
barplot(topfeatures(myDfm, 75), horiz=TRUE, cex.names=0.7,las=2, xaxt = "n", lwd = 7, main = "Top 75 unigrams")

#Now ngrams=2
myDfm2 <- dfm(corpus(tf),removeTwitter=TRUE, ngrams=2, ignoredFeatures = naughtyWords)
if (require(RColorBrewer))
  plot(myDfm2, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
barplot(topfeatures(myDfm2, 75), horiz=TRUE, cex.names=0.7,las=2, xaxt = "n", lwd = 7, main = "Top 75 bigrams")

#Now ngrams=3
myDfm3 <- dfm(corpus(tf),removeTwitter=TRUE, ngrams=3, ignoredFeatures = naughtyWords)

if (require(RColorBrewer))
  plot(myDfm3, max.words=75, colors = brewer.pal(7, "Set1"))

#Bar plot
par(mar=c(5,8,4,2)) # increase y-axis margin.
barplot(topfeatures(myDfm3, 75), horiz=TRUE, cex.names=0.8,las=2, xaxt = "n", lwd = 7, main = "Top 75 trigrams")


