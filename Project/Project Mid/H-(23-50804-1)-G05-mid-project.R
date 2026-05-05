# ****************************************
# INSTALLING AND LOADING REQUIRED PACKAGES
# ****************************************

packages <- c("ggplot2", "dplyr", "scales", "tidyr", "GGally", "corrplot", "e1071", "caret")

installed_packages <- rownames(installed.packages())

for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}


########################
# A. DATA UNDERSTANDING
########################

# **************************************
# A1. Load the dataset from Google Drive
# **************************************

data <- read.csv("https://drive.google.com/uc?id=1ZQeE33xnHGuInF1vBkVbm0tZ1on_cAIA",
                 stringsAsFactors = FALSE)

# Clean column names to avoid name-related errors
names(data) <- trimws(names(data))
names(data) <- make.names(names(data))

# Create a separate copy for plotting
plot_data <- data

# Convert important columns to numeric for analysis and plotting
numeric_columns_to_fix <- c("Goals.Scored", "Assists.Provided", "Appearances",
                            "FIFA.Ranking", "National.Team.Jersey.Number")

for (col in numeric_columns_to_fix) {
  if (col %in% names(data)) {
    data[[col]] <- as.numeric(as.character(data[[col]]))
    plot_data[[col]] <- as.numeric(as.character(plot_data[[col]]))
  }
}

# *********************************************
# A2. Display the first few rows of the dataset
# *********************************************

head(data)

# ****************************************************
# A3. Show the shape of the dataset (rows and columns)
# ****************************************************

cat("Number of Rows :", nrow(data), "\n")
cat("Number of Columns :", ncol(data), "\n")

# *************************************************************************************
# A4. Display data types of each column and identify categorical and numerical features
# *************************************************************************************

str(data)   # This displays data types of each column

categorical_features <- names(data)[sapply(data, function(x) is.character(x) | is.factor(x))]
categorical_features   # This identifies categorical features

numeric_features <- names(data)[sapply(data, is.numeric)]
numeric_features   # This identifies numerical features

# *******************************************************
# A5. Generate descriptive statistics for numeric columns
# *******************************************************

numeric_data <- data[, sapply(data, is.numeric), drop = FALSE]

for (col in colnames(numeric_data)) {
  
  cat("\n**********************************\n")
  cat("Column Name :", col, "\n")
  cat("**********************************\n")
  
  cat("Count :", sum(!is.na(numeric_data[[col]])), "\n")
  cat("Mean :", mean(numeric_data[[col]], na.rm = TRUE), "\n")
  cat("Median :", median(numeric_data[[col]], na.rm = TRUE), "\n")
  cat("Standard Deviation :", sd(numeric_data[[col]], na.rm = TRUE), "\n")
  cat("Minimum :", min(numeric_data[[col]], na.rm = TRUE), "\n")
  cat("Maximum :", max(numeric_data[[col]], na.rm = TRUE), "\n")
  cat("Skewness :", skewness(numeric_data[[col]], na.rm = TRUE), "\n")
}


#####################################
# B. DATA EXPLORATION & VISUALIZATION
#####################################

# ************************
# B1. Univariate Analysis
# ************************

# Histogram of Goals Scored
ggplot(plot_data, aes(x = Goals.Scored)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Goals Scored",
       x = "Goals Scored",
       y = "Frequency")

# Boxplot of Goals Scored
ggplot(plot_data, aes(y = Goals.Scored)) +
  geom_boxplot(fill = "green") +
  labs(title = "Boxplot of Goals Scored",
       y = "Goals Scored")

# Bar chart of player positions
ggplot(plot_data, aes(x = Position)) +
  geom_bar(fill = "orange") +
  labs(title = "Number of Players by Position",
       x = "Position",
       y = "Count")

# Frequency tables of categorical variables
table(plot_data$Position)
table(plot_data$Nationality)
table(plot_data$Club)


# **********************
# B2. Bivariate Analysis
# **********************

# Select numeric columns for correlation analysis
numeric_data <- data[, sapply(data, is.numeric), drop = FALSE]

# Remove columns where all values are NA
numeric_data <- numeric_data[, colSums(is.na(numeric_data)) < nrow(numeric_data), drop = FALSE]

# Remove columns with zero variance
numeric_data <- numeric_data[, apply(numeric_data, 2, function(x) var(x, na.rm = TRUE) != 0), drop = FALSE]

