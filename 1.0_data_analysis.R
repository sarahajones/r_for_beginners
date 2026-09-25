######### Moving forward with R a beginners guide ##################################
# AUTHOR: Dr Sarah Ashcroft-Jones
# github: sarahajones

# This script is meant to further your orinetation in the R language. 
# It will highlight some data wrangling, plotting, and analysis tools.
# There is more explanation than code here - but it is useful to step through slowly.

######### 6.0 Beyond the basics - libraries and dplyr #######################

# So far we have been looking at coding use what we call "base" R. 
# This is code or commands that the base language in R understands and executes. 
# This can get you quite far, but for more advanced analytics - like
# complex data visualization, statistical tests, and importing external datasets we need additional help. 

# This extra help comes in the form of "packages" of code from the an open source repository called CRAN
# Think of packages like add-ons, they contain additional useful functions that interface with R on you behalf. 
# They lift the load for you and allow you to easily re-purpose R for things like stats, 
# data viz, or even machine learning!

# Let's load in one of the most useful packages - tidyverse. 
# Tidyverse is actually a collection of smaller packages that will all get loaded in for you at once. 
# It includes tools for plotting (ggplot) and data wrangling (dpylr). 

# The first time you use a package you need to install it. 
# You only need to do this once - after that you will just load it into your environment. 
# We will use the function install.packages() to do this. 
install.packages("tidyverse") #note that you HAVE to use quotation marks around the name of the package

# Once this has successfully installed it will remain part of your R software until you uninstall it 
# However, it needs to be "activated" for use - to do this we use the function library()
# Think about install.packages() as adding a book of code to your world of R.
# When you want to use those packages you need to take it off the shelf, open it, and use it.
# An analogy would be taking a reference book out from the library to use - hence library().

library(tidyverse) #note that you should NOT use quotation marks here - again I do not make the rules! 

# Now that we have that extra code we can do quite a lot more than before. 
# The first thing we can do is something called "piping" 
# This is a way of manipulating your data flexibly and efficiently using the dpylr package
# Piping makes use of the pipe which is represented by %>%, it links together statements in code.
# R will only know how to read this symbol if you have the dplyr package loaded in your session. 

# Toy dataframe (hospital patients)
data <- data.frame( 
  patient_id = c(1:10), 
  age = c(24, 36, 18, 66, 39, 42, 38, 23, 54, 92), 
  gender  = c("F", "M", "M", "M", "F", "NB", "F", "M", "M", "F"), 
  ward = c(1, 7, 6, 2, 6, 2, 7,  2, 2, 1), 
  discharged = c(1,0,0,0,1,1,0,1,0,0) 
)
# Let's take our dataframe from above, data, and try to make it more useful to us in some way:
# Run all these lines of code together in one go!

data2 <- data %>% 
  group_by(ward) %>%
  mutate(
    age_sd = sd(age),
    age_upper = mean(age) + age_sd,
    age_lower = mean(age) - age_sd,
  )

# What just happened? Can you work it out? 
# Look at the way data has changed when you open up the data2 object - can you figure it out?

# Let's break it down line by line
data2 <- data %>%  # into the new variable data2, we are going to put something from the orginal data object
  group_by(ward) %>% # we are going to ask the information in data to be grouped based on the ward number
  mutate( # and within each of those groups we are going to mutate/manipulate the data
    age_sd = sd(age), # the sd() function calculates the standard deviations
    age_upper = mean(age) + age_sd, #and here we use that value to take the upper 
    age_lower = mean(age) - age_sd, # and lower bounds around the mean. 
  ) # all of this information is then passed back up the pipe (%>%) and assigned to the new dataframe, data2. 

# If you open up data2 you will see that each ward has a unique standard deviation and bound set.
# It is shared within those ward patients, based on their data, but is not the same as the other wards. 

# Consider where this kind of operation might be useful in the data we have looked at this semester.
# Would it be useful to be easily able to group things by clinic, by borough, or by gender to analyse? 
# Yes - of course it would be!

# Piping in dplyr is extensive and be used in many clever ways to iteratively apply functions to 
# different sections of your data in a particular order. We will see more soon on how it can be useful. 
# For now remember the symbol %>% to be a pipe that links together the different lines of code. 
# It then funnels the information back into the variable at the top in whatever way we ask for it. 


