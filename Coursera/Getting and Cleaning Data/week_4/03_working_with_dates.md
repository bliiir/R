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
