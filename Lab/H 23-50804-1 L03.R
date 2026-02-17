#List of required packages
packages <- c("dplyr", "readr")

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Load and inspect the iris dataset
head(iris)
str(iris)
summary(iris)

#Calculate mean, median and mode by length
mean(iris$Sepal.Length)
median(iris$Sepal.Length)
names(freq_table)[which.max(freq_table)]

#Calculate of range, variance, standard variance,Interquartile Range
range_val <- range(iris$Sepal.Length)
max(range_val) - min(range_val)
var(iris$Sepal.Length)
sd(iris$Sepal.Length)
IQR(iris$Sepal.Length)
quantile(iris$Sepal.Length, probs = c(0.25, 0.75))

# Calculate mean, sd, and count for each species
iris %>%
  group_by(Species) %>%
  summarise(
    count = n(),
    mean_sepal_length = mean(Sepal.Length),
    sd_sepal_length = sd(Sepal.Length),
    mean_petal_length = mean(Petal.Length),
    sd_petal_length = sd(Petal.Length)
  )

pairs(iris[, 1:4], main = "Scatterplot Matrix of Iris Data", col = iris$Species)

install.packages("googledrive")
install.packages("readr")
library(googledrive)
library(readr)

data <- read.csv("https://drive.google.com/uc?id=1XEq1zRNkEvInwLmdb7jONor3ysbUHGTy")
head(data)
str(data)
summary(data)

data1 <- read.csv("https://drive.google.com/uc?id=1Aft70EKwAu3d2iWvgYx4MUsWkgKEm7W3")
head(data1)
str(data1)
summary(data1)






















