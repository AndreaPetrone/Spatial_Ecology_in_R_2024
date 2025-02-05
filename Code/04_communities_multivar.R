# Code for multivariate analysis of species x plot data in communities

# we are at population levels and individuals of the same species
# communities: different individuals from different species

# PCA is one of multivariate analysis and helps to pass from a system made of multidimensions to one made by 2 dimensions
# and from 2 dimensions to 1 dimension

# package used: vegan (vegetation analysis)

install.packages("vegan") 
library(vegan) 
data(dune) 
dune # all the species and all the plots

# "head" shows only the first 6 lines to restrict the dataset

head(dune)
View(dune)

# decorana means detrended correspondence analysis
# it's a PCA powerful when we have range of data quite disperse 
# the function compacts everything.

decorana(dune) 
multivar <- decorana(dune) 

# we see the length of four axis
# the length is the amount of range represented from the axis

dca1 = 3.7004
dca2 = 3.1166
dca3 = 1.30055
dca4 = 1.47888

# we can calculate the percentage of each axies compared to the all system

total = dca1+dca2+dca3+dca4
total = 9.59643

# to make the percentage we divide (dca1 / total) x 100
# proportions

prop1 = dca1/total
prop2 = dca2/total
prop3 = dca3/total
prop4 = dca4/total

# now we calculate percentages

perc1 = prop1*100
perc2 = prop2*100
perc3 = prop3*100
perc4 = prop4*100

perc1
[1] 38.56017

perc2
[1] 32.47666

perc3
[1] 13.55244

perc4
[1] 15.41073

# now to have the information about the whole amount of variability in percentage 

perc1+perc2 # = 71.03683

# the first two axes explain 71% of the variability 

plot(multivar)  
