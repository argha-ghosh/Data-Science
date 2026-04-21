#List of required packages
packages <- c("ggplot2", "dplyr", "scales", "tidyr","GGally")

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

data("mtcars")
head(mtcars)

ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "HP vs MPG", x = "Horsepower", y = "Miles per Gallon")

ggplot(mtcars, aes(y = mpg)) +
  geom_boxplot(fill = "tomato") +
  labs(title = "Boxplot of Miles per Gallon", y = "MPG")

ggcorr(mtcars, label = TRUE)

# --- Handling Missing Values ---

# Check how many NA values are in each column
colSums(is.na(mtcars))

# Create a new dataframe with rows containing NA values removed
mtcars_clean <- na.omit(mtcars)

# Verify that there are no more NA values
cat("Total NA values after cleaning:", sum(is.na(mtcars_clean)), "\n")

# --- Handling Duplicates ---

# Check for any duplicated rows in the entire dataset
cat("Total duplicated rows:", sum(duplicated(mtcars_clean)), "\n")


# Although there are no duplicates in this case, here is how you would remove them:
# mtcars_clean <- distinct(msleep_clean)
mtcars_clean <- mtcars_clean[!duplicated(mtcars_clean), ]

mtcars_filtered <- mtcars_clean %>% filter(mpg > 20)

mtcars_selected <- mtcars_filtered %>% select(mpg, hp, wt)

mtcars_scaled <- mtcars_selected %>%
  mutate(across(c(mpg, hp, wt), ~ scale(.)[,1]))
head(mtcars_scaled)

install.packages("readr")

library(readr)

url <- "https://drive.google.com/uc?id=1F8sVjULjrvQWN-eKQk5gKRf2i2VleBPh"
dataset <- read_csv(url)
head(dataset)
summary(dataset)

