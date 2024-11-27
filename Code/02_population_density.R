# Code related to population ecology

# A package is needed for point pattern analysis
# install.packages("spatstat")
library(spatstat)

# let's use the bei data:
# data description:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data -> è un plot con cerchi neri e bianchi
plot(bei)

# changing dimension - cex -> puntini di 0.2 piccoli
plot(bei, cex=.2)

# changing the symbol - pch -> simbolo diverso
plot(bei, cex=.2, pch=19)

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev)
elevation <- bei.extra$elev -> così assegno bei.extra ad elevation
plot(elevation)

# second method to select elements
elevation2 <- bei.extra[[1]]
plot(elevation2)

# passing from points to a countinuous surface
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2) # ha aggiunto i puntini

# prima ha assegnato a cl quel pattern di colori e poi l'ha visualizzato
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl) 

cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)
plot(densitymap, col=cl)

clnew <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(densitymap, col=clnew)

plot(bei.extra)

elev <- bei.extra[[1]] # bei.extra$elev
plot(elev)  # ha ripreso elev

# multiframe
par(mfrow=c(1,2)) #crea una tabella con 1 riga e 2 colonne
plot(densitymap)
plot(elev)

# qua il contrario di prima, prima stabilisci le regole in cui ordinarli, e poi in base a chi scrivi prima si sistemano
par(mfrow=c(2,1)) 
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

# How to calculate the density of individuals in a population

# Installing the spatstat package
install.packages("spatstat")

# Recalling the package
library(spatstat)

# dataset, il data selezionato si chiama bei
bei

plot(bei)
plot(bei, pch=19)
plot(bei, pch=19, cex=.5)

bei.extra
plot(bei.extra)

# Extracting data
elevation <- bei.extra$elev #a elevation assegna elev con $ che è stato estratto da bei.extra
plot(elevation)

elevation <- bei.extra[[1]]

# Density map starting from points
densitymap <- density(bei)
densitymap

plot(densitymap)
points(bei, col="green")

day2
# everytime you open R and need spatstat re-write it calling library(spatstat)

# vignettes is used to explain some additional stuff of the package with figures etc (in the download part of the dataset)

# each point has coordinate X Y --> vector made by coordinates

bey
plot(bei) 

# a ruster is an image composed by pixels 

# let's pass from point to data, its the density of population over space and there are 2 groups of individuals clumped in the parts (lighter color)

densitymap <- density(bei) 

# in R to speed up the process we use up arrow to recall functions
points(bei) #not so cool so change colour --> points(bei, col="green")

# in bei extra in spatstat we find covariate

bei.extra # we need the file called elev from file bei.extra (è tutta la parte della scorsa lezione)
# or elevation2 <- bei.extra [[1]] 
# the second way is more powerful because i skip the name and just use the number

elevation2 <- bei.extra$elev 
elevation2<-bei.extra[[1]]
plot(elevation2)

# now what we want to do is to put in a multiframe more plots, in the one we make we have 1 row and 2 colons 
# in the par function we put the multiframe "mf" and row=1,2 (1 row 2 colons). 
# 1 and 2 are the dimensions of the multiframe and we use "c" to assign it to mf (multiframe)

par(mfrow=c(1,2))

# now in the first colon we put elevation2, so we do the multiframe first and then we put in it what we need

plot(elevation2)
plot(densitymap)

# inside the multiframe we have put elevation2 to left and density to the right, let's try to give some explanation 
# this are part of the landscape for trees (density) measure at the elevation (left), we can use one factor to understand the distribution of certain species
# in this case we can see the lower density is less matched with higher elevation

# exercise -> maps one on top of the other and not next to the other

par(mfrow=c(2,1))
plot(elevation2)
plot(densitymap)

# now image to turn back to the plot of the single image, to do that and to plot one map instead of two separates, we need a new friend
# the friend is "dev.off" that is controlling multiple devices, in our case is the plotting window
# let's go back to the original plot(s)

dev.off

# now we see only the plot of elevation2

plot(elevation2)

# changing colors to maps and when there is the capital letter attain to it
# 3 is the gradient

cl <- colorRampPalette(c("red","orange","yellow")) (3) 
plot(densitymap, col =cl) #now we see it modified

# let's increase the amount of gradients, instead of 3 we put 10 so in the colon we see the number of color gradients
# let's put 100
# in his code we see the link http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf or we can write "colors in r" on google and see the name of the codes

# exercise to change colors
# exercise: build a multiframe and plot the densitymap with two different color ramp palettes

par(mfrow=c(1,2))
cl<-colorRampPalette(c("forestgreen","darkolivegreen","green"))(50)
plot(densitymap,col =cl)
cl2<-colorRampPalette(c("darkmagenta","dodgerblue1","lightsalmon"))(50)
plot(elevation2,col =cl2)
# i chose shitty colors but it's ok

#to destroy the plot
dev.off() 

