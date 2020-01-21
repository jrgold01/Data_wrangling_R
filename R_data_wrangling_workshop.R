##################################
########### Intro to R ###########
#################################

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Panes 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Source: script editor, like a do-file

# Files/Plots/Packages/Help/Viewer: exactly what it says. Files shows your file directory. Packages list the packages you have installed (and those you have currently loaded). Help is really helpful

#Environment/History: History is a list of things you've run today. Environment shows any objects you've loaded/created, as well as functions you've written. Kind of similar to STATAs variable window... except you can have more complex data types in R compared to STATA

# Console: The output. A carrot ( > ) line means it's ready to run code

# You can rearange your panes if you want (View -> Panes -> Pane Layout) (also in Global Options)
# You can also change the color so R Studio isn't so white - Global Options -> Appearance

# Soft-wrap text in source: Global Options/RStudio -> Preferences -> Code -> Soft Wrap R Source

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### R Basics
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# R is a vectorised language, so all objects read into your environemnt appear in some form of a vector - either a single vector, as a data frame (of vectors), a list of vectors (or data frames), etc. The ways vectors can be organized can get complex, but at their core there will always be vectors of... something.

# R reads commands in REPL: read evaluate print loop - reads the command and parses it (sort of like grammer, does it make sense), then it evaluates, prints the results, and reads the next command (loop). Most errors you will get are from the read/parse stage or the evaluate stage - usually a typing or syntax error. 


## Let's make and object, x with a value of 3
x <- 3
x
## What are some characteristics of this object, x, we just created?
class(x) #EXPLAIN CLASSS and data types
length(x)

## Let's make a maybe more interesting object that is a vector of numbers, and call it y
y <- c(1, 3, 3, 5, 6, 10, 10, 12)
y
## What are some characteristics of this object, y?
class(y)
length(y)
str(y)
## What if we have some specific questions about what is in y... notice that the printed answer refers to vector location (index) and not actual value
which(y == 6)
which(y > 5)
## How can we extract certain parts of the data in y to work with? Indexing!
y[2:3]
z <- y[2:3]
y[which(y>5)]
unique(y)
length(unique(y)) # nesting commands - useful and do-able

## We can do those same things with other classes of data - you'll likely encounter character vectors at some point
a <- "cat"
class(a)

b <- c("cat", "dog", "bird", "cat")
str(b)
unique(b)
which(b == "bird")
which(b == c("bird", "dog"))
length(which(b == c("bird", "dog")))
b[3:4]

## So far we've made a few vectors of different classes - but most actual data you'll use will be in a more complex format (often data frames - think spreadsheet, or Stata data format). Just remember, at it's core, R thinks of these as some amalgamation of vectors. For a data frame with columns and rows, the columns are a series of binded vectors - so as Matt will show with some data in  minute, you use these same indexing tools (plus a few more) to access those parts of your data. 
## Unlike Stata, R is much more flexible with data and can go way beyond the data frame format (although that's still the most common format many of us will work with). You can work with matrices, network objects, text corpora, and beyond. A useful one to know right now is the list - I'll show you how to make a list of vectors - but you can make a list of anything (even multiple data frames)

## First, make a few objects you want to be in a list together
x <- c(1, 24, 4, 6, 1, 2, 90, 65, 56, 8)
y <- c(4, 3, 6, 83, 2 , 8, 38, 56)
z <- c(56, 3, 90, 10, 3, 2)

a <- list(x, y, z) #make those three vectors into a list
## Let's explore that list 
str(a)
length(a)
## Let's use indices to get to parts of that list
class(a[1])
class(a[[1]])
length(a[2])
length(a[[2]])

## One of the great things about lists is you can use the various "apply" functions in R to loop a command over all objects in your list - which will ouput a new list of the same length. These are really useful when you start writing your own functions... a topic for another R workshop

b <- lapply(a, function(x) x[which(x>10)])
b



