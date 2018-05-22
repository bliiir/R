| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Managing Data Frames with dplyr](https://www.coursera.org/learn/data-cleaning/lecture/sXF4A/managing-data-frames-with-dplyr-introduction) |
| Week          | [ 3 ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Roger D. Peng - PhD](https://github.com/rdpeng) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/03_04_reshapingData) available on Github as well.

*Links from the slides are at the bottom of this document*

# Managing Data Frames with dplyr

## Introduction
* One observation per row
* Each column = variable/measure/characteristic

---

### dplyr verbs

```select``` returns a subset of the COLUMNS  
```filter``` returns a subset of the ROWS  
```arrange``` reorders ROWS  
```rename``` renames variables / COLUMNS  
```mutate``` adds new COLUMNS or transform existing  
```summarize``` generates summary stats of different variables  
```print``` Prints a censored output to the console  

---

### dplyr Properties
| dplyr functions     |      |
| :------------- | :------------- |
| First argument | The data frame to treat |
| Subsequent arguments | The treatment |
| Result | Resulting data frame |

Data frames must be properly formatted and annotated

---

## Basic tools

Load the ```dplyr``` package
```r
library(dplyr)
```

### Select
Select columns

Load the chicago.rds dataset
```r
chicago <- readRDS("chicago.rds")
```
Chech the data frames dimensions

```r
dim(chicago)
```
```
[1] 6940    8
```
Check the structure of the data frame
```r
str(chicago)
```
```
'data.frame':	6940 obs. of  8 variables:
 $ city      : chr  "chic" "chic" "chic" "chic" ...
 $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
 $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
 $ date      : Date, format: "1987-01-01" "1987-01-02" "1987-01-03" "1987-01-04" ...
 $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
 $ pm10tmean2: num  34 NA 34.2 47 NA ...
 $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
 $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...
 ```
 Get the names of the variables in the data frame
```r
names(chicago)
```
```
"city"       "tmpd"       "dptp"       "date"       "pm25tmean2" "pm10tmean2" "o3tmean2"   "no2tmean2"
```
print out the columns from city to dptp using the ":" sign to signify range (x:y would mean the range from x to y).

```r
head(select(chicago, city:dptp))
```

```
city tmpd   dptp
1 chic 31.5 31.500
2 chic 33.0 29.875
3 chic 33.0 27.375
4 chic 29.0 28.625
5 chic 32.0 28.875
6 chic 40.0 35.125
```

Use the minus sign to select all columns except the city to dptp columns
```r
head(select(chicago, -(city:dptp)))
```
```
1 1987-01-01         NA   34.00000 4.250000  19.98810
2 1987-01-02         NA         NA 3.304348  23.19099
3 1987-01-03         NA   34.16667 3.333333  23.81548
4 1987-01-04         NA   47.00000 4.375000  30.43452
5 1987-01-05         NA         NA 4.750000  30.33333
6 1987-01-06         NA   48.00000 5.833333  25.77233
```

The equivalent in regular R (without dplyr) is
```r
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])
```

---

### Filter
Filter rows

Take all the rows in the chicago dataset where pmt25tmean2 is bigger than 30 and tmpd is bigger than 80
```r
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
```
Now print the first ten lines of the first three columns, pmt25tmean2 and tmpd from chick.f
```r
head(select(chic.f, 1:3, pm25tmean2, tmpd), 10)
```

```
city tmpd dptp pm25tmean2
1  chic   81 71.2    39.6000
2  chic   81 70.4    31.5000
3  chic   82 72.2    32.3000
4  chic   84 72.9    43.7000
5  chic   85 72.6    38.8375
6  chic   84 72.6    38.2000
7  chic   82 67.4    33.0000
8  chic   82 63.5    42.5000
9  chic   81 70.4    33.1000
10 chic   82 66.2    38.8500
```

As you can see, one of the first three columns is the tmpd, so R just ignores the tmpd attribute in the last entry. In other words we would get the same result with:
```r
head(select(chic.f, 1:3, pm25tmean2), 10)
```
Or:
```r
head(select(chic.f, 1,3, pm25tmean2, tmpd), 10)
```
Except for the sequence in this case where R uses the sequence of the entry to arrange the columns

### Arrange
Sort rows

Order the rows according to the data variable/column - basically sorting
```r
chicago <- arrange(chicago, date)
```
Output the head to the console
```r
head(select(chicago, date, pm25tmean2), 3)
```
```
    date        pm25tmean2
1   1987-01-01  NA
2   1987-01-02  NA
3   1987-01-03  NA
```

Output the tail to the console
```r
tail(select(chicago, date, pm25tmean2), 3)
```
```
        date        pm25tmean2
6938    2005-12-29  7.45000
6939    2005-12-30  15.05714
6940    2005-12-31  15.00000
```

Arrange in descending order
```r
# Arrange in descending order
chicago <- arrange(chicago, desc(date))

# Print out the head
head(select(chicago, date, pm25tmean2), 3)
```
```
    date            pm25tmean2
1   2005-12-31      15.00000
2   2005-12-30      15.05714
3   2005-12-29      7.45000
```
```r
# Print out the tail
tail(select(chicago, date, pm25tmean2), 3)
```
```
        date        pm25tmean2
6938    1987-01-03  NA
6939    1987-01-02  NA
6940    1987-01-01  NA
```

### Rename
Change the name of (a) column(s)

Apparently it is hard to rename in R without using dplyr. Here is how you do it with dplyr.
```r
# First lets just check out the chicago data frame
head(chicago[, 1:5], 3)
```
```
city tmpd dptp       date pm25tmean2
1 chic   35 30.1 2005-12-31   15.00000
2 chic   36 31.0 2005-12-30   15.05714
3 chic   35 29.4 2005-12-29    7.45000
```
Ok - lets give the columns some better names and print out the result.
```r
chicago <- rename(chicago, pm25 = pm25mean2, dewpoint = dptp)
```
```
    city    tmpd    dewpoint    date        pm25
1   chic    31.5    31.500      1987-01-01  NA
2   chic    33.0    29.875      1987-01-02  NA
3   chic    33.0    27.375      1987-01-03  NA
```

The same thing could be done in regular R like this:
```r
names(chicago) <- c("city", "tmpd", "dewpoint", "date", "pm25", "pm10tmean2", "o3tmean2", "no2tmean2")
```
Or you can replace a single column name like this:
```r
names(chicago)[names(chicago) == "pm10tmean2"] <- "pm10"
```
Or this:
```r
colnames(chicago)[names(chicago) == "o3tmean2"] <- "o3"
```

### Mutate
Alter the content of a column or add a new one content based on existing rows

Transform or create new variables
```r
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
> head(chicago)
```

```
    city    tmpd    dewpoint    date        pm25 pm10tmean2     o3tmean2    no2tmean2   pm25detrend
1   chic    31.5    31.500      1987-01-01  NA  34.00000        4.250000    19.98810    NA
2   chic    33.0    29.875      1987-01-02  NA  NA              3.304348    23.19099    NA
3   chic    33.0    27.375      1987-01-03  NA  34.16667        3.333333    23.81548    NA
4   chic    29.0    28.625      1987-01-04  NA  47.00000        4.375000    30.43452    NA
5   chic    32.0    28.875      1987-01-05  NA  NA              4.750000    30.33333    NA
6   chic    40.0    35.125      1987-01-06  NA  48.00000        5.833333    25.77233    NA
```
```r
head(select(chicago, pm25, pm25detrend))
```

```
    pm25        pm25detrend
1   15.00000    -1.230958
2   15.05714    -1.173815
3   7.45000     -8.780958
4   17.75000    1.519042
5   23.56000    7.329042
6   8.40000     -7.830958
```

### Group_by

Add a new column/variable to the chicago data frame and fill it with a factor that shows hot if tmpd is warmer than 80 and cold if it is lower than or equal to 80
```r
chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
```
```r
hotcold <- group_by(chicago, tempcat)
```
```r
hotcold
```

```
    city    tmpd    dewpoint    date        pm25        pm10tmean2  o3tmean2    no2tmean2   pm25detrend tempcat
1   chic    35      30.1        2005-12-31  15.00000    23.5        2.531250    13.25000    -1.230958   cold
2   chic    36      31.0        2005-12-30  15.05714    19.2        3.034420    22.80556    -1.173815   cold
3   chic    35      29.4        2005-12-29  7.45000     23.5        6.794837    19.97222    -8.780958   cold
4   chic    37      34.5        2005-12-28  17.75000    27.5        3.260417    19.28563    1.519042    cold
5   chic    40      33.6        2005-12-27  23.56000    27.0        4.468750    23.50000    7.329042    cold
6   chic    35      29.6        2005-12-26  8.40000     8.5         14.041667   16.81944    -7.830958   cold
```

```r
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))
```

```
# A tibble: 3 x 4
    tempcat     pm25    o3      no2
    <fct>       <dbl>   <dbl>   <dbl>
1   cold        16.0    66.6    24.5
2   hot         26.5    63.0    24.9
3   NA          47.7    9.42    37.4
```

Now summarize for each year.

First create a new variable in the chicago data frame called "year" using the values in the "date" column
```r
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
```
Now create a new data frame called years from the chicago data frame grouping by the year column we created above
```r
years <- group_by(chicago, year)
```
```
# A tibble: 6,940 x 11
# Groups:   year [19]
   city   tmpd dewpoint date        pm25 pm10tmean2 o3tmean2 no2tmean2 pm25detrend tempcat  year
   <chr> <dbl>    <dbl> <date>     <dbl>      <dbl>    <dbl>     <dbl>       <dbl> <fct>   <dbl>
 1 chic    35.     30.1 2005-12-31 15.0       23.5      2.53      13.2       -1.23 cold    2005.
 2 chic    36.     31.0 2005-12-30 15.1       19.2      3.03      22.8       -1.17 cold    2005.
 3 chic    35.     29.4 2005-12-29  7.45      23.5      6.79      20.0       -8.78 cold    2005.
 4 chic    37.     34.5 2005-12-28 17.8       27.5      3.26      19.3        1.52 cold    2005.
 5 chic    40.     33.6 2005-12-27 23.6       27.0      4.47      23.5        7.33 cold    2005.
 6 chic    35.     29.6 2005-12-26  8.40       8.50    14.0       16.8       -7.83 cold    2005.
 7 chic    35.     32.1 2005-12-25  6.70       8.00    14.4       13.8       -9.53 cold    2005.
 8 chic    37.     35.2 2005-12-24 30.8       25.2      1.77      32.0       14.5  cold    2005.
 9 chic    41.     32.6 2005-12-23 32.9       34.5      6.91      29.1       16.7  cold    2005.
10 chic    22.     23.3 2005-12-22 36.6       42.5      5.39      33.7       20.4  cold    2005.
```
Now summarize the data in the year data frame
```r
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2, na.rm = TRUE), no2 = median(no2tmean2, na.rm = TRUE))
```
```
# A tibble: 19 x 4
    year  pm25    o3   no2
   <dbl> <dbl> <dbl> <dbl>
 1 1987. NaN    63.0  23.5
 2 1988. NaN    61.7  24.5
 3 1989. NaN    59.7  26.1
 4 1990. NaN    52.2  22.6
 5 1991. NaN    63.1  21.4
 6 1992. NaN    50.8  24.8
 7 1993. NaN    44.3  25.8
 8 1994. NaN    52.2  28.5
 9 1995. NaN    66.6  27.3
10 1996. NaN    58.4  26.4
11 1997. NaN    56.5  25.5
12 1998.  18.3  50.7  24.6
13 1999.  18.5  57.5  24.7
14 2000.  16.9  55.8  23.5
15 2001.  16.9  51.8  25.1
16 2002.  15.3  54.9  22.7
17 2003.  15.2  56.2  24.6
18 2004.  14.6  44.5  23.4
19 2005.  16.2  58.8  22.6
```

### %>%
dplyr implements a new operator called the pipeline operator. It allows you to feed the result of one operation into the next segment separated by the pipeline operation %>%

```r
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2, na.rm = TRUE), no2 = median(no2tmean2, na.rm = TRUE))
```
This one statement above does all the stuff we did above in several statements

```
# A tibble: 12 x 4
   month  pm25    o3   no2
   <dbl> <dbl> <dbl> <dbl>
 1    1.  17.8  28.2  25.4
 2    2.  20.4  37.4  26.8
 3    3.  17.4  39.0  26.8
 4    4.  13.9  47.9  25.0
 5    5.  14.1  52.8  24.2
 6    6.  15.9  66.6  25.0
 7    7.  16.6  59.5  22.4
 8    8.  16.9  54.0  23.0
 9    9.  15.9  57.5  24.5
10   10.  14.2  47.1  24.2
11   11.  15.2  29.5  23.6
12   12.  17.5  27.7  24.5
```


---
