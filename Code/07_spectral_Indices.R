library(imageRy)
library(terra)

# listing the data

im.list()

# we are importing directly a stack of different bands with "matogrosso_ast_2006209_lrg.jpg"

im.import("matogrosso_ast_2006209_lrg.jpg") 

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m2006 # in section name we can see there are 3 bands (matogrosso_lrg1/2/3)

# band 1 = NIR, band 2 = red, band 3 = green
# RGB of matogrosso image

im.plotRGB(m2006, r = 1, g = 2, b = 3) # the important thing is that r=1

# how to see a specific band

plot(m2006[[2]])
plot(m2006[[3]])

# back to RGB

im.plotRGB(m2006, r = 1, g = 2, b = 3) # we can see what happens in the image, it was all covered by forest

# once u put NIR on top of blue everything becomes yellow, all the bare soil

im.plotRGB(m2006, r = 3, g = 2, b = 1) 
im.plotRGB(m2006, r = 3, g = 1, b = 2) #veg becomes green

# let's import image from 1992 to understand situation before intervention of humans

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# plot the data using NIR on top 

im.plotRGB(m1992, r = 1, g = 2, b = 3)

# build a multiframe with 1992 and 2006 images

par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# exercise: make a multiframe with 6 images in pairs with nir on the same component
# first row: m1992 and m2006 with r= 1
# second row: m1992 and m2006 with g= 1
# third row: m1992 and m2006 with b= 1
# 3 rows per 2 columns -> the important point as requested from the exercise is where you put the number 1 

par(mfrow=c(3,2))
im.plotRGB(m1992, r=1,g=2, b=3)
im.plotRGB(m2006, r=1,g=2, b=3)
im.plotRGB(m1992, r=2,g=1, b=3)
im.plotRGB(m2006, r=2,g=1, b=3)
im.plotRGB(m1992, r=2,g=3, b=1)
im.plotRGB(m2006, r=2,g=3, b=1)

# VEGETATION INDICES 
# in case of healthy plants: reflects in NIR 100, red 10, we can mount this information to make a single index DVI (different vegetation index)
# DVI = NIR - red = 100-10 = 90 (DVI of the plant)
# with two images u can calculate different DVIs

# calculate DVI of 1992 and DVI o 2006
# different vegetation index 1992

dvi1992 = m1992[[1]] - m1992[[2]] # the 1 is the NIR and the 2 is the red (band 1 = NIR, band 2=red, band 3=green)
cl <- colorRampPalette(c("darkblue","yellow","red","black")) (100)
plot(dvi1992, col=cl) 

# let's see the same for 2006

dvi2006=m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)

# now plot in a mf

par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# NDVI = normalize different vegetation index = same of DVI (NIR - RED) but also in denominator puts NIR+red
# with NDVI you can compare every image from different ranges
# NDVI > DVI, but if you have images from the same range you can use DVI

# calcualte NDVI 1992 and 2006

ndvi1992 = dvi1992 / (m1992[[1]]+m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]]+m2006[[2]])
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# u can use viridis for colorblind people
plot(ndvi1992,col=magma(100))
plot(ndvi2006,col=magma(100))
plot(ndvi1992,col=inferno(100))
plot(ndvi2006,col=inferno(100))
plot(ndvi1992,col=cividis(100))
plot(ndvi2006,col=cividis(100))