# Create correlation matrix
cor_matrix <- cor(numeric_data, use = "complete.obs")
print(cor_matrix)

# Plot correlation heatmap
corrplot(cor_matrix, method = "color", type = "upper")

# Scatter plot: Assists Provided vs Goals Scored
ggplot(plot_data, aes(x = Assists.Provided, y = Goals.Scored)) +
  geom_point(color = "blue") +
  labs(title = "Goals Scored vs Assists Provided",
       x = "Assists Provided",
       y = "Goals Scored")

# Scatter plot: Appearances vs Goals Scored
ggplot(plot_data, aes(x = Appearances, y = Goals.Scored)) +
  geom_point(color = "red") +
  labs(title = "Appearances vs Goals Scored",
       x = "Appearances",
       y = "Goals Scored")

# Boxplot: Goals Scored by Position
ggplot(plot_data, aes(x = Position, y = Goals.Scored)) +
  geom_boxplot(fill = "purple") +
  labs(title = "Goals Scored by Player Position",
       x = "Position",
       y = "Goals Scored")

# Boxplot: Appearances by Top 10 Nationalities
top_nationalities <- names(sort(table(plot_data$Nationality), decreasing = TRUE))[1:10]
plot_data_top_nat <- plot_data[plot_data$Nationality %in% top_nationalities, ]

ggplot(plot_data_top_nat, aes(x = Nationality, y = Appearances)) +
  geom_boxplot(fill = "brown") +
  labs(title = "Appearances by Top 10 Nationalities",
       x = "Nationality",
       y = "Appearances")


# ******************************************************
# B3. Identify Patterns, Skewness and Possible Outliers
# ******************************************************

# Pattern identification through scatter plot
ggplot(plot_data, aes(x = Assists.Provided, y = Goals.Scored)) +
  geom_point(color = "darkblue") +
  labs(title = "Relationship Between Assists Provided and Goals Scored",
       x = "Assists Provided",
       y = "Goals Scored")

# Identify skewness in numeric columns
sapply(numeric_data, skewness, na.rm = TRUE)