# Environments are just big collections of variables and elements (values) - your first environment will always be the global environment (which in R studio you can see in the pane), but there are others already loaded, and when you load packages (with "library()") they will showup in your search path. Generally you won't need to know what the order of the environments are, but some packages have the same names for functions - and it is the case where you have two packages loaded in your search path with the same function names, R will use the package listed first in your search path
search()

install.packages("foreign") 
library(foreign)
search()


# Before we move onto the next section - if you ever need to clear your environment - fully or partially:
rm(x) #this just removes "x" from your global environment
rm(list = ls()) #this removes EVERYTHING from your global environment


#########################################
########### Working with Data ###########
#########################################

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Read In Data ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Once you set a working directory, you do not need to specify the path when loading or saving files

#Load Lemas data into R
lemas <- read.csv (file = "data/lemas.csv", stringsAsFactors = FALSE)
#assigns the data file to a data frame I named lemas. I told it that characters need to be preserved as character data instead of as categorical data

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Exploring Data ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

names (lemas)
#Use this to get a list of the names of all the columns in your dataframe

dim(lemas)
#use this to ask for a report of the dimensions of the dataframe: rows by columns

nrow (lemas)
ncol (lemas)
#Does the same thing, one at a time

View (lemas)
#Opens a window that shows a spreadsheet view of your dataframe or any R object you ask for

class (lemas)
class (lemas$ORI9)
class (lemas$TYPE)
class (lemas$POP2012)
#Reports format of data in a column, different classes have different properties

unique (lemas$STATENAME)
unique (lemas$STATECODE)
unique (lemas$TYPE)
#Reports the unique values within a column

#Indexing
#Use [] to ask for/tell R where to look for values
#Can separate by column and row
#[,#] A number after a comma tells R which column
#[#,] A number before a comma tells R which row
#Can also use names instead of numbers (especially for columns)
#[-] Can use a hyphen to tell it what you don't want
#[c] Use c to tell R to combine multiple arguments 
lemas [1] #gets you all the values within the first column
lemas [,1] #also gets you the values within the first column
lemas [1,] #gets you all the values in the first row
lemas [10] #tenth column
lemas [2:3] #gets the values in columns 2-3
lemas [c(1,3:17)] #gets the values in columns 1 and 3-17
lemas [-2] #gets the values in all columns except 2 (1 and 3-17)
lemas [,"CITY"] #gets you the values within the column named "CITY"

#Filtering Data using indexing
ca <- lemas[lemas$STATECODE=="CA",]
#makes a new dataframe of the data in lemas, but only when the statecode column is equal to "ca"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Read In Data Part 2 ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Load Ursus data into R
#Ursus file is in .dta (Stata format)
#Install and load the "foreign" package to be able to read Stata, SPSS, or SAS format files
install.packages("foreign")
library (foreign)

ursus <- read.dta ("data/ursus.dta")
View (ursus)
#If you want to use R to convert Stata, SPSS, or SAS files into a more flexible format, first read it in, then use write.csv to save as a .csv file
write.csv (ursus, file = "data/ursus.csv")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Merging Dataframes ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Merging Data
?merge

#Select the columns in each dataframe to use to match observations
#Each data set has one column that contains an identifier for each row: ORI
#Each police department in the US gets a unique ORI code
ca$ORI9 [1:20]
ursus$ori_x[1:20]
#This lets us see the first twenty observations of ORI codes in each dataframe
#Notice the case of letters does not match, we need to fix this in order to merge the dataframes by ORI

ca$ORI9 <- tolower(ca$ORI9)
#makes all characters in the object lowercase
ca$ORI9 [1:20]

data <- merge (ursus, ca, by.x= "ori_x", by.y= "ORI9", all.x = FALSE, all.y = TRUE)
#Tells R to create a new dataframe named "data" by merging the two data sets "ursus" (x) and "ca" (y), 
#then states the columns in each dataframe that show how to match,
#then tells R to get rid of rows in the "ursus" dataframe that do not also have data in the "ca" dataframe
View (data)

write.csv (data, file = "fulldataset.csv")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Dataframe Manipulation and Data Cleaning ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Find the percent of officers that are male
class (data$FTSWORN) #Count of full time officers in the department
class (data$PERS_PDSW_MFT) #Count of full time male officers in the department