# The filter function: a new way of subsetting using piping:

data_filtered <- data %>% 
  filter(age < 65) %>% 
  group_by(gender) %>%
  mutate(
    filtered_grouped_avg_age = mean(age)
  ) %>%
  ungroup() %>% # this breaks down any groups that had been established
  mutate(
    filtered_total_avg_age = mean(age)
  )

# What are your predictions here - what will the new dataset look like?

# Take a look at the logic of the argument going into filter()
# filter(age < 65) 
# Where (age < 65) is TRUE the rows in your dataframe will be kept. 
# Where (age < 65) is FALSE the rows in your dataframe will be discarded. 

# To practice you understanding, try this: 
# Into a new dataframe - can you filter the data set so only men are left 
# and then add a column that takes the average age? 





rm(data_filtered) # tidy up your environment 


# More piping - the summarise function:

data2 <- data %>%
  group_by(gender) %>%
  mutate(
    meanAge = mean(age)
  )

summary_data <- data %>%
  group_by(gender, discharged) %>%
  summarise(
    meanAge = mean(age),
  )



#What is the difference and where is this useful? 
# Take a look at the difference in shape and result of the two code chunks
# The actual code syntax is very similar but the output is very different!
# summarise() creates a summary table, it does not add a new col to a dataframe
# This can be very useful but it does mean that all other information is dropped.
# Consider the use cases for both summarise() and mutate() - 
# They are both useful, but don't mix them up!



######### 6.1 Getting "logical" with case_when and loops ###########################
# case_when() - new way to think about recoding variables

data_cases <- data %>% 
  mutate(
    sex_cat  = case_when(
      gender == "F" ~ 0, # when case is TRUE then put 0
      gender == "M" ~ 1, # when this case is TRUE then put 1
      TRUE ~ 2 # otherwise (in all other cases) then put 2
    )
  ) # make sure to match you opening brackets each time please!


# What happened how did it work? 

# Can we use this to recode something else? 
# Try this, build some age groupings based on the age variable
# 18-25, 25-35, 35-45, 45-65, 65+ 
# decide how to best set the cases (might need to combine statements)
# e.g. "age > 18 & age =< 25 ~ 18-25"
# WHAT IS THE BEST "EVERYTHING BUCKET' HERE? 










# if statements - statements of conditionality
if(sum(data$discharged) < 0.5*(length(data$discharged))){
  print("warning bed shortage likely")
}

# if statements work as follows:
# if the statement between the smooth brackets is TRUE
# then
# do the action in the {}
# otherwise, do nothing


# This allows us to execute actions (change data for example)
# only in case where it is needed and not globally. 
# We can expand (lik a case_when()) using elseif and else statements also.

if(sum(data$discharged) < 0.5*(length(data$discharged))){
  print("warning bed shortage likely")
} else if (sum(data$discharged) > 0.5*(length(data$discharged))){
  print("good bed availability")
} else{ # this the everything bucket that only is actioned if the others are not true
  print("beds might become scare soon")
}

# adjust the toy dataframe (hospital patients) to get a different outcome
data$discharged <- c(1,1,1,1,1,1,0,1,0,0) 

if(sum(data$discharged) < 0.5*(length(data$discharged))){
  print("warning bed shortage likely")
} else if (sum(data$discharged) > 0.5*(length(data$discharged))){
  print("good bed availability")
} else{# this the everything bucket that only is actioned if the others are not true
  print("beds might become scare soon")
}


# How can you adjust the data$discharged vector 
# to print the ""beds might become scare soon" message in your console?
# for loops
for(i in 1:length(data$patient_id)){
  print(i)
}

# When we run the for loop it initialises a var called i
# On each iteration i takes the value of the next item in the vector
# That we set up in our statement after "in"
# So here we can check what values those will be by running just 
1:length(data$patient_id) # the values 1 to 10 emerge
# if we had 100 patient_ids 1 would go from 1:100

# the for loop will execute as many iterations as it has values for i
# on each iteration the value shifts and it executes the action inside the loop
# so here it prints the value of i each time is loops around

# things get interesting when we combine the two types of statements
# nesting if statements inside a for loop 
for(i in 1:length(data$patient_id)){ # loop over the code 10 times
  if(data$discharged[i] == 1){
    data$ward[i] = NA # only do this if the statement is TRUE
  }
}




rm(i) # clean up any variables needed




