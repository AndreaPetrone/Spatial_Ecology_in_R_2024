2 + 3 # this is my first operation in R 

cato <- 2 + 3
cato
maria <- 4 + 2
maria
cato + maria 
cato^maria

# arrays: all vectors are a series of data
andrea <- c(10, 15, 20, 50, 70) # we need to concatenate them with a function, an operation, the function is "c"

sofia <- c(100, 200, 300, 400, 500)
plot(sofia, andrea)
plot(sofia, andrea, pch=19)
plot(sofia, andrea, pch = 19, cex = 2)
plot(sofia, andrea, pch = 19, cex = 2, col = "blue")
plot(sofia, andrea, pch = 19, cex = 2, col = "blue", xlab = "CO2", ylab = "amount of fruits")
