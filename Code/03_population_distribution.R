# POPULATION DISTRIBUTION IN R - Why populations disperse over time in a landscape in a certain way
# add additional package "terra" and "sdm"

install.packages("sdm") #species distribution modelling -> in each pixel you have a probability to find the species

install.packages("terra")

file <- system.file("external/species.shp", package="sdm")

# in sdm folder there is another file called "external"  
# using system.file it finds the name of the file -> selects a specific file from another

system.file("external") 

# species.shp is related to data for species
# species is inside external

file <- system.file("external/species.shp", package = "sdm") #species inside external with "/" and we specify the package "sdm"

# to see what's inside 
file 

# gather type is ruster that is image, vector is made of points (coordinates), let's use the data with a function to traslate shp to type of file that R can use
# spatvector is the one R can use, the function is called vect 

rana <- vect(file) 

#now let's plot this data

rana$Occurrence 
plot(rana) 

# in this file some points represent the presence of the species (occurance = 1) and other the absence (occurance = 0)
# now we select the data where there is the species 
# in sequel equal is written with two ==, in sequel all finishes with ";".

pres <- rana[rana$Occurrence==1] 
pres 

# we see only 1 
pres$Occurrence  

# now we want to see rana and pres in a multiframe (par is just for the multiframe)
par(mfrow=c(1,2))
plot(rana)
plot(pres)

# exercise: select data from rana with only absences 

abse <- rana[rana$Occurrence==0]
abse
abse$Occurrence # the datas with absences it's not said that the animal is not there, maybe the observer did not see it (obersver bias)

# we use dev.off to destroy the multiframe we created before and then we write plot(abse)

plot (abse)

# exercise: plot in a multiframe presences beside absences 

par(mfrow=c(1,2))
plot(pres)
plot(abse)

# exercise: plot in a multiframe presences on top of absences

par(mfrow=c(2,1))
plot(pres)
plot(abse)

# now let's plot all together; 
# exercise: plot the presences in blue together with absences in red

plot(pres, col="blue")
points(abse, col="red")

# we can modify the dimension of character 

points(pres, col="blue", pch=19, cex=2) 
points(abse, col="red", pch=19, cex=2)

# covariates are datas in raster form to understand ecological parameters

elev <- file <- system.file("external/elevation.asc", package = "sdm") # we use .asc because it refers to rast 
elev

# now we want to see the map of elevation

elevmap <- rast (elev)
elevmap
plot(elevmap)

# exercise: change the colors of the elevation map by the colorRampPalette function

Cl <- colorRampPalette(c(col="olivedrab", col="olivedrab1", col="orange"))
plot(elevmap, col = cl)

# exercise: plot the presences together with elevation map

plot(elevmap, col = cl)
points(pres, pch=19)

# no need for parmf etc because we put points on a plot made of a map (rast file)

