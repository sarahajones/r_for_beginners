###  Getting Started with Collaborative and Reproducible R #####################

# Author: Dr Sarah Ashcroft-Jones
# github sarahajones

# This script serves to outline good practices in R that improve
# code portability, collaboration, and reproducibility! 

### 0.0 Clear comments and documentation #######################################

# Write comments to explain why something is done. 
# Comments should not duplicate the code 
# (watch out for GenAI comments - these are usually useless).

# Bad comments:
# Compute the mean of x
mean(x)

# Good comments:
# Removing participants who did not complete at least 80% of questions
cleaned_data <- filter(survey_data, completion_rate >= 0.8)


# Avoid writing unnecessary or overly detailed explanations. 
# Keep comments brief and meaningful.

# Bad comments:
# The following line of code will take the variable "temperature" 
# and apply a function called "mean()" to it, which will compute 
# the arithmetic average of all the numbers contained in this variable. 
mean_temperature <- mean(temperature)

# Good comments:
# Calculate the mean temperature for the standardization procedure
mean_temperature <- mean(temperature)



# Place the comment above the code block. (or at least be consistent)
# Bad comments:
filtered_data <- filter(data, age > 18)  
# Keep only adults

filtered_data <- filter(data, age > 18)  # Keep only adults

# Good comments:
# Keep only adults
filtered_data <- filter(data, age > 18)  



# Use comments to break down complex logic.
# Write comments at the same time you’re writing the code.

cleaned_data <- data %>% 
  
  # Step 1: Remove missing values from key variables 
  filter(!is.na(age) & !is.na(income) & !is.na(gender)) %>% 
  
  # Step 2: Exclude participants under 18
  filter(age >= 18) %>% 
  
  # Step 3: Create an income category variable 
  mutate( 
    income_bracket = case_when( 
      income < 30000 ~ "Low", 
      income >= 30000 & income <= 70000 ~ "Middle", 
      income > 70000 ~ "High" 
    )
  )


# Final tips:
# When working with large scripts, use block comments to separate sections.
# You can also use the ARTofR package for R Scripts.  
  
### 1.0 Activating and installing packages #####################################

# Option 1 - high friction, low editability, little collaboration ease
# Install and library each package across the script one by one

install.packages("dplyr")
library(dplyr)
install.packages("ggplot")
library(ggplot)
install.packages("readr")
library(readr)
install.packages("lavaan")
library(lavaan)
# etc
# etc
# etc
# etc

# What about your collaborator on the installs?

# Bonus "Sarah's blood pressure rises" points for:
# No comments explaining their use in this script
# "zombie" packages still lurking from first drafts but not used
# Packages distributed across the script at random intervals 
# Loading in random packages for a basic task because ChatGPT told you to


# Option 2: An alternative and highly portable approach -
# At the start of your script list and load in all packages
# Create a list of the required packages e.g.:
list_of_packages <- c(
  # insert packages here
  # ONLY INCLUDE WHAT YOU NEED AND ALWAYS COMMENT WHY IT IS BEING USED
  "tidyverse", # used to wrangle data (dplyr) and visualise data (ggplot2)
  "lavaan" # used to run main statistical models
)

# check for any uninstalled packages
new_packages <- list_of_packages[!(list_of_packages %in% installed.packages()[,"Package"])] 
# install missing packages, if any (requires internet access)
if(length(new_packages)) install.packages(new_packages) 
# library all required packages
lapply(list_of_packages, require, character.only = TRUE) 

# tidy your environment
rm(list_of_packages, new_packages)





# A note on documenting dependencies and environment settings:
# It’s crucial to document your environment because in about 10 years 
# some of the packages you used may be deprecated,
# and the software as we know it may go through drastic changes.

# Example:
# Warning message:
# funs() is soft deprecated as of dplyr 0.8.0 please use list() instead

# How?
# Complicated way - clone your entire R enviroment for someone else...
# simple way:
sessionInfo() 

# put at end of script and copy output into a comment chunk for posterity. 

### 2.0 Setting up your working directory - portably ###########################

# Option 1 - high friction and low reproducibility
# Manual setting of the working directory using the menu settings


# Option 2 - high friction and risk of error in collaboration
# Set working directory with manual file path to your computer, e.g.:
setwd("C:/Users/sa4422/OneDrive - Columbia University Irving Medical Center/Documents")
# Must be adjusted on each version of the script and for every file/device

# Option 3 - low friction, high portability, easy collaboration
#Set the working directory to the folder that this R file is in:
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
# works across devices and can be supported through file management practices

### 3.0 Importing, and exporting data portably #################################

# Now it is time to load in data from the repository files

# Option 1 - standard, but not immune to error! 
  
data <- read.table(file = "data.csv", header = TRUE, sep = ",") 
# or
data <- read.csv("data.csv")

# If your data is housed with your script this should work smoothly.
# read.csv() works more economically i.e. time efficient for large datasets 
# However - does your collaborator have that file in the right version? 

# Tip: If you prefer to use .csv, qualtRics package can be very useful
# e.g.Load the data from Lab UK
raw_data_uk <- qualtRics::read_survey("practice_data_uk.csv")


# Option 2 - download data directly, better? 
  
download.file(url='http://www.website.com/data.csv', 
                destfile='data.csv', method='curl')
data <- read.csv("data.csv")

# Will need to have installed RCurl to  do so 
# - but consider this if your datafiles are updating regularly. 
# Easier for collaboration, you are working with the right file each time. 

# Option 3 - save and use Rdata files, even better? 
# e.g.
save(clean_dataframe, plot_data, file="data.RData")
load(file="data.RData") # holds multiple objects from environment

