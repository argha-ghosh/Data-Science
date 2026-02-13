# if Statement
value <- 10
if (value > 5) {
  print("value is greater than 5")
}

# if…else Statement
number <- 3
if (number > 5) {
  print("number is greater than 5")
} else {
  print("number is 5 or less")
}

# if…else if…else Ladder
exam_score <- 75
if (exam_score >= 90) {
  print("Grade A")
} else if (exam_score >= 80) {
  print("Grade B")
} else if (exam_score >= 70) {
  print("Grade C")
} else {
  print("Grade F")
}

# for Loop
for (iteration in 1:5) {
  print(paste("Iteration", iteration))
}

# repeat Loop (with break)
counter <- 1
repeat {
  print(counter)
  counter <- counter + 1
  if (counter > 5) break
}

# next Statement (skip to next iteration)
for (iteration in 1:5) {
  if (iteration == 3) next
  print(iteration)
}

# break Statement (exit the loop)
for (iteration in 1:5) {
  if (iteration == 4) break
  print(iteration)
}

# Built-in Functions
numbers_list <- c(10, 20, 30, 40, 50)
mean(numbers_list)
sum(numbers_list)
length(numbers_list)

# round()
pi_value <- 3.14159
round(pi_value, 2)

paste("Hello", "World")

# User-Defined Functions
add_values <- function(a, b) {
  return(a + b)
}

add_values(5, 3)

is_even_number <- function(x) {
  if (x %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

is_even_number(4)

greet_user <- function(name = "User") {
  paste("Hello", name)
}

greet_user()
greet_user("Abir")

# Anonymous (Lambda) Function with sapply()
numbers_seq <- 1:5
squared_values <- sapply(numbers_seq, function(x) x^2)
print(squared_values)

# Data Read
data_read <- read.csv("F:\\sample_dataset.csv")
head(data_read)

data_table <- read.table("F:\\sample_tab_delimited.txt", header = TRUE, sep = "\t")
head(data_table)

url_data <- "https://raw.githubusercontent.com/uiuc-cse/data-fa14/gh-pages/data/iris.csv"
data_from_url <- read.csv(url_data)
head(data_from_url)

# Exercises
# Exercise 1
exam_score <- 85
if (exam_score >= 90) {
  print("Excellent")
} else if (exam_score >= 75) {
  print("Good")
} else if (exam_score >= 50) {
  print("Pass")
} else {
  print("Fail")
}

# Exercise 2
numbers_seq <- 1:10
for (num in numbers_seq) {
  print(num^2)
}

# Exercise 3
count <- 1
while (count < 20) {
  if (count %% 2 == 0) {
    print(count)
  }
  count <- count + 1
}

# Exercise 4
multiply <- function(a, b) {
  return(a * b)
}
multiply(5, 3)

# Exercise 5
calculate_stats <- function(values) {
  list(mean = mean(values), median = median(values), sd = sd(values))
}
calculate_stats(c(1, 2, 3, 4, 5))

# Exercise 6
grade_result <- function(score) {
  if (score >= 90) {
    print("A")
  } else if (score >= 75) {
    print("B")
  } else if (score >= 50) {
    print("C")
  } else {
    print("F")
  }
}
grade_result(80)

# Exercise 7
students_data <- read.csv("students.csv")
head(students_data, 5)
str(students_data)