######### 7.0 Plotting our data ########################################
# Toy dataframe (hospital patients) , reload if needed
data <- data.frame( 
  patient_id = c(1:10), 
  age = c(24, 36, 18, 66, 39, 42, 38, 23, 54, 92), 
  gender  = c("F", "M", "M", "M", "F", "NB", "F", "M", "M", "F"), 
  ward = c(1, 7, 6, 2, 6, 2, 7,  2, 2, 1), 
  discharged = c(1,0,0,0,1,1,0,1,0,0) 
)
# Now let's turn to plotting our data. 
# We can do some plotting in base R but we can do more advanced plotting with the package ggplot2.

#Let's start with base R, we can use the plot() function to plot out things roughly. 

plot(data$age) #at it's most basic we can plot out the values of a column of data, plot(X)
plot(data$age, data$ward) #or we can plot them against another variable, plot(X,Y)

# But these are rather ugly and diffcult to manipulate into nicer visualisations. 
# They are useful for quick and dirty visual checks of your data, 
# to spot an outlier data point or to see missing data. 

# Instead we will mostly work using ggplot2 code and related functions. 
# These are functions like ggplot(), you need to run all these lines together as one piece. 

ggplot(data = data, mapping = aes(x=age, y=ward)) +
  geom_point(aes(color = discharged)) +
  theme_bw() +
  ggtitle("Ward and Age") +
  xlab("Age (in years)") +
  ylab("Ward Number")  

# Looking at the plot can you figure out what the lines of code might mean?

# Let's break it down below:
ggplot(data = data, mapping = aes(x=age, y=ward)) + # Take the data, and pick what X and Y variables will be.
  geom_point(aes(color = as.factor(discharged))) + # The geom_point() function tells ggplot to plot things as points
  # Add a layer of color based on discharged
  # We use the function as.factor() to make sure that the 1s and 0s are read as categories, not as part of a continuous number scale
  theme_bw() + # This is line gives a basic black and white theme to the background.
  ggtitle("Ward and Age") + #Write out the title
  xlab("Age (in years)") + #Label the x axis
  ylab("Ward Number") # Label the y axis

# Notice that we used the + symbol to connect the pieces of code. 
# ggplot() works using what it calls "layers", we add the information to the plot in layers
# Unless we add them together using the + sign, ggplot will not execute them and the plot will not generate in full

# Let's try another plot type
ggplot(data = data, mapping = aes(x=ward)) + #Take data and pick what to plot (here only need X because of plot type)
  geom_bar() + #Use a bar geom to plot the data, aka plot data as a barplot
  theme_bw() + # Set basic black and white theme to the background.
  ggtitle("Ward Number Barplot") +#Write out the title
  xlab("Ward Number") + #Label the x axis
  ylab("Count")  # Label the y axis


# R has many diverse plot types, each with slightly different ways of coding them up.
# The best thing to do is google for example of the kind of plot you want.
# WHen googling specify the package and the language you are using
# For example : How to plot a line graph in ggplot2 R
# This google query would bring up relevant examples for you to examine and learn from! 

################################################################################
######### Basic data exploration ##############################################

# In this script we will be looking at how to import a full dataset into R, 
# Begin to explore that dataset, and look at what data you have to analyse. 
# You will need to have the clinical attendance data saved on your computer.
# It must be saved in a csv format (like when we used it in JASP).


######### 1.0 LOAD IN AND CHECK DATA ##########################################
# Before we begin we need to let R where to look for our dataset in our files.
# To do this, check what the Working Directory is for R, as it needs to know where the 
# data is coming from.This is the path it will follow to try and load in the data. 
# We can ask it with this function:

getwd() # meaning "get working directory"

#TOP TIPS: 
#1.  R will not allow "\", so you always need to change those to "/".
#2. that if you are not sure the correct path for the working directory, you can look to the far right window 
#on the Files tab (use the three little dots). 
#3. Use session menu above
#4. setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

setwd("C:/ …. YOU WILL NEED TO CHANGE THIS TO YOUR PATHWAY…") # "set working directory"

# Now that you have set the working directory, we want to import the data, similar to what we did with JASP.
# However, we need to tell R to install the package that helps us do so first.
# This is for working with CSV files, used in programs such as SPSS and Excel 
# We will first tell it to install the readr package, then make sure it is running by using the library function