# OR - for single objects 

write_rds(clean_dataframe,"data.rds")
data <- read_rds("data.rds")

# Why?
# Preserves the data types (e.g. lose factor data types in readr)
# Preserves metadata (e.g. factor levels and labels)
# But - not transferable to Python for example. 


# A side note, on data load consider doing this ...
# Disable scientific notation for easier readability of large and small numbers.

# Bad example:
#[1] 1.234568e+08 
#[1] 1.23e-05

# Good example:
options(scipen = 999)
# [1] 123456789 
# [1] 0.0000123


### 4.0 Writing clean and well-structured code #################################

# The goal here is simple - don't make me think too hard! 

### 4.1 Use Meaningful Variable and Function Names ############################ 

# Names should be descriptive but not too long (no more than ~20 characters).
# Bad Examples:
x <- 100
df <- read.csv("data.csv")
data <- read.csv("data_april.csv")
temp <- filter(data, var1 > 10)
regular_sessions_in_red_room <- ggplot(var2)

# Good Examples:
sample_size <- 100
raw_data <- read.csv("raw_data.csv")
filtered_data <- filter(raw_data, var1 > 10)
regular_sessions_red <- ggplot(var2)

# Naming conventions in R
# Use snake_case (recommended in R!) instead of spaces or special characters
# Yes: mean_age  
# No: `Duration (in seconds)`  

# Note: janitor::clean_names(raw_data) - this will save your sanity with Qualtrics

# Be consistent. If you prefer camelCase, then use it throughout (responseTime)
# Avoid using “.” for variable name separator because R uses it in the background.
# Avoid using certain R reserved words for built-in functions for variable names       
# (e.g., sum, true, false, filter)
# Avoid numerals in names. For example, avoid file1 and file2, or total1/total2.


### 4.2 Follow a Consistent Coding Style #######################################

# a. Use consistent indentation 
# e.g. (two or four spaces per level). 
# Never mix tabs and spaces.

# Messy code: 
if(mean(x)>10){print("High value")
} else{print("Low value")}   

# Clean code: 
if (mean(x) > 10) { 
  print("High value") 
} else { 
  print("Low value") 
}
# Use RStudio’s Reindent Lines tool (Ctrl/Cmd + I) to auto-format code!


# b. Keep lines short (below 80 characters). 
# If a line gets too long, break it (use the visual guide!)

# Hard to read: 
summary <- filter(raw_data, age > 18 & income > 50000 & gender == "male")   
# More readable: 
summary <- filter( 
  raw_data, 
  age > 18 & 
    income > 50000 & 
    gender == "male" 
)

# c. Place spaces around operators (=, +, -, ==, <-, etc.).
# Hard to read: 
mean(x,na.rm=TRUE)
df<-data.frame(x=1:10,y=runif(10))   

# More readable: 
mean(x, na.rm = TRUE) 
df <- data.frame(x = 1:10, y = runif(10))


# d. Keep your space tidy 
# If you know which variables you no longer need, you can remove them using rm()

# Bad example: 
# Remove all variables except raw_data and filtered_data
rm(list = setdiff(ls(), c("raw_data", "filtered_data"))) 

# Good example: 
rm(var1, var2) # Remove var1 and var2

rm(list = ls(pattern = "^t_")) # Remove all starting with "t_" 

# Don’t leave commented code out
# They are dead code since they don’t compile or run
# Do not leave zombie code chunks around to rise up and haunt you later

# Bad example: 
# ggplot(data, aes(x = x, y = y)) + geom_point() + 
#     geom_smooth(method = "lm", col = "blue") + 
#     labs(title = "Scatter Plot with Regression Line", 
#          x = "Independent Variable (x)", 
#          y = "Dependent Variable (y)")


# e. Avoid long scripts with repetitive code. 
# Instead, define functions or use piping (%>%).
# Bad example: 
data_cleaned <- filter(data, age > 18)
data_cleaned <- select(data_cleaned, age, income, gender, country)
data_cleaned <- arrange(data_cleaned, desc(income))

# Sidenote: subsetting the data 26 times and saving each one is also repetitive 
# instead use group_by(country) in a dplyr pipeline

# Good example: 
data_cleaned <- data %>% 
  filter(age > 18) %>%
  select(age, income, gender, country) %>%
  arrange(desc(income))


# Top Tip: 
# Use Lintr package to check if your script follows these guidelines 
# (lintr.r-lib.org).

#e.g.
install.packages("lintr") 
library("lintr") 
lint("location/my_script.R")

# gives warnings in console about styling (not functionality)


###############################################################################
### Resources for you to explore later: #######################################

# Configure Qualtrics API to extract data directly as Rda file

# You only need to run this code once on your computer to set it up permanently.
# There is no need to include this code in all scripts.
# Do not share your API token with anyone.

qualtrics_api_credentials(
  # check your Qualtrics account settings to get your API key
  api_key = "<YOUR-QUALTRICS_API_KEY>", 
  # replace by your university base url
  base_url = "https://columbia.qualtrics.com/",
  install = TRUE)

# Then you only need the following code to access your surveys

# Load the data from Qualtrics
raw_data <- fetch_survey(
  # replace by your survey ID "SV_XXXXXX", found in the survey url. 
  # you can see your survey ID in the data collection link.
  surveyID = "<YOUR-SURVEY-ID>",
  # if TRUE it will return text of answer choices, instead of recoded values.
  label = FALSE,
  convert = FALSE,
  include_display_order = FALSE)

################################################################################