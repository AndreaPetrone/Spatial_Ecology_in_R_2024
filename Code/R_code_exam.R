# R project focussing on temporal analysis of Farmer-Managed Natural Regeneration (FMNR) by The Great Green Wall project in Maradi city, Africa.

# Install the following packages using the install.packages() function. The packages should be enclosed in quotation marks.
install.packages(c("terra","ggplot2","patchwork","viridis","rasterdiv","devtools","RColorBrewer")

# Install imageRy from GitHub
install_github("ducciorocchini/imageRy")

# Recall all the packages with the function library(), no quotation marks are needed now.
library(terra) # Used for handling spatial data, particularly raster and vector data (e.g. satellite images)
library(ggplot2) # Used for the creation of graphs
library(patchwork) # Used for combining multiple graphs into a single plot
library(viridis) # Used for color palettes that are uniform and colorblind-friendly
library(devtools) # Used for developing, installing, and managing R packages
library(imageRy) # Used for handling raster images
library(RColorBrewer) # Used for creating color palettes, specially for data visualisation

# Function setwd() used to set the correct directory, it is needed to import images from you files
setwd("C:/Users/Utente/Desktop/spatial ecology")

# Function used to see if the directory is correct
getwd()
"C:/Users/Utente/Desktop/spatial ecology"

# Now let's import all the images of Maradi city from 2017 and 2024 downloaded from Copernicus Sentinel 2, assign them to objects and plot them 
# The function used is rast() and it comes from the package "terra"

maradiTC17<-rast("tc251017.jpg")
maradiTC17<-flip(maradiTC17) # TC = True Color (bands R, G and B) 2017
plot(maradiTC17)

maradiFC17 <-rast("fc251017.jpg") # FC = False Color (bands NIR, G and B) 2017
maradiFC17 <-flip(maradiFC17)
plot(maradiFC17)

maradiTC24 <-rast("tc231024.jpg") 
maradiTC24 <-flip(maradiTC24)
plot(maradiTC24)

maradiFC24 <-rast("fc231024.jpg") 
maradiFC24 <-flip(maradiFC24)
plot(maradiFC24)

# With the function par(mfro=c(2,2)) we put multiple plots in a single plotting window made of 2 rows and 2 columns
par(mfrow=c(2,2))
plot(maradiTC17,main="True color 2017")
plot(maradiFC17,main="False color 2017")
plot(maradiTC24,main="True color 2024")
plot(maradiFC24,main="False color 2024")

dev.off()

# To classify the objects and extract most of the information, we need to combine the bands from the True Color and NIR from False Color images for the year 2017
# Before, we assign to their relative objects the red, green, blue and nir bands 

bmR17<-maradiTC17[[1]] # Red band 
bmG17<-maradiTC17[[2]] # Green band
bmB17<-maradiTC17[[3]] # Blue band
bmI17<-maradiFC17[[1]] # NIR band 
bm17<-c(bmR17,bmG17, bmB17,bmI17) # Putting all the bands together in one object 

# We can classify this image and we specify the number of classes (or clusters) and we plot to see the result  
Cbm17<-im.classify(bm17, num_clusters=2)
plot(Cbm17)

# We do the same thing for the year 2024

bmR24<-maradiTC24[[1]]
bmG24<-maradiTC24[[2]]
bmB24<-maradiTC24[[3]]
bmI24<-maradiFC24[[1]]
bm24<-c(bmR24,bmG24, bmB24,bmI24)

# Classify for the year 2024 
Cbm24<-im.classify(bm24, num_clusters=2)
plot(Cbm24)

# We use the function par(mfrow=c(2,2) to see the plots resulted from the classification in 2017 and 2024 in a single plotting window
# Using the viridis palette we can ensure a functional vision of the graphs for colorblind people

# Define colors for two classes
cl <- colorRampPalette(c("forestgreen","palegoldenrod")) (100) 

par(mfrow=c(2,2))
plot(Cbm17,col=cl, main="2017")
plot(Cbm17,col= viridis(2), main="2017 colorblind") # This generates two colorblind-friendly colors
plot(Cbm24,col=cl, main="2024")
plot(Cbm24,col= viridis(2), main="2024 colorblind")

dev.off()

# "Playing" with bands can be useful to see different things 
im.plotRGB(bm17,r=4,g=2,b=3) # NIR on red -> enhancing vegetation features
im.plotRGB(bm17,r=1,g=4,b=3) # NIR on green -> focusing on vegetation health
im.plotRGB(bm17,r=1,g=2,b=4) # NIR on blue -> emphasizing surface reflectance properties

im.plotRGB(bm24,r=4,g=2,b=3) 
im.plotRGB(bm24,r=1,g=4,b=3)
im.plotRGB(bm24,r=1,g=2,b=4)

# Calculate the amount of pixels (frequencies) with freq() function using the combined bands and get the percentage of each class 
f17 <- freq(Cbm17)
tot17 <- ncell(Cbm17)  # Total cells in the raster
p17 = f17*100/tot17
p17
# Class 1 Restored land = 33%
# Class 2 City and deserted areas = 67%

f24 <- freq(Cbm24) 
tot24 <- ncell(Cbm24)
p24 = f24*100/tot24
p24
# Class 1 Restored land = 36%
# Class 2 City and deserted areas = 64%

# We can see from the results that the restored land is increased by 3% 

# Building a dataframe allows us to see the classes and their percentages for 2017 and 2024
# First, we assign the percentages of each year to the object (the year), we assign the names of the classes to the other object (classes) and we create the dataframe with the function data.frame
y2017 <- c(33,67)
y2024 <- c(36,64)
classes <- c("Restored land", "City and deserted areas")
dataM <- data.frame(classes,y2017,y2024)
dataM

# We can plot the graphs using the function ggplot from the package ggplot2

M1 <- ggplot(dataM, aes(x=classes, y=y2017, fill=classes, color=classes)) + geom_bar(stat="identity") + scale_fill_manual(values=c("Restored land"="forestgreen", "City and deserted areas"="palegoldenrod")) + scale_color_manual(values=c("Restored land"="forestgreen", "City and deserted areas"="palegoldenrod")) + ylim(c(0, 100))

M2 <- ggplot(dataM, aes(x=classes, y=y2024, fill=classes, color=classes)) + geom_bar(stat="identity") + scale_fill_manual(values=c("Restored land"="forestgreen", "City and deserted areas"="palegoldenrod")) + scale_color_manual(values=c("Restored land"="forestgreen", "City and deserted areas"="palegoldenrod")) + ylim(c(0, 100))

# ggplot: initializes the plot with dataM as the dataset
# aes: for aesthetic of the plot
# x=classes: Categories for the x-axis
# y=y2017: values for the y-axis
# fill=classes: fills bars based on the class
# color=classes: colors the border of bars based on the class
# geom_bar(): adds a bar plot layer
# stat="identity": uses actual values from y2017 and 2024 
# scale_fill_manual(): manually assigns colors to the bars based on classM
# scale_color_manual(): manually assigns border colors for the bars
# the choiche of colors reflect those used in classification for coherence
# ylim(c(0, 100)): sets the y-axis range from 0 to 100.

# We combine the graph of the two years together, with "+" we see them close to each other, with the "/" we see them on top of each other
M1+M2
M1/M2

# We create the same graphs but this time for colorblind 

M1cb <- ggplot(dataM, aes(x=classes, y=y2024, fill=classes, color=classes)) + geom_bar(stat="identity") + scale_fill_viridis_d(option="D") + scale_color_viridis_d(option="D") +  ylim(c(0, 100))

M2cb <- ggplot(dataM, aes(x=classes, y=y2024, fill=classes, color=classes)) + geom_bar(stat="identity") + scale_fill_viridis_d(option="D") + scale_color_viridis_d(option="D") + ylim(c(0, 100))

# scale_fill_viridis_d(option="D"): "D" default for viridis, "_d" is for discrete variables like classes

M1cb+M2cb
M1cb/M2cb

# Now to really see what changed over the years in term of vegetation health and density, we're going to calculate the DVI (Difference Vegetation Index) and then the NDVI (Normalized Difference Vegetation Index)

cl1 <- colorRampPalette(c("blue", "grey", "palegoldenrod", "#228B22", "darkgreen"))(100) # To appreciate better the DVI and NDVI 

# The DVI is calculated this way: DVI = NIR - red -> We extrapolate the the NIR and red band 
# The formula refers to a pixel subtraction
# DVI for the year 2017 and 2024

dvi2017<-bm17[[4]]-bm17[[1]]
dvi2024<-bm24[[4]]-bm24[[1]]
par(mfrow=c(2,2))
plot(dvi2017,col=cl1, main="DVI 2017")
plot(dvi2017,col=viridis(100), main="DVI 2017 colorblind")
plot(dvi2024,col=cl1, main="DVI 2024")
plot(dvi2024,col=viridis(100), main="DVI 2024 colorblind")

dev.off()

# Now we calculate NDVI with this formula: dvi / (NIR + Red)

ndvi2017 = dvi2017/(bm17[[4]]+bm17[[1]])
plot(ndvi2017,col=cl1, main="NDVI 2017")
plot(ndvi2017,col=viridis(100), main="NDVI 2017 (colorblind)")

ndvi2024 = dvi2024/(bm24[[4]]+bm24[[1]])
plot(ndvi2024,col=cl1,main="NDVI 2024")
plot(ndvi2024,col=viridis(100), main="NDVI 2024 (colorblind)")

par(mfrow=c(2,2))
plot(ndvi2017,col=cl1, main="NDVI 2017")
plot(ndvi2017,col=viridis(100), main="NDVI 2017 (colorblind)")
plot(ndvi2024,col=cl1, main="NDVI 2024")
plot(ndvi2024,col=viridis(100), main="NDVI 2024 (colorblind)")

dev.off()

# Now we want to see the differences in NDVIs 
# Positive values (> 0) are areas where NDVI increased from 2017 to 2024
# Negative values (< 0) are areas where NDVI decreased from 2017 to 2024

Difndvi=ndvi2024-ndvi2017
par(mfrow=c(1,2))
plot(Difndvi,col=cl1, main="NDVI difference")
plot(Difndvi,col=viridis(100), main="NDVI difference colorblind")

# To observe the results in a better way, we can create a histogram with the function hist

par(mfrow=c(1,2))
ist17 <- hist(ndvi2017, main="NDVI 2017", xlab="NDVI", nclass=20, freq=F, ylim=c(0,5), col=brewer.pal(9, "Greens"))
ist24 <- hist(ndvi2024, main="NDVI 2024", xlab="NDVI", nclass=20, freq=F, ylim=c(0,5), col=brewer.pal(9, "Greens"))  

# histogram for colorblind people 

par(mfrow=c(1,2))
ist17 <- hist(ndvi2017, main="NDVI 2017 colorblind", xlab="NDVI", nclass=20, freq=F, ylim=c(0,5), col=viridis(5))
ist24 <- hist(ndvi2024, main="NDVI 2024 colorblind", xlab="NDVI", nclass=20, freq=F, ylim=c(0,5), col=viridis(5))

dev.off()

# hist: create a histogram
# main: sets the title
# xlab: sets the x-axis label 
# nclass: Defines the number of intervals (more intervals = more granularity)
# freq=FALSE (F): shows the normalised values in form of density to make comparisons 
# ylim=c(0,5): limits the y-axis to a range of 0 to 5
# col=brewer.pal(9, "Greens"): uses RColorBrewer to generate 9 shades of green from the "Greens" palette.

# The 2024 histogram suggests a slight shift of NDVI values towards the positive, indicating a possible improvement in vegetation or a change in environmental conditions compared to 2017

# Now we do PCA Analysis for spatial variability
# Function used is im.pca and we start with the year 2017

pca17 <- im.pca(bm17)

# pca1 = 38.966791
# pca2 = 24.927165
# pca3 = 7.061764
# pca4 = 3.160646

# I sum the main components of the 4 bands, one principal component for each band, then calculate the percentage of variability explained by the axes

tot17pca <- sum(38.966791, 24.927165, 7.061764, 3.160646)

38.966791*100/tot17pca # 52.575151 variability explained by the first axis
24.927165*100/tot17pca # 33.632471 variability explained by the second axis
7.061764*100/tot17pca # 9.527942 variability explained by the third axis
3.160646*100/tot17pca # 4.264437 variability explained by the fourth axis

# We combine the PCA1 and PCA2 together because they explain 86% of the total variability
pc17c <- pca17[[1]] + pca17[[2]]
pcsd17 <- focal(pc17c, matrix(1/9,3,3),fun=sd)

# focal() is a function that applies a local function to each pixel in a raster
# matrix(1/9, 3, 3) creates a 3x3 matrix where each element is 1/9
# fun=sd specifies the standard deviation applied to each pixel

# We do the same processes for the year 2024

pca24 <- im.pca(bm24)

# pca1 = 49.521251
# pca2 = 30.357348
# pca3 = 7.712667
# pca4 = 3.188850

tot24pca <- sum(49.521251, 30.357348, 7.712667, 3.188850)

49.521251*100/tot24pca # 54.55077 variability explained by the first axis
30.357348*100/tot24pca # 33.44053 variability explained by the second axis
7.712667*100/tot24pca # 8.495987 variability explained by the third axis
3.188850*100/tot24pca # 3.512719 variability explained by the fourth axis

pc24c <- pca24[[1]] + pca24[[2]] # 88% of variability explained
pcsd24 <- focal(pc24c, matrix(1/9,3,3),fun=sd)

# Now we can see the results in a multiframe
# There are some appreciable differences
par(mfrow=c(1,2))
plot(pcsd17, col=viridis(100), main="Spatial variation 2017")
plot(pcsd24, col=viridis(100), main="Spatial variation 2024")
