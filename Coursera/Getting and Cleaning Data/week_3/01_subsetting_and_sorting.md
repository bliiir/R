| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Subsetting and Sorting](https://www.coursera.org/learn/data-cleaning/lecture/aqd2Y/subsetting-and-sorting) |
| Class         | [Week 3, ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the material available on Github ([here](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData)) as well.

*Links from the slides are at the bottom of this document*

# Subsetting and Sorting

## Subsetting - quick review
Input
```r
# Set seed to be able to reproduce later
set.seed(13435)

# Create a data frame with three variables and random values
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X
```
```
    var1 var2 var3
1    3   10   14
2    5    8   11
3    4    9   15
4    1    6   13
5    2    7   12
```
```r
# Scramble the rows
X <- X[sample(1:5),]
X
```
```
    var1 var2 var3
3    4    9   15
5    2    7   12
2    5    8   11
4    1    6   13
1    3   10   14
```
```r
# Make the values in row 1 and 3 of the the var2 column NA
X$var2[c(1,3)] = NA
X
```
```
    var1 var2 var3
3    4   NA   15
5    2    7   12
2    5   NA   11
4    1    6   13
1    3   10   14
```

```r
# Subset the first column
X[,1]
```
```
[1] 4 2 5 1 3
```

```r
# Subset the same column by its name
X[,"var1"]
```
```
[1] 4 2 5 1 3
```
```r
# Subset the same column by its name using the $ delimeter instead
X$var1
```
```
[1] 4 2 5 1 3
```
```r
# Subset the first row of the second/"var2" column
X[1:2,"var2"]
```
```
[1] NA  7
```
```r
# Subset the first row of the second/"var2" column
X[1,"var2"]
```
```
[1] NA  7
```
Interestingly that returns a vectore, the reason being that there is only one dimension I assume. Also noteworthy is that the first two columns are the original rows 3 and 5 before I scrambled them above and if I output the first two rows and 2nd and 3rd columns, I can see that to be true:
```r
X[1:2,c("var2", "var3")]
```
```
    var2 var3
3   NA   15
5    7   12
```
## Logical ANDs and ORs
Find all the rows of X where var1 <= 3 AND var3 > 11
```r
X[(X$var1 <= 3 & X$var3 > 11),]
```
```
    var1 var2 var3
5    2    7   12
4    1    6   13
1    3   10   14
```
Find all the rows where var1 is smaller than or equal to 3 OR var3 is bigger than 15
```r
X[(X$var1 <= 3 | X$var3 > 15),]
```
```
    var1 var2 var3
5    2    7   12
4    1    6   13
1    3   10   14
```
## Dealing with missing values
Subset the rows with values larger than 8 - and importantly do not include NAs
```r
X[which(X$var2 > 8),]
```
```
var1 var2 var3
1    3   10   14
```

## Sorting
```r
Sort var1, defaults to ascending
sort(X$var1)
```
```
[1] 1 2 3 4 5
```
Sort var1 descending
```r
sort(X$var1,decreasing=TRUE)
```
```
[1] 5 4 3 2 1
```
Sort var2 ascending with the NAs last
```r
sort(X$var2,na.last=TRUE)
```
```
[1]  6  7 10 NA NA
```

## Ordering
Order the data frame using the var1 variable as sorting criteria
```r
X[order(X$var1),]
```
```
var1 var2 var3
4    1    6   13
5    2    7   12
1    3   10   14
3    4   NA   15
2    5   NA   11
```
Order by multiple variables
```r
X[order(X$var1,X$var3),]
```
```
var1 var2 var3
4    1    6   13
5    2    7   12
1    3   10   14
3    4   NA   15
2    5   NA   11
```


## Ordering with plyr

```r
# Load plyr
library(plyr)

# Use arrange(plyrs version of sort) to sort
arrange(X,var1)
```
```
var1 var2 var3
1    1    6   13
2    2    7   12
3    3   10   14
4    4   NA   15
5    5   NA   11
```
Same but descending
```r
arrange(X,desc(var1))
```

```
var1 var2 var3
1    5   NA   11
2    4   NA   15
3    3   10   14
4    2    7   12
5    1    6   13
```

## Adding rows and columns

Add a new column
```r
X$var4 <- rnorm(5)
X
```

```
var1 var2 var3       var4
3    4   NA   15  0.5439561
5    2    7   12  0.3304796
2    5   NA   11 -0.9710917
4    1    6   13 -0.9446847
1    3   10   14 -0.2967423
```
Or create a new data frame Y by using the cbind command on X
```r
Y <- cbind(X,rnorm(5))
Y
```

```
var1 var2 var3       var4   rnorm(5)
3    4   NA   15  0.5439561  1.1495053
5    2    7   12  0.3304796 -0.8705105
2    5   NA   11 -0.9710917 -0.9870139
4    1    6   13 -0.9446847  0.3262530
1    3   10   14 -0.2967423 -1.1025739
```
Note - rbind is not permanent so
```r
cbind(X,rnorm(5))
```
Will return same as above
```
var1 var2 var3       var4   rnorm(5)
3    4   NA   15  0.5439561  1.1495053
5    2    7   12  0.3304796 -0.8705105
2    5   NA   11 -0.9710917 -0.9870139
4    1    6   13 -0.9446847  0.3262530
1    3   10   14 -0.2967423 -1.1025739
```
But then X will return
```r
X
```
```
var1 var2 var3       var4
3    4   NA   15  0.5439561
5    2    7   12  0.3304796
2    5   NA   11 -0.9710917
4    1    6   13 -0.9446847
1    3   10   14 -0.2967423
```
Because the bind wasn't permanent

---

Andrew Jaffe's lecture notes http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
