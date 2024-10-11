# load require packages
library(spatstat)
library(tidyverse)

# obtain gold deposit
gold <- murchison$gold
class(gold)
# obtain greenstone outcrop
greenstone <- murchison$greenstone
class(greenstone)
# obtain faults
faults <- murchison$faults
class(faults)
# obtain the window object
W <- Window(gold)
# plot gold deposits, greenstone outcrop, and faults
par(mfrow = c(1, 3), mar = c(5, 5, 4, 1))
plot(gold, pch = "+", cols = "blue", main = "Gold deposits")
plot(faults, col = "brown", main = "Fault lines")
plot(greenstone, col = "lightgreen", main = "Greenstone")
plot(W, add = TRUE)

# let's try harmonize to the three objects
mur_harmonise <- with(mur, 
                      harmonise(X = pixellate(gold, dimyx = 128) > 0,
                                D = distfun(faults),
                                G = greenstone))
class(mur_harmonise)
names(mur_harmonise) <- c("Gold deposit", "Distance to nearest fault", "Greenstone")

plot(mur_harmonise, main = "")

sapply(mur_harmonise, class) # these are all images

# we can use use pairs.im() to convert these images into data frames
mur_pairs_im <- pairs.im(mur_harmonise, plot = FALSE)
mur_df <- as.data.frame(mur_pairs_im)
# summary of mur_df
summary(mur_df)