# Identify possible outliers using IQR method
for (col in names(numeric_data)) {
  
  Q1 <- quantile(numeric_data[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(numeric_data[[col]], 0.75, na.rm = TRUE)
  IQR_value <- Q3 - Q1
  
  lower_bound <- Q1 - 1.5 * IQR_value
  upper_bound <- Q3 + 1.5 * IQR_value
  
  outliers <- numeric_data[[col]][numeric_data[[col]] < lower_bound | numeric_data[[col]] > upper_bound]
  
  cat("\nColumn Name :", col, "\n")
  cat("Number of Outliers :", length(outliers), "\n")
}


########################
# C. DATA PREPROCESSING
########################

# Create a separate copy for preprocessing
processed_data <- data


# ***************************
# C1. Handling Missing Values
# ***************************

# Detect missing values in the full dataset
sum(is.na(processed_data))

# Detect missing values column-wise
colSums(is.na(processed_data))

# Show rows containing missing values
processed_data[!complete.cases(processed_data), ]

# ***************************
# C1.1 Replace Missing Values
# ***************************

# Replace missing values in numeric columns using median
for (col in names(processed_data)) {
  if (is.numeric(processed_data[[col]])) {
    processed_data[[col]][is.na(processed_data[[col]])] <- median(processed_data[[col]], na.rm = TRUE)
  }
}

# Function to calculate mode for categorical columns
get_mode <- function(x) {
  ux <- unique(x[!is.na(x)])
  ux[which.max(tabulate(match(x, ux)))]
}

# Replace missing values in categorical columns using mode
for (col in names(processed_data)) {
  if (is.character(processed_data[[col]]) || is.factor(processed_data[[col]])) {
    processed_data[[col]][is.na(processed_data[[col]])] <- get_mode(processed_data[[col]])
  }
}

# Check again after replacement
sum(is.na(processed_data))
colSums(is.na(processed_data))
processed_data[!complete.cases(processed_data), ]


# *********************
# C2. Handling Outliers
# *********************

# Identify outliers in numeric columns using IQR method
numeric_cols <- names(processed_data)[sapply(processed_data, is.numeric)]

for (col in numeric_cols) {
  
  Q1 <- quantile(processed_data[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(processed_data[[col]], 0.75, na.rm = TRUE)
  IQR_value <- Q3 - Q1
  
  lower_bound <- Q1 - 1.5 * IQR_value
  upper_bound <- Q3 + 1.5 * IQR_value
  
  outliers <- processed_data[[col]][processed_data[[col]] < lower_bound | processed_data[[col]] > upper_bound]
  
  cat("\nColumn Name :", col, "\n")
  cat("Number of Outliers :", length(outliers), "\n")
}

# Explanation:
# Since this is a sports performance dataset, extreme values may represent
# true player performance instead of data entry errors.
# So, capping is used instead of removing outliers.

# *****************
# C2.1 Cap Outliers
# *****************

for (col in numeric_cols) {
  
  Q1 <- quantile(processed_data[[col]], 0.25, na.rm = TRUE)
  Q3 <- quantile(processed_data[[col]], 0.75, na.rm = TRUE)
  IQR_value <- Q3 - Q1
  
  lower_bound <- Q1 - 1.5 * IQR_value
  upper_bound <- Q3 + 1.5 * IQR_value
  
  processed_data[[col]][processed_data[[col]] < lower_bound] <- lower_bound
  processed_data[[col]][processed_data[[col]] > upper_bound] <- upper_bound
}


# *******************
# C3. Data Conversion
# *******************

# Identify categorical columns
categorical_cols <- names(processed_data)[sapply(processed_data, function(x) is.character(x) | is.factor(x))]
categorical_cols

# Convert categorical columns into factor type
for (col in categorical_cols) {
  processed_data[[col]] <- as.factor(processed_data[[col]])
}

# Apply one-hot encoding
data_onehot <- model.matrix(~ . - 1, data = processed_data)
data_onehot <- as.data.frame(data_onehot)

# Preview the encoded dataset
head(data_onehot)
str(data_onehot)

# Check whether all columns are numeric
all(sapply(data_onehot, is.numeric))


# ***********************
# C4. Data Transformation
# ***********************

# Select numeric columns from processed data
numeric_data_processed <- processed_data[, sapply(processed_data, is.numeric), drop = FALSE]

# Min-Max Normalization
data_minmax <- as.data.frame(lapply(numeric_data_processed, function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}))
head(data_minmax)

# Z-score Standardization
data_zscore <- as.data.frame(scale(numeric_data_processed))
head(data_zscore)

# Log Transformation
data_log <- as.data.frame(lapply(numeric_data_processed, function(x) log1p(x)))
head(data_log)

# Square Root Transformation
data_sqrt <- as.data.frame(lapply(numeric_data_processed, function(x) sqrt(x)))
head(data_sqrt)


# ************************************************
# C5. Feature Selection using Correlation Analysis
# ************************************************

# Select only numeric columns from processed data
numeric_data_fs <- processed_data[, sapply(processed_data, is.numeric), drop = FALSE]

# Remove columns where all values are NA
numeric_data_fs <- numeric_data_fs[, colSums(is.na(numeric_data_fs)) < nrow(numeric_data_fs), drop = FALSE]

# Remove columns with zero variance
numeric_data_fs <- numeric_data_fs[, apply(numeric_data_fs, 2, function(x) var(x, na.rm = TRUE) != 0), drop = FALSE]

# Create correlation matrix
cor_matrix_fs <- cor(numeric_data_fs, use = "complete.obs")

# Plot correlation heatmap
corrplot(cor_matrix_fs, method = "color", type = "upper")

# Remove highly correlated features
high_corr <- findCorrelation(cor_matrix_fs, cutoff = 0.8)
high_corr

# Keep selected features only
if (length(high_corr) > 0) {
  selected_data_corr <- numeric_data_fs[, -high_corr, drop = FALSE]
} else {
  selected_data_corr <- numeric_data_fs
}

head(selected_data_corr)


# *************************************************
# C6. Feature Selection using Variance Thresholding
# *************************************************

# Calculate variance of each numeric column
variances <- apply(numeric_data_fs, 2, var, na.rm = TRUE)
variances

# Keep features with variance greater than threshold
selected_data_var <- numeric_data_fs[, variances > 0.01, drop = FALSE]
head(selected_data_var)


#########################
# END OF PROJECT SCRIPT
#########################