install.packages('readr')
library('readr')

# But we haven't imported actually imported data yet, so let's give a name to the file we’re going to use (ClinAttend) #and import. 
# MAKE SURE THE NAME OF THE DATASET IS CORRECT!

ClinAttend <- read_csv("Clinical Attendance Data AMDM.csv")

#The dataset should now appear on the right in the data window of your environment. 
#Let's do some exploration, have a look through and see what you find.

View(ClinAttend) #or just click on the data object in your environment

#We can also check the names of the variables to make sure they look right.

names(ClinAttend)

#Now let's just look at the first few rows of data. Still look ok?

head(ClinAttend) 

#Finally, exploration. Any surprises there?

summary(ClinAttend)
summary(ClinAttend$AttendanceScore)

#If this were for a real project, we might have some intermediate steps to ensure data quality.
#You would probably do this with visuals, which we will do later on in this exercise.

#For now, let's move onwards as we are very familiar with these data 

# One thing you may want to do before we go further is tell R not to give you strange decimals/exponentials
# To do this, simply run the following function

options(scipen = 999)

######### 2.0 T-TESTS IN R ##################################################

# Now let's try a simple t-test. How about looking at attendance scores between sex?
# here the function asks for the information in the form t.test(DV ~ IV, dataset)

t.test(AttendanceScore ~ BSex, ClinAttend)


# What did we learn? What was the question? What is your decision?
# Notice that the default t-test used in R is Welch's t-test. We have not covered all the t-test approaches nor their implications.
# This is a good lesson in making sure you have reference material handy to ensure you make appropriate choices with your analysis. 

# Can you write a t-test for difference in travel time between gender?
# Yes, not a great research question but we are practicing coding here! 


# T-test for travel time and gender
t.test(
  TravelTime ~ BSex, ClinAttend
)

# What if we wanted to just look at a t-test of attendance between just two of our boroughs?
# Remember the subset function from the basics script? 
# Can we use it to just compare attendance in Bronx and Queens?


# Let's check again what is in the borough variable
  
unique(ClinAttend$Borough) #checks what unique values exist in this variable


# How can we pick out just the levels we care about? 

# Option 1: 
two_boroughs <- ClinAttend %>%
  filter(Borough != "BRK") # remove using dply
# Option 2: (achieves the same thing)
two_boroughs <- subset(ClinAttend, Borough != "BRK") # Remove the Brooklyn rows

t.test(AttendanceScore ~ Borough, two_boroughs)

# Can you repeat this but create a dataset that removes Queens and compares Brooklyn and the Bronx?

two_boroughs <- subset(ClinAttend, Borough != "QUN") # Remove the Brooklyn rows

t.test(AttendanceScore ~ Borough, two_boroughs)

######### 3.0 CORRELATIONS AND REGRESSIONS IN R ################################

# CORRELATION
# Now let's try run a  correlation between Attendance Score and Income.
# Again, we've named the analysis first, then told it which variables to use from a given dataset.
# What would be the question here and what is your decision?

cor <- cor.test(ClinAttend$AttendanceScore, ClinAttend$Income)
cor

# Again, please note that this is overly simplified. 
# If we were testing it for a project, we would need more steps, like assumption checks.
# An aside: notice how you have been provided more lines of explanation than lines of actual code 
# - this is a good habit to get into. 
# Always leave notes that you’ll understand in six months, or another person will understand. 
# Don’t assume your simple notes today will be obvious in five years.


#What about a correlation between income and age? 
cor(ClinAttend$Income ~ ClinAttend$Age)


# REGRESSION
# Let's try a prediction question: Does income predict attendance score?
# So we give it a name and tell it to run a linear model, using our variables and dataset of interest.
# But it won't return anything automatically, so we need to ask for a summary of the results.

regression <- lm(AttendanceScore ~ Income, data = ClinAttend) #lm stands for linear model
summary(regression)

#Now let's try to visualize it using the plot function. 
# It is not as easy to customise as ggplot but we can still tweak things
plot(ClinAttend$Income, ClinAttend$AttendanceScore, col = "blue", pch = 16) 
# We can guess what "col" is doin (changing the colour) - but what about "pch" 
# "pch" is an argument that plot() uses to change something. 
# Change the value from any number from 0-25 and see what happens, what changes? 

# This will show the regression line!
abline(regression)

