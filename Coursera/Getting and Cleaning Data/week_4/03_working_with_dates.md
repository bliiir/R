| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Working with Dates](https://www.coursera.org/learn/data-cleaning/lecture/0rohY/working-with-dates) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/04_04_workingWithDates) available on Github as well.

---
## Links
* http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
* http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html

---

# Working with Dates
```r
d1 = date()
d1
```

    [1] "Wed May 23 21:43:55 2018"

```r
class(d1)
```
    [1] "character"

## Date class
```r
d2 = Sys.Date()
d2
```
```r
[1] "2018-05-23"
class(d2)
```
    [1] "Date"

```r
class(d2)
```
    [1] "Date"

## Formatting Dates
```r
format(d2,"%a %b %d")
```
    [1] "Wed May 23"

Means format the date d2 as "abbreviated_weekday abbreviated_month day_as_number"

Here are the possible date formats

| code | result |
| :--- | :--- |
| %d | day as number (0-31) |
| %a | abbreviated weekday |
| %A | unabbreviated weekday |
| %m | month (00-12) |
| %b | abbreviated month |
| %B | unabbrevidated month |
| %y | 2 digit year |
| %Y | four digit year |

## Creating Dates
```r
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z = as.Date(x, "%d%b%Y")
z
```
```
[1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"
```
Read x as: days as number, abbreviated month, four digit year and then print it as a date.

We can then do calculations with the Dates
```r
z[1] - z[2]
```
```
Time difference of -1 days
```

```r
as.numeric(z[1]-z[2])
```
    [1] -1

## Converting to Julian
```r
weekdays(d2)
```
    [1] "Wednesday"
```r
months(d2)
```
    [1] "May"
Or you can get the date attributes using the julian command
```r
julian(d2)
```
    [1] 17674
    attr(,"origin")
    [1] "1970-01-01"

So, d2 is 17674 days after the origin date. (Argh. I am almost that old)

## Lubridate
### Dates

Install Lubridate
```r
install.packages("lubridate")
```
Load the Lubridate library
```r
library(lubridate)
```
Now lets try some stuff with dates
ymd = year month day
```r
ymd("20140108")
```
    [1] "2014-01-08"

```r
mdy("01/08/2014")
```
    [1] "2014-01-08"
```r
dmy("08/01/2014")
```
    [1] "2014-01-08"

### Time

```r
ymd_hms("2014-01-08 10:15:20")
```
```
[1] "2014-01-08 10:15:20 UTC"
```
```r
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
```
    [1] "2011-08-03 10:15:03 NZST"


```r
# Set x to be the a list of dates
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
# use the wday function on the first element of the list
wday(x[1])
```
    [1] 3
```r
wday(x[1],label=TRUE)
```
```
[1] Tue
Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat
```
