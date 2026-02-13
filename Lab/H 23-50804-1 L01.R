# Creating Different Types of Vectors


# Numeric Vector
num_vac <- c(1, 2, 3, 4, 5, 7, 8)
print(num_vac)


# Character Vector
char_vec <- c("Apple", "Banana", "Cherry", "Jack-Fruit")
print(char_vec)

# Logical Vector
log_vec <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
print(log_vec)


# Vector Operations


# Arithmetic Operations
vec1 <- c(2, 4, 6)
vec2 <- c(1, 3, 5)

sum_vec <- vec1 + vec2  # Element-wise addition
prod_vec <- vec1 * vec2 # Element-wise multiplication

print(sum_vec)   # Output: 3 7 11
print(prod_vec)  # Output: 2 12 30

# Accessing Elements in a Vector


# Create a vector
num_vec <- c(10, 20, 30, 40, 50)

# Access elements using index (1-based index)
print(num_vec[2])  # Output: 20

# Access multiple elements
print(num_vec[c(1, 3, 5)])  # Output: 10 30 50

# Modify an element
num_vec[2] <- 100
print(num_vec)  # Output: 10 100 30 40 50

# Append new elements
num_vec <- c(num_vec, 60, 70)
print(num_vec)  # Output: 10 100 30 40 50 60 70

# Vector Functions
vec <- c(5, 10, 15, 20, 25)

# Length of the vector
print(length(vec))  # Output: 5

# Sum of all elements
print(sum(vec))  # Output: 75

# Mean (average) of elements
print(mean(vec))  # Output: 15

# Sorting a vector
vec <- c(1, 10, 75, 20, 25)
sorted_vec <- sort(vec, decreasing = FALSE)
print(sorted_vec)  

vec <- c(1, 10, 75, 20, 25)
sorted_vec <- sort(vec, decreasing = TRUE)
print(sorted_vec)

# Sequence and Repetition in Vectors

# Sequence from 1 to 10
seq_vec <- seq(1, 10, by = 2)  # Steps of 2
print(seq_vec)  # Output: 1 3 5 7 9

# Repeat elements
rep_vec <- rep(c(1, 2, 3), times = 3)  # Repeat entire vector
print(rep_vec)  # Output: 1 2 3 1 2 3 1 2 3

# Creating a 3x3 matrix (filled column-wise by default)
mat <- matrix(1:9, nrow = 3, ncol = 3)
print(mat)

# Filling a Matrix Row-Wise
mat <- matrix(1:9, nrow = 3, byrow = TRUE)
print(mat)

# Naming Rows and Columns
# Creating a matrix
mat <- matrix(1:9, nrow = 3)

# Assigning row and column names
rownames(mat) <- c("Row1", "Row2", "Row3")
colnames(mat) <- c("Col1", "Col2", "Col3")

print(mat)

# Access element at row 2, column 3
print(mat[2, 3])  # Output: 8

# Access entire row 1
print(mat[1, ])  # Output: 1 4 7

# Access entire column 2
print(mat[, 2])  # Output: 4 5 6

# Matrix Arithmetic
mat1 <- matrix(1:4, nrow = 2)
mat2 <- matrix(5:8, nrow = 2)

# Matrix addition
sum_mat <- mat1 + mat2
print(sum_mat)

# Matrix multiplication (element-wise)
prod_mat <- mat1 * mat2
print(prod_mat)

# Matrix multiplication (dot product)
dot_prod_mat <- mat1 %*% mat2  # %*% for matrix multiplication
print(dot_prod_mat)

#Transpose and Inverse of a Matrix
# Transpose of a matrix
t_mat <- t(mat)
print(t_mat)

# Inverse of a matrix (for square matrices)
square_mat <- matrix(c(2, 3, 1, 4), nrow = 2)
inv_mat <- solve(square_mat)
print(inv_mat)

# Creating an array with dimensions (3x3x2)
arr <- array(1:18, dim = c(3, 3, 2))
print(arr)

# Accessing Elements in an Array
# Create a 3x3x2 array
arr <- array(1:18, dim = c(3, 3, 2))

# Access element at [2nd row, 3rd column, 1st layer]
print(arr[2, 3, 1])  # Output: 8

# Access entire 2nd row from Layer 1
print(arr[2, , 1])

# Access entire 3rd column from Layer 2
print(arr[, 3, 2])

#Performing Operations on Arrays
# Creating two 3x3x2 arrays
arr1 <- array(1:18, dim = c(3, 3, 2))
arr2 <- array(19:36, dim = c(3, 3, 2))

# Element-wise addition
sum_arr <- arr1 + arr2
print(sum_arr)






















