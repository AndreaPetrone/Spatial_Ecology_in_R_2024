library(imageRy)
library(terra)
#listing the data
im.list()
# we are importing directly a stack of different bands with "matogrosso_ast_2006209_lrg.jpg"
im.import("matogrosso_ast_2006209_lrg.jpg") #ast is a satellite ASTER DATA
#let's give it a name
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m2006 # in section name we can see there are 3 bands (matogrosso_lrg1/2/3)
# band 1 = NIR, band 2 = red, band 3 = green
# we can do RGB of matogrosso image
> im.plotRGB(m2006, r = 1, g = 2, b = 3) # we can choose the band we want to see, even if we write here g=3 and b=2 nothing changes, the important thing is that r=1
# how to see a specific band
> plot(m2006[[2]])
> plot(m2006[[3]])
# back to RGB
> im.plotRGB(m2006, r = 1, g = 2, b = 3) # we can see what happens in the image, it was all covered by forest. zooming and seeing rectangular shapes is because of human impacts
# once u put NIR on top of blue everything becomes yellow, all the bare soil
im.plotRGB(m2006, r = 3, g = 2, b = 1) 
im.plotRGB(m2006, r = 3, g = 1, b = 2) #veg becomes green
# let's import image from 1992 to understand situation before intervention of humans. 
> m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
# plot the data using NIR on top 
> im.plotRGB(m1992, r = 1, g = 2, b = 3)
# build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

