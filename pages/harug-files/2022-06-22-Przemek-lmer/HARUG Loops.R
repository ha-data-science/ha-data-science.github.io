#
# HARUG script 
# 15 June 2022
# Execution speed in loops

library(microbenchmark)

# Define the function colspace_F -----------------------------------------------
colspace_F <- function(n, ColourPalette){
  rnb <- hcl.colors(n, palette = ColourPalette) # hcl.colors() is a base R function; outputs a vector of n colours in hex notation
  ind <- 0:(n-1)
  re <- rep(0, n)
  gr <- re
  bl <- re
  clsp <- data.frame(re, gr, bl)
  for (i in 1:n) {
    color <- rnb[i]
    hex_splitted_color <- c(paste('0x', substr(color, 2, 3), sep = ''),
                            paste('0x', substr(color, 4, 5), sep = ''),
                            paste('0x', substr(color, 6, 7), sep = ''))
    clsp[i, 1:3] <- strtoi(hex_splitted_color)
  }
  clsp <- cbind(clsp, ind)
  return(clsp)
}

# Example of an output from colspace_F
colspace_example <- colspace_F(16, "Spectral")
#write.csv(colspace_example, "colspace_example.csv", row.names = F)


# Define the function remap in four versions -----------------------------------
# 1a. matrix, looping along the vector to map
remap_1a <- function(va, ...){
  colspace <- colspace_F(...)
  
  l <- length(va)
  vare <- rep(0, l)
  vagr <- rep(0, l)
  vabl <- rep(0, l)
  mva <- data.frame(vare, vagr, vabl)
  for(i in 1:length(va)) {
    j <- which(colspace$ind==va[i])
    mva[i,] <- colspace[j,1:3]
  }
  return(mva)
}

# 1b. vectors, looping along the vector to map
remap_1b <- function(va, ...){
  colspace <- colspace_F(...)
  
  l <- length(va)
  vare <- rep(0, l)
  vagr <- rep(0, l)
  vabl <- rep(0, l)
  for(i in 1:length(va)) {
    j <- which(colspace$ind==va[i])
    vare[i] <- colspace[j,1]
    vagr[i] <- colspace[j,2]
    vabl[i] <- colspace[j,3]
  }
  mva <- data.frame(vare, vagr, vabl)
  return(mva)
}

# 2a. matrix, looping along the colorspace table
remap_2a <- function(va, ...){
  colspace <- colspace_F(...)
  
  l <- length(va)
  vare <- rep(0, l)
  vagr <- rep(0, l)
  vabl <- rep(0, l)
  mva <- data.frame(vare, vagr, vabl)
  for(j in 1:nrow(colspace)) {
    i <- va==colspace[j,4]
    mva[i,] <- colspace[j,1:3]
  }
  return(mva)
}

# 2b. vectors, looping along the colorspace table
remap_2b <- function(va, ...){
  colspace <- colspace_F(...)
  
  l <- length(va)
  vare <- rep(0, l)
  vagr <- rep(0, l)
  vabl <- rep(0, l)
  for(j in 1:nrow(colspace)) {
    i <- va==colspace[j,4]
    vare[i] <- colspace[j,1]
    vagr[i] <- colspace[j,2]
    vabl[i] <- colspace[j,3]
  }
  mva <- data.frame(vare, vagr, vabl)
  return(mva)
}

# SPEED TEST -------------------------------------------------------------------
lv <- c(1e3, 1e4, 1e5, 1e6)
result <- data.frame("nc" = 16, "l" = lv, "t" = 0) # nc - number of colours, l - size of the test image, t - dummy vector for execution time 
result <- rbind(result, data.frame("nc" = 256, "l" = lv, "t" = 0))

for(k in 1:nrow(result)){
  cat("\nk: ", k)
  nc <- result$nc[k]
  im <- floor(runif(result$l[k], 0, nc-0.1)) # a "test image"
  m <- microbenchmark(remap_2b(im, n = nc, ColourPalette = "Spectral"), times = 1) # type in the demanded version of remap
  result$t[k] <- mean(m$time)/1e9
}
fln <- "remap_2b" # adjust here
write.csv(result, paste0(fln, ".csv"))
png(filename = paste0(fln, ".png"), width = 800, height = 600)
plot(y = result$t, x = log10(result$l), ylab = "time [s]", xlab = "log10(image_size)", main = fln)
dev.off()
