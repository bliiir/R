| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Creating New Data](https://www.coursera.org/learn/data-cleaning/lecture/r6VHJ/creating-new-variables) |
| Week         | [ 3 ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData) available on Github as well.

*Links from the slides are at the bottom of this document*

# Summarizing Data

## Getting the data from the web
```r
# Check of the folder "data" exists, if not, create it
if(!file.exists("./data")){dir.create("./data")}

# Set the file URL
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

# Download the csv file into the data folder
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")

# Read the CSV into R
restData <- read.csv("./data/restaurants.csv")
head(restData)
```

```
name zipCode neighborhood councilDistrict policeDistrict                          Location.1
1                   410   21206    Frankford               2   NORTHEASTERN   4509 BELAIR ROAD\nBaltimore, MD\n
2                  1919   21231  Fells Point               1   SOUTHEASTERN      1919 FLEET ST\nBaltimore, MD\n
3                 SAUTE   21224       Canton               1   SOUTHEASTERN     2844 HUDSON ST\nBaltimore, MD\n
4    #1 CHINESE KITCHEN   21211      Hampden              14       NORTHERN    3998 ROLAND AVE\nBaltimore, MD\n
5 #1 chinese restaurant   21223     Millhill               9   SOUTHWESTERN 2481 frederick ave\nBaltimore, MD\n
6             19TH HOLE   21218 Clifton Park              14   NORTHEASTERN    2722 HARFORD RD\nBaltimore, MD\n
```

## Creating sequences
```r
# Create a vector with a sequence of numbers from 1 to 10 with increments of 2
s1 <- seq(1,10,by=2)
s1
```
```
[1] 1 3 5 7 9
```
```r
# Create a sequence of 3 numbers between 1 and 10
s2 <- seq(1,10,length=3)
s2
```
```
[1]  1.0  5.5 10.0
```
```r
# If you have a vector x and you want to create a sequence of sequential numbers along x
x <- c(1,3,8,25,100)
seq(along = x)
```
```
x <- c(1,3,8,25,100)
seq(along = x)
```

## Subsetting variables
Use the %in% to subset those restaurants that are in the Roland Park and Homeland neighborhoods and then append it to the restData by storing it in restData$nearMe
```r
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
```
Output a table with the True/False counts
```r
table(restData$nearMe)
```
```
FALSE  TRUE
 1314    13
```

## Creating binary variables
Add a variable "zipWrong" to the data frame with the value TRUE if the zipCode variable in the given row is less than 0, if it is 0 or more, add the value FALSE
```r
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
```

Create a table with zipwrong as the rows and zipCode as the columns
```r
table(restData$zipWrong,restData$zipCode < 0)
```
```
        FALSE   TRUE
FALSE   1326    0
TRUE    0       1
```
## Creating categorical variables
Break the zipcodes into groups by using the "cut" command and setting the breaks to be the quantiles of the restData$zipCode variable
```r
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
```
Create a table of the result
```r
table(restData$zipGroups)
```
```
(-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] (2.122e+04,2.123e+04] (2.123e+04,2.129e+04]
                  337                   375                   282                   332
```
Create a table with zipGroups as rows and zipCode as columns
```r
table(restData$zipGroups,restData$zipCode)
```

```
-21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214 21215 21216 21217 21218 21220 21222 21223 21224 21225 21226 21227 21229 21230 21231 21234 21237 21239 21251 21287
(-2.123e+04,2.12e+04]      0   136   201     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
(2.12e+04,2.122e+04]       0     0     0    27    30     4     1     8    23    41    28    31    17    54    10    32    69     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
(2.122e+04,2.123e+04]      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     7    56   199    19     0     0     0     0     0     0     0     0     0     0
(2.123e+04,2.129e+04]      0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0    18     4    13   156   127     7     1     3     2     1
```

## Easier cutting
Load the [Hmisc package](https://cran.r-project.org/web/packages/Hmisc/Hmisc.pdf) which has the cut2 function.
```r
library(Hmisc)
```
Use the cut2 function to break the zipcodes into 4 groups
```r
restData$zipGroups = cut2(restData$zipCode,g=4)
```
Output a table of the result
```r
table(restData$zipGroups)
```
```
[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287]
           338            375            300            314
```

## Creating factor variables
Factors are variables that take on a limited number of values - for example months in the year could be a factor. Since the number of different zipcodes are limited, it is useful to work with the as factors

Store the factors of restData$zipCode in a new column called "zcf"
```r
restData$zcf <- factor(restData$zipCode)
```
Now print rows of the zcf variable to the console
```r
restData$zcf[1:10]
```
```
[1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
Levels: -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214 21215 21216 21217 21218 21220 21222 21223 21224 21225 21226 21227 21229 21230 21231 21234 21237 21239 21251 21287
```
Note that R tells me that there are 32 levels in total.

Check what class the zcf variable is
```r
class(restData$zcf)
```
```
[1] "factor"
```

## Levels of factor variables
Create a vector with a random set of "yes" and "no" values.
```r
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
```
Store yesno as a factor in a new variable yesnofac with "yes" as the lowest level (R value that is first in the alphabet as the lowest level in the factor by default, but I can manually override that by setting the levels attribute)
```r
yesnofac = factor(yesno,levels=c("yes","no"))
yesnofac
```
```
[1] yes no  yes yes no  no  no  yes yes yes
Levels: yes no
```
I can alter the level sequence using the relevel command
```r
relevel(yesnofac,ref="no")
```
```
[1] yes no  yes yes no  no  no  yes yes yes
Levels: no yes
```
Change the factor into a numeric value
```r
as.numeric(yesnofac)
```
```
 [1] 1 2 1 1 2 2 2 1 1 1
```

## Cutting produces factor variables
When using the cut command, R creates Factors
```r
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
class(restData$zipGroups)
```
```
[1] "factor"
```

## Using the mutate function
```r
library(Hmisc)
library(plyr)

# Create a new data frame with a new column called zipGroups by applying the
# mutate function with the cut2 command inside to the restData data frame
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))

Print the new column from the new data frame to the console
table(restData2$zipGroups)
```
```
[-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287]
           338            375            300            314
```

## Common transforms

```r
abs(x) absolute value
sqrt(x) square root
ceiling(x) ceiling(3.475) is 4
floor(x) floor(3.475) is 3
round(x,digits=n) round(3.475,digits=2) is 3.48
signif(x,digits=n) signif(3.475,digits=2) is 3.5
cos(x), sin(x) etc.
log(x) natural logarithm
log2(x), log10(x) other common logs
exp(x) exponentiating x
```

---

#### Links from the video
* https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
* http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
* http://statmethods.net/management/functions.html

#### Notes and Further Reading
* A tutorial from the developer of plyr - http://plyr.had.co.nz/09-user/
* Andrew Jaffe's R notes http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
* A nice lecture on categorical and factor variables http://www.stat.berkeley.edu/classes/s133/factors.html
