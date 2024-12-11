# time to import stuff 
# go to site earth observatory, home, search for image, scotland, click on scotland and download (jpeg), save it (right click)
# in the code we are explaining to R that we are going to use the photo, setting the working folder
# right click on the file where u put it, see properties, copy the path and paste it in the code, the path we see in the properties has back slash "\", the real path is with "//" and we have to change all the slashes and remember the quotes "" 
setwd("C:/Users/Utente/Desktop/SPATIAL ECOLOGY")
library(terra)
#let's use the function getwd (getworkingdirectory)
getwd() # vuoto per vedere se ha dato la giusta directory
scotland <- rast ("scotland_outerhebrides_oli_20240918_lrg.jpg") #name of the file from download
plotRGB (scotland, r=1, g=2, b=3) # it gives the original image with r=1 etc
plot(scotland) # same of plotRGB to see the picture on R
# in 09_external_data_available.md of Duccio we can find sites to look for data
# exercise: download a set of the Earth Observatory and upload it in R
# any ecological process is ok
setwd("C:/Users/Utente/Desktop/SPATIAL ECOLOGY")
milioni <- rast("Immagine 2024-12-11 154343.jpg")
plot(milioni)
setwd("C:/Users/Utente/Desktop/SPATIAL ECOLOGY")
benito <- rast("Benito_Mussolini_colored.jpg")
plot(benito)
for exam: 2 images of the same place in 2 different times
