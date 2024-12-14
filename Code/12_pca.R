# FIRST TYPE OF NOTES

# PCA
# see picture taken of the blackboard

library(imageRy)
library(terra)
im.list()

sent <- im.import("sentinel.png")

pairs(sent) 

# to see the correlation amongst all of the bands (of sentinel image)
# we can call these systems and compact them in one pca

sentpc <- im.pca(sent) 

# there is the variability explained by the principal component

plot(sentpc) # because the sentpc is the principal component

# the first pc is that with highest variability (might explain 80% of the variability)
sentpc
pc1 <- sentpc[[1]]
pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)

# SECOND TYPE
#12/12 
#PCA 

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent)

# perform PCA on sent
sentpc <- im.pca(sent) 
sentpc

pc1 <- sentpc[[1]]
pc1

pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)


# calculating standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

# stack all the standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)
