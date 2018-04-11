| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Distribution  | [Coursera](https://www.coursera.org) |
| Class          | [Week 2, Storage Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Lecture       |  [Quiz](https://www.coursera.org/learn/data-cleaning/exam/RJBrZ/week-2-quiz) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |

# 1
Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

## Answer
- [x] **2013-11-07T13:25:07Z**
- [ ] 2014-03-05T16:11:46Z
- [ ] 2013-08-28T18:18:50Z
- [ ] 2014-01-04T21:06:44Z

## method

First check out [these intstructions](https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r)

Make sure you have the Authorization callback URL set to http://localhost:1410 for the **oAuth** application on Github.

```r
# Load the httr and httpuv libraries
library(httr)
library(httpuv)
library(jsonlite)

# Store the credentials in an object using the oauth_app() command
myapp <- oauth_app("github", key = "Client ID", secret = "Client Secret")

# Use the oauth2.0_token command  to get a token_secret - this will not work
# if the callbak url isn't set properly or the httpuv library is not loaded
# and you will have to authorize the app out of band first.
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

# Make a request
request1 <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Convert http errors to R errors
stop_for_status(request1)

# Store the content of the request as a list
list1 <- content(request1)

# Convert the list to json in a json object
json1 <- toJSON(list1, pretty = 4)

# Convert the json object to a data frame
df1 <- as.data.frame(fromJSON(json1))

# Find out what the names are in the data frame so you can construct a subset
names(df)

# Store the subset in a new data frame
df2 <- df1[,c("name","created_at")]

# Output the row with where the name is 'datasharing'
df2[df2$name == "datasharing",]
```
Output
```
name           created_at
14 datasharing 2013-11-07T13:25:07Z
```

# 2

The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

Download the American Community Survey data and load it into an R object called

```
acs
```

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

## Answer
- [ ] sqldf("select * from acs")
- [X] **sqldf("select pwgtp1 from acs where AGEP < 50")**
- [ ] sqldf("select * from acs where AGEP < 50 and pwgtp1")
- [ ] sqldf("select pwgtp1 from acs")

## Method

```r
install.packages("sqldf")
library("sqldf")
acs <- read.csv("getdata%2Fdata%2Fss06pid.csv", colClasses = "character")
```
~~Incorrect~~
```r
sqldf("select * from acs")
```
```
[Outputs the entire dataframe]
```
**Correct**
```r
sqldf("select pwgtp1 from acs where AGEP < 50")
```
```
pwgtp1
1   0087
2   0088
3   0094
4   0091
5   0539
6   0192
...
```
~~Incorrect~~

```r
sqldf("select * from acs where AGEP < 50 and pwgtp1")
```

```
[Outputs all rows where AGEP is smaller than 50]
```

~~Incorrect~~

```r
sqldf("select pwgtp1 from acs")
```

```
[Outputs the pwgtp1 column]

pwgtp1
1   0087
2   0088
3   0094
4   0091
5   0539
6   0192
```

# 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

## Answer
- [ ] sqldf("select unique * from acs")
- [ ] sqldf("select distinct pwgtp1 from acs")
- [ ] sqldf("select AGEP where unique from acs")
- [ ] sqldf("select distinct AGEP from acs")

## Method
Equivalence comparison
```r
unique(acs$AGEP)
```
```
 [1] "43" "42" "16" "14" "29" "40" "15" "28" "30" "04" "01" "18" "37" "39" "03" "87" "70" "49" "45" "50" "60" "59" "61" "64" "35" "12" "19"
[28] "31" "09" "00" "33" "32" "20" "88" "53" "58" "69" "68" "48" "24" "27" "74" "56" "75" "17" "38" "55" "26" "23" "86" "81" "77" "07" "51"
[55] "13" "11" "82" "47" "46" "80" "21" "54" "78" "67" "22" "02" "76" "06" "71" "34" "10" "05" "65" "62" "63" "57" "52" "79" "83" "66" "25"
[82] "93" "08" "36" "41" "44" "84" "72" "73" "85" "89"
```

~~Incorrect~~
```r
sqldf("select unique * from acs")
```
```
Error in result_create(conn@ptr, statement) : near "unique": syntax error
```

~~Incorrect~~
```r
sqldf("select distinct pwgtp1 from acs")
```
```
[Outputs the unique values of pwgt1]
pwgtp1
1     0087
2     0088
3     0094
4     0091
5     0539
```

~~Incorrect~~
```r
sqldf("select AGEP where unique from acs")
```
```
Error in result_create(conn@ptr, statement) : near "unique": syntax error
```


**Correct**  
```r
sqldf("select distinct AGEP from acs")
```
```
AGEP
1    43
2    42
3    16
4    14
5    29
...
```

# 4

How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

(Hint: the nchar() function in R may be helpful)

## Answer
- [ ] 43 99 8 6
- [ ] 45 31 7 31
- [ ] 43 99 7 25
- [ ] 45 31 2 25
- [ ] 45 0  2 2
- [ ] 45 92 7 2
- [x] **45 31 7 25**

## Method
```r
# Read the content into a list
my_lines <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")

# Count the charaters in each of the designated lines
nchar(my_lines[c(10,20,30,100)])
```
Output
```
[1] 45 31  7 25
```

# 5

Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for

(Hint this is a fixed width file format)

## Answer

- [X] **32426.7**
- [ ] 222243.1
- [ ] 101.83
- [ ] 28893.3
- [ ] 35824.9
- [ ] 36.5

## Method
```r
# Set the url
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

# Read the lines of the file into a list
lines <- readLines(url)

# Cut the top of the list
lines2 <- lines[4:length(lines)]

# Set the width of each "column" - ie the first 1 is the the first single space before the date on each line
widths1 <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)

# Since I stripped off the column headers I will give them new names so I
# can later subset them
colNames <- c("fi1", "date", "fi2", "n1", "fi3", "n2", "fi4", "n3", "fi5", "n4", "fi6", "n5", "fi7", "n6", "fi8", "n7", "fi9", "n8")

# Use fixed width file to read the list using the widths1 and column header names defined above
df1 <- read.fwf(url, widths1, skip = 4, header = FALSE, col.names = colNames)

# Sum the last column
sum(df1$n3)
```
Output
```
[1] 32426.7
```
