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

#prima ha assegnato a cl quel pattern di colori e poi l'ha visualizzato
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

#qua il contrario di prima, prima stabilisci le regole in cui ordinarli, e poi in base a chi scrivi prima si sistemano
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



