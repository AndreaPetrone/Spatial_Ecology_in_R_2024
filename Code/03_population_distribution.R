# POPULATION DISTRIBUTION IN R - Why populations disperse over time in a landscape in a certain way
# add additional package "terra" and "sdm"

install.packages("sdm") #species distribution modelling

# look for teacher's papers in "paper" on his github

# in each pixel you have a probability to find the species --> species distribution modelling
install.packages("terra")

# how to make a subset of a data, to select only some points
# we installed sdm and terra; 

file <- system.file("external/species.shp", package="sdm")

# in sdm folder there is another file called "external"  and in it there are some data we're gonna use today -> using system.file it finds the name of the file
#system file selects a specific file from another

system.file("external") #system file selects a specific file from another

# species.shp is related to data for species, shp means "shapefile" that is a type of file originally from a company. species is inside external

file <- system.file("external/species.shp", package = "sdm") #species inside external with "/" and we specify the package "sdm"

# to see what's inside 
file 

# gather type is ruster that is image, vector is made of points (coordinates), let's use the data with a function to traslate shp to type of file that R can use
# spatvector is the one R can use, the function is called vect 

rana <- vect(file) # file is the object we named before instead of writing system.file etc...

# the information we find: first says it is a spatvector, second: type of file (points), third: extent, then source, coordinates: wgs84, utm zone 30N, EPSG (code used for every single coordinate system), names: for each point there's a data recorded, occurance or not of a certain species, so if the species is present (1) or not (0) we write the numbers in each point 

#now let's plot this data
rana$Occurrence 
plot(data) 

#in this file some points represent the presence of the species (occurance = 1) and other the absence (occurance = 0), now we select the data where there is the species (occurence = 1)

# select all the points from rana where occurence = 1, in sequel equal is written with two ==, in sequel all finishes with ";".

pres <- rana[rana$Occurrence==1] #press is the name, from rana we select occurence ==1
pres 

# we see only 1 
pres$Occurrence  

# now we want to see rana and pres in a multiframe (par is just for the multiframe)
par(mfrow=c(1,2))
plot(rana)
plot(pres)

# sequel is not a function, is a language where we select only the data in which the occurrence ==1
# exercise: select data from rana with only absences 

abse <- rana[rana$Occurrence==0]
abse
abse$Occurrence #the datas with absences it's not said that the animal is not there, maybe the observer did not see it (obersver bias)

# we use dev.off to destroy the multiframe we created before and then we write plot(abse)

plot abse

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

# so we need to use points or it will be rewrited, we can modify the dimension of character 

points(pres, col="blue", pch=19, cex=2) 
points(abse, col="red", pch=19, cex=2)

# covariates are datas in raster form to understand ecological parameters, why the species is distributed in a certain way 

elev <- file <- system.file("external/elevation.asc", package = "sdm") #we use .asc because it refers to rast 
elev

# now we want to see the map of elevation

elevmap <- rast (elev)
elevmap
plot(elevmap)

#exercise: change the colors of the elevation map by the colorRampPalette function

Cl <- colorRampPalette(c(col="olivedrab", col="olivedrab1", col="orange"))
plot(elevmap, col = cl) #so first we assign to Cl the colorRampPalette, the group of colors we want to use, then we put everything together in the plot function

# exercise: plot the presences together with elevation map

plot(elevmap, col = cl)
points(pres, pch=19)

# no need for parmf etc because we put points on a plot made of a map (rast file), i punti sopra la mappa, quindi non separati ma uno sopra l'altro

