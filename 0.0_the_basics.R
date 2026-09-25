######### Introduction to R a beginners guide ##################################
# AUTHOR: Dr Sarah Ashcroft-Jones
# github: sarahajones

# This script is meant to begin to orient you into the R environment. 
# It will highlight some key features and functions of RStudio and the R language. 
# There is more explanation than code here - but it is useful to step through slowly.

# Refer back to this script at any time to check over your fundamentals.

# Some great resources to help you build confidence in these skills beyond the classroom
# https://psyteachr.github.io/ - for undergrad level courses
# https://rc2e.com/ - book for learning R
# https://r4ds.had.co.nz/ - arguably and even better ebook for learning R
# https://swirlstats.com/ - specifically: https://github.com/swirldev/swirl_courses#swirl-courses 
# https://r-graph-gallery.com/ - for plotting help
# https://www.data-to-viz.com/ - for plotting help

######### 1.0 The basics #####################################################

# Commenting your code?
# This is a comment line, we know this because there is a # at the start of it. 
# The hashtag makes R blind to anything that follows such that it does not try to 
# run or "execute" that section as code. 
# Because R does not speak English, but has it's own syntax and language it is 
# important to separate out your own notes, and the code you write. We use hashtags to do this.

# In this script, comments will be placed after every line of example code to help explain it. 
# This is not just a useful tool for learners, but a fundamental part of programming. 
# You need to comment your code to help others (and your future self) understand what you did and why. 
# Start the habit early and it will help you forever!

# What is a variable?
# A variable, or "var" is an object in your coding environment. 
# It could be a single number, a column of data, or it could expand into a larger 
# object like a table or dataframe object. 
# A variable can be thought of as a temporary way of holding together information 
# or data to manipulate it later in some way.
# You variables live in your environment panel, they can be deleted, removed, and changed using code

# Highlight the text below " x = 1" and press the "Run" button at the top right of this panel
# This will run or execute your first line of code (How exciting!)

x = 1 

# TOP TIPS: 
# You can also run a line of code by placing your cursor at the front of the line of code
# and using the keyboard shortcut CRTL + ENTER (this get much swifter when you have lots to run!)
# If you want to run the whole script from start to finish - just hit "Run" without highlighting anything
# The entire script will run from top to bottom. 
# (You often don't want this when learning as you want to work step by step.)

# So, what happened when you ran that line of code? 

# You should have seen the variable x appear in your environment with the number 1 next to it. 
# Your environemtn is the panel on the top right of your R screen by default, it is where you will
# find all and any variables that R is holding in memory for you to use and manipulate. 
# You have created your first variable! X is the variable which contains the information 1!

# If you want to change your variable - you can save over it with the new information

x <- 5

# You might have noticed that the variable changed in your environment - to 5 (not 1). 
# You may also have noticed that instead of using an equals sign we used two symbols 
# together to make an arrow shape < and - (<-)
# This is because in coding the equals sign is often used to make comparisons of things being equal or not equal to each other. 
# To avoid confusion in R we instead use the <- operator to assign value to our variables. 
# You can think of it like an equals sign, or as might be more useful as a direction to "put" the 
# information from the right hand side into the variable which is on the left hand side. 
# i.e. x <- 5 , means put/assign the information of 5 into the variable x. 


# A note on variable naming - do as I say not as I do ...
# In this script I will often name things arbitrarily with names like "x" or "y"
# In reality try to always keep your naming meaninggul but short. 
# For example patient_ID or PID for an identification number
# Variable names cannot (easily) have whitespace and should use "snake_case"
# snake_case is where you join_up_words_using_the_underscore_symbol
# The underscore replaces a white space. 
# Note also that I don't use any uppercase letters, numbers, or symbols in my names
# This is because it makes it harder to recall them and to use them fluently (it can also confuse R)
# If you really like uppercase letters read up about camelCase whereYouUseCaptialLettersLikeThis... 


# The next section will look at introducing you to more complex variables and actions. 

######### 2.0 Manipulating variables ############################################
# At it's core R can function as a very complex calculator.
# You can use standard mathematical notation to carry out these functions

# e.g. x <- 3 + 5
# e.g. x <- 10 - 2
# e.g. x <- 5 * 6
# e.g. x <- 10/2
# e.g. x <- (3+2)*(1+1)

# Can you guess what the results of each of these might be? 
# To check your logic copy them into the console box below one by one and hit enter each time.
# The console is the panel directly below this script by default. 
# The console logs whatever code you are running, but you can also "try out" code there directly. 
# The code will run in the same way and the variables will appear in your environment. 
# Importantly, the difference between the console and a script is that code that you write in the console will be lost
# when you start a new session so if you want to keep code, to run later, save it into a script file instead. 

