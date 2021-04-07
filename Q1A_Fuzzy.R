#install.packages(fuzzywuzzyR)
library(fuzzywuzzyR)
library(readxl)

data <-read_excel(file.choose())

dt = sort(sample(nrow(data), nrow(data)*.7))
train<-data[dt,]
test<-data[-dt,]

#columns =c('Test String', 'Count of Matches', 'Highest Confidence', 'Most Confident String')

newdf=data.frame('Test String'=character(),'Count of Matches'=integer(),'Highest Confidence'=numeric(),'Most Confident String'=character())

init_proc = FuzzUtils$new()      # initialization of FuzzUtils class to choose a processor

PROC = init_proc$Full_process    # processor-method

init_scor = FuzzMatcher$new()    # initialization of the scorer class

SCOR = init_scor$WRATIO          # choosen scorer function

init <- FuzzExtract$new()  

#getting error: attempt to apply non-function
#it is due to incompatible python and python library versions with fuzzywuzzyR library 
#but the logic is same as in python code
for (i in test["Doc Name"]) {
  res=init$Extract(string = i, sequence_strings = toString(as.vector(train["Doc Name"])), processor = PROC, scorer = SCOR)
  newdf <- rbind(newdf, data.frame(i, length(res), res[0][1], res[0][0],stringsAsFactors = FALSE))
}

#it should contain output
View(newdf)
