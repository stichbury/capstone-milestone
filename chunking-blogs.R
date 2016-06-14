#Code to download and unzip data omitted

con <- file("en_US.blogs.txt", "r") 
# linesRead<-0
# # How many lines in the file?
# while ( TRUE ) {
#   line = readLines(con, n = 1)
#   if (length(line) == 0 ) {break}
#   else {linesRead<-linesRead+1}
# }

linesRead<-899288 # Should be 899288

# Split the file into 2 pieces approx 1:200
set.seed(12345) # Sets the seed for reproducibility
filesplit<-rbinom(n=linesRead, size=1, prob=0.005)

linesRead<-0
linesSaved<-0
chunk <- character()

# Read the file, and store lines that == 1 in filesplit
while ( TRUE ) {
  line = readLines(con, n = 1)
  if (length(line) == 0 ) {break} #EOF
  else {
    linesRead<-linesRead+1
    if (filesplit[linesRead]==1) # Save any lines that are a 1 in filesplit into the chunk file
      {
      linesSaved<-linesSaved+1
      chunk[linesSaved]=line
      }
    }
  }

close(con)

chunkcon<-file("en_US.blogs-0.005.txt")
writeLines(chunk, chunkcon)
close(chunkcon)