# You can also  manipulate variables together:
# Run the next three lines of code one by one and see if you can predict what R will do on each line. 

x <- 10
y <- 5*5
z <- x*y 

# Now, this might seem simple, but imagine the utility of doing this kind of operation on whole columns of data.
# Or imagine if you could easily apply these operation to particular parts of a dataset with ease - with R you can. 

# TOP TIP: 
# If you ever want to remove a variable from your environment (maybe you were testing something in the console)
# and you don't need it any more - just use the following code:
# rm(VAR)
# Put the name of the variable you want to remove where VAR is and run the line in the console. 
# If you want to start from scratch use the broom symbol on the top right of your environment to clean up all variables. 
# Make sure you aren't going to lose anything you cant replace when you do so though! 

rm(x)

rm(y, z)

# You can also clean up the logged output in the console using the broom symbol on the top right of that panel too. 

######### 3.0 More complex variables and basic functions ########################

# So far we have had pretty simple things saving into variables - numbers.
# Even if the mathematical operation which leads to that number is more complex, the number is just that - a number!
# Unsurprisingly, R can handle a lot more than just saving one number to one variable. 

#For example: 
x <- "apple"
# R can store words or letters very easily, it calls them strings or character variables. 

#Another example:
x <- c(1,2,3,4,5)

# Here we save a list of numbers into or variable x
# the "c" stands for concatenate, which just means add together
# The commas tell R how to separate out the numbers into individual entries, 
# and the brackets tell the function "c" what the scope of it's job is. 

# In R you will often see a word or symbol directly in front of a set of brackets, these are functions.
# Indeed, c() is a function which tells R what to do with the list of information inside the brackets.
# We saw one earlier on line 102 - rm(), rm stands for "remove", and the brackets show R what it should remove.
# If we wanted to remove more than one variable we would list them and separate them by commas, 
# e.g. rm(x,y,z).
 
# For example; if you ever want to check what type of information is inside a variable you can use special functions to check
# The output of these functions is in the console 
x <- c(2,4,6,8)
class(x) # This function tells us what "class" the information has - here it is numeric
typeof(x) # This function gives us a "subtype" stored in memory - double means it is an ordinary number type

x <- c("apple", "orange", "pear")
class(x)
typeof(x)
# Here the class and subtype are the same, character based information - strings of letters. 

x <- 1L
typeof(x)   # "integer" - a "literal" integer (no decimal places)
class(x)     # "integer"
is.integer(x)  # TRUE

y <- 1
typeof(y)   # "double" - unless specified will be a double
class(y)      # "numeric"
is.integer(y)   # FALSE

1L + 1L         # 2L (stays integer)
1L + 1          # 2 (coerced to double)

# Other functions include things like: sum(), mean(), max(), min()
x <- c(3,56,22,100,38)
sum(x)
mean(x)
max(x)
min(x)

# and some of these individual functions come together in: 
summary(x)

# Again the output of these functions is in your console.
# If you wanted to save the output you would assign it to a variable e.g., y <- sum(x)
# Hopefully you can see how quickly and easily some of the descriptive of your data
# might be available to you with just some basic functions and commands.

# So, what exactly is a function? A piece of code? 
# A function is a chunk of code that does a specific task for you. 
# It can do it as many times as you want, it is a little robot that  just "does"
# - it does exactly what you tell it to do, and nothing more. 

# You can define your own functions in this way: 

double_function <- function(x){ # decide what arguements need to be input
  new_x <- x*2 # do something to those inputs and save the new values
  return(new_x) # return those new values
}

double_function(6) # call the function and give it the input directly, what is output? 

######### 4.0 Bringing back the equals sign ##################################
# Above we moved away from using the equals sign to assign information to variables. 
# Now we will briefly consider why. 

# In programming languages we often use equals signs as part of a true equality statement. 
# That is we are trying to see if two things are equal, that they contain the same information. 
# Their exact use varies across languages, but generally speaking they are not used to assign variables
# that you might want to later modify, instead they are used in arguments that try to assess equality
# and return TRUE or FALSE statements in response to their assessments. 

# For example - if we assign x as follows: 
x <- 5

# We can use a "double equals" sign to check the value of x as follows:
x == 10
x == 5

# We can also check if x does not equal something as follows: 
x != 10
x != 5

# These statements might seem trivial - but image you have a large dataset of patients
# You could use these kinds of statements to find all the rows which contain patients 
# from a particular ward, for example.