data$FTSWORN [1:20]#Returns the values for the first twenty rows
data$PERS_PDSW_MFT [1:20]

#Use these two to make a single variable of the percent of full time officers that are male
data$percentmale <- data$PERS_PDSW_MFT/data$FTSWORN*100
#Can place variables in mathematical operations
data$percentmale [1:20]

#Find the percent of officers that are non-white
class (data$PERS_FTS_WHT)
data$PERS_FTS_WHT [1:20]

#Use these two to make a single variable of the percent of full time officers that are non-white
data$percentnonwhite <- 100-(data$PERS_FTS_WHT/data$FTSWORN*100)
data$percentnonwhite [1:20]

#Mathematical transformation: take the log of the local population
class (data$POP2012)
data$POP2012 [1:20]
data$logpop2012 <- log(data$POP2012)
data$logpop2012 [1:20]

#Change the class of a column
class (data$PAY_BARG)
data$PAY_BARG <- as.factor(data$PAY_BARG)
class (data$PAY_BARG)

#Also convert type of agency
data$TYPE = factor(data$TYPE, levels = c(1,2,3), labels = c("City", "County", "State"))

#Rename a column
#Rename PAY_BARG to cba
names (data) [names(data)=="PAY_BARG"] <-"cba"
names (data)
class (data$cba)

#################################################
########### Exploratory Data Analysis ###########
#################################################

# Summary
## The summary command will give you the 5 number summary of a vector
### numerical
summary(data$PAY_SAL_EXC_MAX)

### categorical
summary(data$TYPE)

## you can also give summary a subset of a dataframe
summary(data[ , c("PAY_SAL_EXC_MAX", "PAY_SAL_EXC_MIN", "PAY_SAL_OFCR_MAX", "PAY_SAL_OFCR_MIN", "PAY_SAL_SGT_MAX", "PAY_SAL_SGT_MIN")])

# Table
## Table will show table of unique values, simmilar to STATA tabulate
table(data$CITY)

### This is a mess, re-factor
data$CITY = factor(data$CITY)
table(data$CITY)

## you can aslo do crosstabs
table(data$CITY, data$TYPE)

# Correlations
## first we subset to whatever varaibles we want correlations for
cor.matrix = data[, c("POP2012", "PAY_SAL_EXC_MAX", "PAY_SAL_EXC_MIN", "PAY_SAL_OFCR_MAX", "PAY_SAL_OFCR_MIN")]

## do make a correlation matrix of data
cor(cor.matrix)

## no dice, missing data. Just use complete for now
cor(cor.matrix, use = "complete.obs")

# Plots

## Scatter
plot(data$PAY_SAL_EXC_MAX, data$PAY_SAL_OFCR_MAX, main = "Executive and Officer Max Pay", xlab = "Executive", ylab = "Officer")

## Barplot
plot(data$TYPE, main = "Type of Agency in California")

## Whisker
boxplot(data$PAY_SAL_OFCR_MAX~  data$TYPE, main = "Officer Max Salary by Department Type", xlab = "Type", ylab = "Officer Max Salary") 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### OLS ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# OLS Regression
data.lm = lm(avginjury ~ POP2012 + cba, data = data)

# see results
summary(data.lm)

# set it so we can see 4 plots at once
par(mfrow=c(2,2))

# plot; hit the zoom button above the viewer in the lower right to see things better
plot(data.lm)
# Plot 1. Residuals vs. ﬁtted This plots the ﬁtted (yb) values against the residuals. Look for spread around the line y = 0 and no obvious trend.
# Plot 2. Normal qqplot The residuals are normal if this graph falls close to a straight line.
# Plot 3. Scale-Location This plot shows the square root of the standardized residuals. The tallest points, are the largest residuals.
# Plot 4. Cook’s distance This plot identiﬁes points which have a lot of inﬂuence in the regression line.

# return plotting to 1 at a time
par(mfrow=c(1,1))
