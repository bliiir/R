| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Summarizing Data](https://www.coursera.org/learn/data-cleaning/lecture/aqd2Y/subsetting-and-sorting) |
| Week         | [ 3 ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the material available on Github ([here](https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData)) as well.

*Links from the slides are at the bottom of this document*

# Summarizing Data

## Getting the data from the web
```r
#Create a directory data if it doesn't already exist
if(!file.exists("./data")){dir.create("./data")}

# Store the url in a convenient variable
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"

# Download the file
download.file(fileUrl,destfile="./data/restaurants.csv",method="curl")

# Read the data
restData <- read.csv("./data/restaurants.csv")
```


## Look at a bit of the data
```r
# Print the first three rows of the data
head(restData,n=3)
```
```
    name zipCode neighborhood councilDistrict policeDistrict                      Location.1
1   410   21206    Frankford               2   NORTHEASTERN 4509 BELAIR ROAD\nBaltimore, MD\n
2  1919   21231  Fells Point               1   SOUTHEASTERN    1919 FLEET ST\nBaltimore, MD\n
3 SAUTE   21224       Canton               1   SOUTHEASTERN   2844 HUDSON ST\nBaltimore, MD\n
```

```r
# Print the last three rows of the data
tail(restData,n=3)
```
```
    name zipCode  neighborhood councilDistrict policeDistrict                                     Location.1
1325 ZINK'S CAF\u0090   21213 Belair-Edison              13   NORTHEASTERN 3300 LAWNVIEW AVE\nBaltimore, MD\n
1326     ZISSIMOS BAR   21211       Hampden               7       NORTHERN      1023 36TH ST\nBaltimore, MD\n
1327           ZORBAS   21224     Greektown               2   SOUTHEASTERN  4710 EASTERN Ave\nBaltimore, MD\n
```

### Make Summary
```r
summary(restData)
```
```
name                                        zipCode             neighborhood councilDistrict       policeDistrict                Location.1    
MCDONALD'S                  :   8   Min.   :-21226   Downtown    :128   Min.   : 1.000   SOUTHEASTERN:385    1101 RUSSELL ST\nBaltimore, MD\n:   9  
POPEYES FAMOUS FRIED CHICKEN:   7   1st Qu.: 21202   Fells Point : 91   1st Qu.: 2.000   CENTRAL     :288    201 PRATT ST\nBaltimore, MD\n   :   8  
SUBWAY                      :   6   Median : 21218   Inner Harbor: 89   Median : 9.000   SOUTHERN    :213    2400 BOSTON ST\nBaltimore, MD\n :   8  
KENTUCKY FRIED CHICKEN      :   5   Mean   : 21185   Canton      : 81   Mean   : 7.191   NORTHERN    :157    300 LIGHT ST\nBaltimore, MD\n   :   5  
BURGER KING                 :   4   3rd Qu.: 21226   Federal Hill: 42   3rd Qu.:11.000   NORTHEASTERN: 72    300 CHARLES ST\nBaltimore, MD\n :   4  
DUNKIN DONUTS               :   4   Max.   : 21287   Mount Vernon: 33   Max.   :14.000   EASTERN     : 67    301 LIGHT ST\nBaltimore, MD\n   :   4  
(Other)                     :1293                    (Other)     :863                    (Other)     :145    (Other)                         :1289
```

### More in depth information

```r
str(restData)
```

```
'data.frame':	1327 obs. of  6 variables:
 $ name           : Factor w/ 1277 levels "#1 CHINESE KITCHEN",..: 9 3 992 1 2 4 5 6 7 8 ...
 $ zipCode        : int  21206 21231 21224 21211 21223 21218 21205 21211 21205 21231 ...
 $ neighborhood   : Factor w/ 173 levels "Abell","Arlington",..: 53 52 18 66 104 33 98 133 98 157 ...
 $ councilDistrict: int  2 1 1 14 9 14 13 7 13 1 ...
 $ policeDistrict : Factor w/ 9 levels "CENTRAL","EASTERN",..: 3 6 6 4 8 3 6 4 6 6 ...
 $ Location.1     : Factor w/ 1210 levels "1 BIDDLE ST\nBaltimore, MD\n",..: 835 334 554 755 492 537 505 530 507 569 ...
```

## Quantiles of quantitative variables
Use quantile to look at variability of the councilDistrict removing the NAs
```r
quantile(restData$councilDistrict,na.rm=TRUE)
```
```
0%  25%  50%  75% 100%
 1    2    9   11   14
```

```r
quantile(restData$councilDistrict,probs=c(0.5,0.75,0.9))
```
```
50% 75% 90%
  9  11  12
```

### Make Table
Make a one dimensional table and set the useNA attribute to "ifany" to ensure NA values are includeded in the table
```r
table(restData$zipCode,useNA="ifany")
```
```
-21226  21201  21202  21205  21206  21207  21208  21209  21210  21211  21212  21213  21214  21215  21216  21217  21218  21220  21222  21223  21224  21225  21226  21227  21229  21230
     1    136    201     27     30      4      1      8     23     41     28     31     17     54     10     32     69      1      7     56    199     19     18      4     13    156
 21231  21234  21237  21239  21251  21287
   127      7      1      3      2      1
```
Make a two-dimensional table with councilDistrict as the row names and zipCode as the column names
```r
table(restData$councilDistrict,restData$zipCode)
```

```
    -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214 21215 21216 21217 21218 21220 21222 21223 21224 21225 21226 21227 21229 21230 21231 21234 21237 21239 21251 21287
1       0     0    37     0     0     0     0     0     0     0     0     2     0     0     0     0     0     0     7     0   140     1     0     0     0     1   124     0     0     0     0     0
2       0     0     0     3    27     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0    54     0     0     0     0     0     0     0     1     0     0     0
3       0     0     0     0     0     0     0     0     0     0     0     2    17     0     0     0     3     0     0     0     0     0     0     1     0     0     0     7     0     0     2     0
4       0     0     0     0     0     0     0     0     0     0    27     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     3     0     0
5       0     0     0     0     0     3     0     6     0     0     0     0     0    31     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
6       0     0     0     0     0     0     0     1    19     0     0     0     0    15     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
7       0     0     0     0     0     0     0     1     0    27     0     0     0     6     7    15     6     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
8       0     0     0     0     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     2     0     0     0     2    13     0     0     0     0     0     0     0
9       0     1     0     0     0     0     0     0     0     0     0     0     0     0     2     8     0     0     0    53     0     0     0     0     0    11     0     0     0     0     0     0
10      1     0     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0    18    18     0     0   133     0     0     0     0     0     0
11      0   115   139     0     0     0     1     0     0     0     1     0     0     0     0     9     0     0     0     1     0     0     0     0     0    11     0     0     0     0     0     0
12      0    20    24     4     0     0     0     0     0     0     0    13     0     0     0     0    26     0     0     0     0     0     0     0     0     0     2     0     0     0     0     0
13      0     0     0    20     3     0     0     0     0     0     0    13     0     1     0     0     0     0     0     0     5     0     0     1     0     0     1     0     0     0     0     1
14      0     0     0     0     0     0     0     0     4    14     0     1     0     1     0     0    34     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
```

### Check for missing values
Count the number of times councilDistrict has NAs
```r
sum(is.na(restData$councilDistrict))
```
```
[1] 0
```
Or check if any of the rows in the councilDistrict column has NAs
```r
any(is.na(restData$councilDistrict))
```
```
[1] FALSE
```
Check if all the values in the zipCode are higher than 0 (One of them is negative -21226)
```r
all(restData$zipCode > 0)
```
```
[1] FALSE
```

### Row and column sums
Return a vector with the number of times ```is.na(restData)``` returns TRUE for each column
```r
colSums(is.na(restData))
```
```
name         zipCode    neighborhood councilDistrict  policeDistrict      Location.1
   0               0               0               0               0               0
```
You can do the same for rows
```r
rowSums(is.na(restData))
```
```
[1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[103] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[205] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[307] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[409] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[511] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[613] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[715] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[817] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[919] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
[ reached getOption("max.print") -- omitted 327 entries ]
```
Instead of having to look through all those zeros, you can use the ```all()``` command
```r
all(colSums(is.na(restData))==0)
```
```
[1] TRUE
```

### Values with specific characteristics

Find all the zipcodes that are equal to 21212
```r
table(restData$zipCode %in% c("21212"))
```
```
FALSE  TRUE
 1299    28
```
Same could be done with
```r
table(restData$zipCode == "21212")
```
```
FALSE  TRUE
 1299    28
```
But if you want to check for more values than one the %in% is more efficient. Like this:
```r
table(restData$zipCode %in% c("21212","21213"))
```
```
FALSE  TRUE
 1268    59
```

### Values with specific characteristics
Subset a dataset to get only the restaurants that appear in the 21212 or 21213 zipcodes
```r
restData[restData$zipCode %in% c("21212","21213"),]
```
```
                            name zipCode              neighborhood councilDistrict policeDistrict                      Location.1
29           BAY ATLANTIC CLUB   21212                  Downtown              11        CENTRAL    206 REDWOOD ST\nBaltimore, MD\n
39                 BERMUDA BAR   21213             Broadway East              12        EASTERN    1801 NORTH AVE\nBaltimore, MD\n
92                   ATWATER'S   21212 Chinquapin Park-Belvedere               4       NORTHERN 529 BELVEDERE AVE\nBaltimore, MD\n
111 BALTIMORE ESTONIAN SOCIETY   21213        South Clifton Park              12        EASTERN    1932 BELAIR RD\nBaltimore, MD\n
187                   CAFE ZEN   21212                  Rosebank               4       NORTHERN 438 BELVEDERE AVE\nBaltimore, MD\n
220        CERIELLO FINE FOODS   21212 Chinquapin Park-Belvedere               4       NORTHERN 529 BELVEDERE AVE\nBaltimore, MD\n
...
```
### Cross tabs

```r
### Load Berkley admissions data (built in to R)
data(UCBAdmissions)

# Create a data frame from the data
DF = as.data.frame(UCBAdmissions)

# Output a summary of the dataframe
summary(DF)
```

```
Admit       Gender   Dept       Freq      
Admitted:12   Male  :12   A:4   Min.   :  8.0  
Rejected:12   Female:12   B:4   1st Qu.: 80.0  
                     C:4   Median :170.0  
                     D:4   Mean   :188.6  
                     E:4   3rd Qu.:302.5  
                     F:4   Max.   :512.0
```
Use the xtabs command to display the frequency broken down by Gender and Admit from the DF dataset. The ~ (tilde) means formula.
```r
xtabs(Freq ~ Gender + Admit,data=DF)
```
```
            Admit
Gender      Admitted    Rejected
Male        1198        1493
Female      557         1278
```
The ```xtabs()``` command works a bit like 'pivot tables' in Excel and creates a contingency table by taking a formula as its first argument. In this case the formula is ```Freq ~ Gender + Admit``` and the dataset is ```DF```

>A contingency table is particularly useful when a large number of observations need to be condensed into a smaller format,
[Data-flair](https://data-flair.training/blogs/r-contengency-tables/)

The DF data frame looks like this

```
    Admit       Gender      Dept    Freq
1   Admitted    Male        A       512
2   Rejected    Male        A       313
3   Admitted    Female      A       89
4   Rejected    Female      A       19
5   Admitted    Male        B       353
6   Rejected    Male        B       207
...
```
What I did with the xtabs command above is; Take the value categories of ```Gender``` and make them into row and take the value categoris in ```Admit``` and make them into columns and plot the corresponding values in the ```Freq``` column in the fields.

So if I put Admit first in the formula, the value categories of Admit will be the row names and the value categories of Gender will be the column names.

Like this:

```r
xtabs(Freq ~ Admit + Gender,data=DF)
```

```
Gender
Admit      Male Female
Admitted 1198    557
Rejected 1493   1278
```

### Flat tables
```warpbreaks``` is a built in dataset in R with three variables - ```breaks```, ```wool``` and ```tension```.   

It looks like this:

```
    breaks wool tension
1      26    A       L
2      30    A       L
3      54    A       L
4      25    A       L
5      70    A       L
6      52    A       L
```


Create a series of 54 numbers repeating 1-9
```r
nums <- rep(1:9, len = 54)
```
```
[1] 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9
```

Add a column ```replicate``` to the warpbreaks dataset with 54 rows repeating the numbers 1:9.  
```r
warpbreaks$replicate <- nums
```
```
    breaks wool tension replicate
1      26    A       L         1
2      30    A       L         2
3      54    A       L         3
4      25    A       L         4
5      70    A       L         5
6      52    A       L         6
7      51    A       L         7
8      26    A       L         8
9      67    A       L         9
10     18    A       M         1
11     21    A       M         2
...
```
Use the ```xtabs``` command to break down the values of the ```warpbreaks``` dataset(including the ```replicate``` variable) into a variable ```breaks``` by all the other variables (signified bby the ```.``` dot) and store it in ```xt```.
```r
xt = xtabs(breaks ~.,data=warpbreaks)
xt
```
Looks like this:

```
, , replicate = 1

    tension
wool  L  M  H
   A 26 18 36
   B 27 42 20

, , replicate = 2

    tension
wool  L  M  H
   A 30 21 21
   B 14 26 21

, , replicate = 3

    tension
wool  L  M  H
   A 54 29 24
   B 29 19 24

... (removed replicate = 4 through 8)

, , replicate = 9

    tension
wool  L  M  H
   A 67 36 26
   B 44 29 28
```

So basically for each value category in ```replicate```, create a new
two-dimensional table with ```tension``` as the main column header and
```L```, ```M``` and ```H``` as sub-headers, while the ```wool```
value categories are row labels.

Now, use the ```ftable()``` command to flatten all those tables into one multi-dimensional table
```r
ftable(xt)
```
```
                replicate   1  2  3  4  5  6  7  8  9
wool tension                                     
A    L                      26 30 54 25 70 52 51 26 67
M                           18 21 29 17 12 18 35 30 36
H                           36 21 24 18 10 43 28 15 26
B    L                      27 14 29 19 29 31 41 20 44
M                           42 26 19 16 39 28 21 39 29
H                           20 21 24 17 13 15 15 16 28
```


### Size of a data set

```r
# Create some fake data
fakeData = rnorm(1e5)

# Query the object's size
object.size(fakeData)
```
```
800040 bytes
```
Print using the units attribute
```r
print(object.size(fakeData),units="Mb")
```
```
0.8 Mb
```

---

#### Links from the video
* https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g
