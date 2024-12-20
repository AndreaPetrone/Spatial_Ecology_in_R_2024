# Code for multivariate analysis of species x plot data in communities

# we are at population levels and individuals of the same species, about popolations we talked about density and distribution 
# next level is about communities: different individuals from different species
# once u're dealing with communities u deal with plots, measures in squares, reading table 
# from tables we're moving to graphs, to understand ho species live together, then multivariate analysis for showing how much individuals are dealt with each other 

# presentation on duccio github account 

# imagine we go to field and we visit some plots, 3 plots in this case, in any of them we mesure the information about species (SEE PRESENTATION MULTIVARIATE). in plot 1 15 individuals, plot n2 2, plot n3 3 of Orchys, final species Larix decidua plot1: 3, plot2: 10, plot 3: 8. Parnassius plot1: 13, plot2:1, plot3:2. 

# we can put the data in a matrix of plotxspecies. from the table we can pass to something graphical to understand how individuals are related to each other. plot1 is axe1, plot2 axe2, plot3 axe3, there are some species more related to each other like the orchys and the butterflies because of impollination.

# what would happen if we had 4 plots? we can only see things in 3 dimensions, so a fourth plot cannot be added to a graph of 3 dimensions (X,Y,Z). to face the problem we can pack the system to something we can visualize.

# 4 ore more plots in lower number of dimensions doing ECOGRAPHY

# let's imagine an X axe and Y axe, in this 2 axes we have several individuals with a certain distribution, the X axe is containing 50% of all range, Y axe other 50% (ha disegnato un grafico cartesiano con una striscia di punti in diagonale dall'origine), then we draw a line from origin to top right called component1 and another from top left to down right called component2 -> creating component we change the originals system passing from X/Y to more asses -> PCA PRINCIPAL COMPONENT ANALYSIS. 

# PCA is one of multivariate analysis and helps to pass froma  system made of multidimensions to one made by 2 dimensions, and from 2 dimensions to 1 dimensions.

# we get a system with several species and compact them with pc1 (principal component) and pc2

# package used: vegan (vegetation analysis)

install.packages("vegan") 
library(vegan) # per controllare che sia stato installato correttamente
data(dune) 
dune # all the species and all the plots

# function "head(dune) (head of the dataset) that shows only the first 6 lines to restrict the dataset

head(dune)
View(dune) # to see the table but on R is better

# now decorana function, decorana means detrended correspondence analysis, it's a PCA powerful when we have range of data quite disperse, the function compacts everything.

decorana(dune) #dune is the dataset, decorana is the analysis
multivar <- decorana(dune) # we assign decorana(dune) to multivar

# we passed from original set to 4 axis (DCA1,2,3,4), writing decorana(dune) we see the length of axis, the length is the amount of range represented from the axis. the aim is to see the percentage of the original range which is incorporated in 2 axis. the maximum amount of axis we can use is 3 because our brains work in 3 dimensions.

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

# now to have the information about the whole amount of variability in percentage we add perc1 + perc2

perc1+perc2 # = 71.03683

# the first two axes explain 71% of the variability 

plot(multivar) #the founder of the graph used the first 4 letters of the genre and the species. 

# we're passing from big table of species to graphs
# i calculate the length of the new axis given the dataset, we saw it's 71%, we know that some of this will give me the amount of information of 71%, so i'm losing 29% becuase we only used 2 axis. (prima abbiamo voluto sapere quante info potevamo avere, poi con plot abbiamo visto l'insieme del plot dune)