# Let's take a toy example:
x <- c(3,4,5,2,2,4,2,6,7,3,4,2,5,2,3,6,2,1,3,4,5,2,5,7,2)

# x now contains 25 numbers, each one representing a patient with a ward number from 1 -7. 
# We can check this is true using the functions summary() and length()
summary(x)
length(x) #if it's not easy to spot in the environment this function is used to see how long a variable is

# Let's say we wanted to pull the data only from those patients who were in a particular ward, 
# can the equals sign help us here? 

# Let's first check what happens if we just check for x == 2 
x == 2

# We get a list of TRUEs and FALSEs 
# we can put these inside a new variable by assigning it using the <- operator
y <- (x==2)
 
# But that doesn't actually capture the information we want, what we want is to pull out the data that
# (in some bigger analysis and bigger dataset) would relate to the ward 2 patients
# for this we could use the subset function, subset():
 
y <- subset(x, x==2)

# Now y contains only the data that related to ward 2 patients. 
# The subset function asks for two pieces of information -
# first the data we want to subset - here that was contained inside x.
# Secondly the identifier for what we want to cut away and put into y - here that is identified by x == 2
# This means that the function looks inside the data in x, pulls out anything that matches the x==2 requirement
# and assigns it inside the new variable of y.

# Another example, this time taking everyone who was not in ward 2 and assigning them to y
y <- subset(x, x!=2)

 
######### 5.0 Mini dataframes - looking at bigger datasets #####################

# In R, dataframes are one of the easiest forms of data object to manipulate. 
# They look and act quite like excel spreadsheets with variable names heading the columns
# and different data listed down in the rows below. 
 
#Let's build a dataframe and play around with it now using the function data.frame()

data <- data.frame( #this functions builds a dataframe with whatever you put inside it
  patient_id = c(1:10), #this line asks the variable to be a number list that goes from 1 to 10, i.e. 1:10
  age = c(24, 36, 18, 66, 39, 42, 38, 23, 54, 92), #this is a list of ages
  gender  = c("F", "M", "M", "M", "F", "NB", "F", "M", "M", "F"), #these are gender labels
  ward = c(1, 7, 6, 2, 6, 2, 7,  2, 2, 1), #this lists which ward the patient was on in the hospital
  discharged = c(1,0,0,0,1,1,0,1,0,0) #this is a binary variable, 1 = discharged, 0 = not yet discharged
)
# AND YES - we do use the equals sign inside this function, I don't make all the rules!
 
# Check in your environment - what did this code do? 
# Click on the new data object, "data" to open it. It will open as a new tab in your screen. 
# What does it look like? Is it how you expected it to be? 
 
# To look at individual columns of data within this data frame we use the $ sign
# For example, if we want to look at age within the dataframe we use:
data$age

# In R - the columns are called fields, and we specify which field we want to look at using the $ sign. 
# Consider it the way to specify precisely what aspect of the dataframe you are interested in. 
# It is how you specify exactly where you want to step into the dataframe further. 
# We could go further again and look for a particular row of that field.

data$age[3] # this gives back the third entry in the age field
# Note here that, unlike when we use Funtions we don't want to have the curled brackets,
# instead square bracket are used to "index into" the column (to find the right row). 
 
# Now - lets try and explore these data knowing everything we do from before:
# Pretend for a moment that this data is hundreds of lines long and you couldn't calculate by hand.
# Try to complete these questions here using your own code - and check your answers against a "by hand"
# calculation to make sure the code worked okay. 
# Once you have tried them - skip down to find my solutions.
 
# What is the mean age of the patients? 
 
# What type of data is the gender variable? 
 
# How many patients are still in the hospital? (this might take more than 1 step, but there are lots of potential solutions)
 
# Can you subset the data so only patients from Ward 2 are represented in a new dataframe? 

 
 
 
 
 
 
 
 
 
# WORKED ANSWERS - don't check these until you have tried them yourself!
 
# What is the mean age of the patients? 
mean(data$age)
#or
summary(data$age)
 
# What type of data is the gender variable? 
class(data$gender) 
#or
typeof(data$gender) #as before both are the same for character strings!

# How many patients are still in the hospital? 
# One way to solve this is to subtract off the number of patients discharged from the total
length(data$patient_id) - sum(data$discharge)

# or we could solve by subsetting the data
inpatient <- subset(data, discharged == 0)
length(inpatient$discharged)

# Can you subset the data so only patients from Ward 2 are represented in a new dataframe variable? 
 ward2 <- subset(data, data$ward==2)
 
 
 
 
 
######### 6.0 Beyond the basics - libraries and plotting #######################
 
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