# But perhaps we'd like some more information to display.
# We can add the r2 value and perhaps some plots to tell us how fit the data are.
# Note: you have to tell it below that you want to see the plot.

legend("topright", bty="n", legend=paste("R2 is", format(summary(regression)$adj.r.squared, digits=4)))

# Note this may not generate properly if your plot window is too small. 
# Expand the window and then regenerate to see if the writing shows up!

# TRY IT YOURSELF: 
# Can we run a regression to test is age predicts attendance score?

regression <- lm(AttendanceScore ~ Age, data = ClinAttend) 
summary(regression)

rm(regression)

######### 4.0 CHI-SQUARED and ANOVA in R #################################################
# Now let's look at a few ways to run chi-squares.
# Is there a sex difference for attended yes/no on last appointment?

chisq.test(ClinAttend$BSex, ClinAttend$Attend)

# Another way to run x2 is to build a table and then run the test on that table
chitable <- table(ClinAttend$BSex, ClinAttend$Attend)
chitable
chisq.test(chitable)

# ANOVA - Analysis of Variance
# aov(DV ~ IV, data)

oneway <- aov(AttendanceScore ~ Borough, data=ClinAttend) 
summary(oneway)

#Now let's plot it, but now we have full control, unlike in JASP
#Note that we are adding in error bars ourselves
#install.packages("ggpubr")
library(ggpubr)

oneway_plot <-  ggline(ClinAttend, # a quick and easy syntax for plotting ANOVA                                 
                       x = 'Borough', y = 'AttendanceScore',  
                       add = c("mean_ci"))     
oneway_plot
# NOTE 
# add: Allowed values are one or the combination of: "none", "dotplot", "jitter", 
#"boxplot", "point", "mean", "mean_se", "mean_sd", "mean_ci", "mean_range", 
#"median", "median_iqr", "median_hilow", 
#"median_q1q3", "median_mad", "median_range"


#Even though it is pretty clear there is no significant difference here, 
# in other cases, we might want to run a post hoc
#This is relatively simple but you need to be sure you use the correct post hoc option

TukeyHSD(oneway) # HSD = honestly significant difference... 

#The same is true for effect sizes (irrelevant here), though we need to provide some additional argumentation
# install.packages("effectsize")
library(effectsize)

effectsize::eta_squared(oneway)

#Similar approach if we do our mixed ANOVA
# aov(DV ~ IV1 + IV2, data)

twoway <- aov(AttendanceScore ~ Borough + BSex, data=ClinAttend)
summary(twoway)

#if we want to look at the interaction effect - we have to specify that
# aov(DV ~ IV1 + IV2 + IV1*IV2, data)

twoway <- aov(AttendanceScore ~ Borough + BSex + Borough*BSex, data=ClinAttend)
summary(twoway)


#Let's plot this out, but let's get as much detail as we can about our variables and our points
#Note the term "jitter" will make it so all the dots are spread a bit just to give an idea of density

twoway_plot <-  ggline(ClinAttend, x = 'Borough', y = 'AttendanceScore',
                       linetype = "BSex", color = "BSex",     
                       add = c("mean_ci", "jitter")) 
twoway_plot


rm(oneway, oneway_plot, twoway, twoway_plot)

######### 5.0 Coding challenge - independent analysis in R ####################

#Step 1: Prepare and Explore
# Load in "Falls data course.csv" file
# Explore the variables, 
## This could include checking what type of data the variables are
## Getting a descriptive summary of the variables
## Plotting out some of the variables. 

#e.g. ...
#FallsData <- read_csv("Falls data course.csv")




#Step 2: Data Cleaning 
#Focus our analysis to large clinics, only look at data from clinics with more than 1000 patients
#Also - only look at data from clinics where the average age of patients is above 50. 

#e.g. ...
#subset()




#Step 3: Analysis? 
#Is there a difference in the number of falls between the number of falls in public and private clinics? 

#Does fall rate relate to average patient age? 

#Does the rate of falls differ based on staff training and patient type? 





#Step 4: Plotting 
#Can you think of ways to plot some of these results out? 







# If you would like to talk through your solutions or send them to me 
# please, feel free! I love to chat about statistical programming!
# I am always happy to review and discuss errors and solutions!
# Send me an email on sa4422@columbia.edu or message me in slack!

################################################################################