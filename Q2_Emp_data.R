#install.packages("readxl")
library("readxl")
  
#function to read all sheets oexcel file
read_excel_allsheets <- function(filename, tibble = FALSE) {
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}

mysheets <- read_excel_allsheets(file.choose())

#clubbing the data
df1=data.frame(mysheets$IT)
df2=data.frame(mysheets$Admin)
df3=data.frame(mysheets$Support)

df4=merge(df1, df2, all.x = TRUE,all.y = TRUE)

df5=merge(df4, df3, all.x = TRUE,all.y = TRUE)

df5=df5 %>% distinct(df5$Name,df5$Dept,df5$Salary, .keep_all = TRUE)

#install.packages("dplyr")
library("dplyr")
#grouping by department and showing salary range along with counts
by_dep=df5 %>% group_by(Dept) %>% 
  summarise(Salary_Range = paste(min(Salary)," to ",max(Salary)),
            Num_of_Employees = n(),)


