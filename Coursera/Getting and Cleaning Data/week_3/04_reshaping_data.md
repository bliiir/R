| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Reshaping Data](https://www.coursera.org/learn/data-cleaning/lecture/lWnzm/reshaping-data?authMode=login) |
| Week          | [ 3 ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/03_04_reshapingData) available on Github as well.

*Links from the slides are at the bottom of this document*

# Reshaping Data
---
## Start with Reshaping
```r
# Load the reshape library
library(reshape2)

# Print the head of the mtcars data set
head(mtcars)
```

```
                    mpg     cyl disp    hp      drat    wt      qsec    vs  am  gear carb
Mazda RX4           21.0    6   160     110     3.90    2.620   16.46   0   1   4    4
Mazda RX4 Wag       21.0    6   160     110     3.90    2.875   17.02   0   1   4    4
Datsun 710          22.8    4   108     93      3.85    2.320   18.61   1   1   4    1
Hornet 4 Drive      21.4    6   258     110     3.08    3.215   19.44   1   0   3    1
Hornet Sportabout   18.7    8   360     175     3.15    3.440   17.02   0   0   3    2
Valiant             18.1    6   225     105     2.76    3.460   20.22   1   0   3    1
```
---
## Melting data frames
Add a column to the data frame called "carname" and fill it with the rownames of the dataset
```r
mtcars$carname <- rownames(mtcars)
```
Now we are going to use the 'melt' command to reshape the data.
The first parameter is 'mtcars' - the dataset we are going to reshape. The next parameter is a vector defining which columns we want to keep from the mtcars data frame. The next parameter is what we want to 'melt' - what will happen is that the melt command will make a column for the variables mpg and hp and another column for their values
```r
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
```
```
    carname         gear    cyl     variable    value
1   Mazda RX4       4       6       mpg         21.0
2   Mazda RX4 Wag   4       6       mpg         21.0
3   Datsun 710      4       4       mpg         22.8
```
So, instead of an mpg column with various values and a hp column with various values, we now have a 'variable' column that has the values mpg or hp and another column with the values corresponding. This makes the data frame taller.
```r
tail(carMelt,n=3)
```
```
carname gear cyl variable value
62  Ferrari Dino    5   6       hp   175
63 Maserati Bora    5   8       hp   335
64    Volvo 142E    4   4       hp   109
```
http://www.statmethods.net/management/reshape.html

---

## Casting data frames
Now that we have melted the mtcars data frame, we can re-cast it in differrent ways.
We will use the dcast command on the carMelt dataset to create a column with the cylinders and columns for each factor value in the variable column - ie mpg and hp
```r
cylData <- dcast(carMelt, cyl ~ variable)
cylData
```
```
    cyl mpg hp
1   4   11  11
2   6   7   7
3   8   14  14
```
This means that for 4 cylinder cars there are 11 different mpg values and 11 different hp values.  
We can also use a function within the dcast command. Lets get the mean of the mpg and hp instead of the count

```r
cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData
```
```
    cyl      mpg        hp
1   4       26.66364    82.63636
2   6       19.74286    122.28571
3   8       15.10000    209.21429
```
http://www.statmethods.net/management/reshape.html

---
## Averaging values
Lets look at another dataset
```r
head(InsectSprays)
```
```
count spray
1    10     A
2     7     A
3    20     A
4    14     A
5    14     A
6    12     A
```
Use tapply to sum up the vector InsectSprays$count using InsectSprays$spray as the index - tapply works like this: tapply(vector, index, function)
```r
tapply(InsectSprays$count,InsectSprays$spray,sum)
```
```
A   B   C   D   E   F
174 184  25  59  42 200
```

---

## Another way - split
Lets use the split, apply, combine method instead.

First we split the x by y using the 'split' command
```r
# Split and store in an object spIns
spIns =  split(InsectSprays$count,InsectSprays$spray)

# Print spIns to the console
spIns
```
```
$A
 [1] 10  7 20 14 14 12 10 23 17 20 14 13

$B
 [1] 11 17 21 11 16 14 17 17 19 21  7 13

$C
 [1] 0 1 7 2 3 1 2 1 3 0 1 4

$D
 [1]  3  5 12  6  4  3  5  5  5  5  2  4

$E
 [1] 3 5 3 5 3 6 1 1 3 2 6 4

$F
 [1] 11  9 15 22 15 16 13 10 26 26 24 13
```
As we can see, R has split the InsectSprays$count by the InsectSprays$spray factor

## Another way - apply
Now we use the apply family of commands to perform operations on the data

Use lapply t operform a function on the list of lists we got from the split and store it in an object sprCount - lapply works like this: - lapply(list, function)

```r
# lapply
sprCount = lapply(spIns,sum)

# Output sprCount to console
sprCount
```
```
$A
[1] 174

$B
[1] 184

$C
[1] 25

$D
[1] 59

$E
[1] 42

$F
[1] 200
```

## Another way - combine
Now we combine the data into our final result

Use unlist to turn sprCount from a list of vectors with only one item to a vector of those items
```r
unlist(sprCount)
```
```
A   B   C   D   E   F
174 184  25  59  42 200
```
Instead of first using lapply to turn spIns into the sprCount list and then unlisting sprCount, we can use sapply instead. sapply does both the apply and combine at the same time. It takes a list and performs a function on it - sapply(list, function)

```r
sapply(spIns,sum)
```
```
A   B   C   D   E   F
174 184  25  59  42 200
```

## Another way - plyr package
```r
library("plyr")
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
```
```
  spray sum
1     A 174
2     B 184
3     C  25
4     D  59
5     E  42
6     F 200
```
Here is the structure of this call:
```
ddply( dataframe to be process,
    variable to split the data frame by,
    function to be performed on each piece )
```
Use . (dot) and the parenthesis to indicate the 'spray' variable from the data frame. Alternatively you can use:
```r
ddply(InsectSprays,"spray",summarize,sum=sum(count))
```
Which does the same thing

# Creating a new variable
```r
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
```
Check the dimensions of the data spraySums dat frame
```r
dim(spraySums)
```
```
[1] 72  2
```
Check out the spraySums data frame
```r
head(spraySums)
```
```
    spray   sum
1   A       174
2   A       174
3   A       174
4   A       174
5   A       174
6   A       174
```
I will not pretend that this explains what the above line actually does. There are four nested functions in that line and the output does not make a lot of sense. It just repeats how many of each sprays there are for each spray there is... I am sure ddply is great, but this does not explain how.

I did get that summarize is like mutate, except it creates a new dataframe rather than add to the existing one like mutate does. Apparently this is useful with ddply. Will not spend more time on this explanation as I would rather spend less time having it explained better elsewhere. Will try to remember adding a link here if I find a better explanation.

---

#### Links from the video
* http://vita.had.co.nz/papers/tidy-data.pdf
* http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0026895
* http://www.statmethods.net/management/reshape.html
* http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/

#### More information
* A tutorial from the developer of plyr - http://plyr.had.co.nz/09-user/
* A nice reshape tutorial http://www.slideshare.net/jeffreybreen/reshaping-data-in-r
* A good plyr primer - http://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/
* See also the functions
    * acast - for casting as multi-dimensional arrays
    * arrange - for faster reordering without using order() commands
    * mutate - adding new variables
