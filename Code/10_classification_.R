# We will do classification today and import data
# Pixel from image and see the reflectance -> teacher took 3 pixels and saw that they are related to each other and made the same thing with other pixels. it is useful to understand the class of the object (one pixel is snow, other is wood etc) -> this is classification (class = object of pixel (wood, plants, grassland, snow etc).

#Once you know the class you have a map of all the pixel that are part of the classes, you can calculate the amount of pixels per class.

# We can go to a site, download an image, import to R and work on it

# Classification proess in R using imageRy 

library(terra)
library(imageRy)
im.list()
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") 

# We can classify this image and we specify the number of classes (or clusters)   

sunc <- im.classify(sun, num_clusters=3)  #we said to find 3 best classes, but the number of the classes (clusters, labels), might be different.

# Let's use the same concept for matogrosso area to see forest vs non forest areas
# Matogrosso example
# Import the image from 1992  

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")  

# Some parts are destroyes and the white line is the river

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg") # we see the agriculture areas

# Let's start with the classification

m1992c <- im.classify(m1992, num_clusters=2) #2 bc it's forest vs no-forest, "c" in the name represents classify

# Class 1 = forest / class 2 = human related areas and water 
# Same for 2006

m2006c <- im.classify(m2006, num_clusters=2) 

# here class 1 = human related areas and water /class 2 = forest

# calculate the amount of pixels
# frequencies (number of pixels)

f1992 <- freq(m1992c) 

# let's calculate % -> number divided by the total and multiplied by 100
# we need the total

tot1992 <- ncell(m1992c)
tot1992
p1992 = f1992 * 100 / tot1992   
p1992 # we see in count, class 1 = forest = 83%, class 2 = human = 17%

# same for 2006
f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 = f2006 * 100 / tot2006

# class 1 = forest = 45%, class 2 = human = 54%

# building a dataframe

class <- c("Forest","Human") # put in "" bc they are text, each "" for each word and "c" to concatenate them 
y1992 <- c(83, 17)
y2006 <- c(45, 55)

# we have 3 separate columns, we can clump in a dataframe everything

tabout <- data.frame(class, y1992, y2006)   
tabout

# we need a package ggplot2, aes = aestethic, related to what u put in X, Y and final colour, geom = what type of graph u want to put in it, stat = type of statistic u want to use (we want just to use the data), fill = is the colour

# final graph

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill ="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill ="white")

# use another package "patchwork" that composes graphs

install.packages("patchwork")
library(patchwork)

# we assign to an object p1 and p2 (already done)

p1 + p2

# we need to fix the scale from 0 to 100 in Y (we used number in the Y)

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
p1 / p2 # to have them on top of the other 

# we start with image, calcualte spectral image, see the difference between image, classify them, have idea of change in time and space                                                                                                                                                                                                                                                                    
