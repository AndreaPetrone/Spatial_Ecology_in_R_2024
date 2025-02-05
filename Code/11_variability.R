# script to measure variability
# the higher the variability the higher the complexity of the system
# the higher variability will lead to have several species living in a certain place

# how to measure variability: rasterdiv

install.packages("rasterdiv")

# measure the difference between every single data in the mean
# measure how much every person is out of the standard deviation (measure the outlier)
# the higher the amount of outliers in the sample, the higher the variability

library(imageRy)
library(viridis)
library(terra)
im.list()

sent <- im.import("sentinel.png") # there are 3 bands (+ one that we not consider)

# band 1 = NIR (near infra red) (the vegetation became red)
# band 2 = red
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)

# green is ground
# dark red are woodlands
# blue part is bare rock

im.plotRGB(sent, r=2, g=1, b=3) # we can change colors associated to the bands
im.plotRGB(sent, r=2, g=3, b=1) # yellow helps us to search info
dev.off()

# we use the NIR (it is our choice)
# measuring standard deviation, we use a function called focal

nir <- sent[[1]] # the NIR is the first one in sent

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) 

# 9 pixels in a moving window, 3 rows and 3 columns 
# fun=sd explains the function we want to use which is standard deviation

plot(sd3) 

# we can detect areas of highest morphological variability in the image, which is north-west, where there was rocks

# Exercise: calculate standard deviation in a 7x7 pixels (moving window)

sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)

# we can also plot sd3 and sd7 together
par(mfrow=c(1,2))
plot(sd3)
plot(sd7) # wider regions with higher standard 

# original image with the 7x7 sd
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7)
