| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Merging data](https://www.coursera.org/learn/data-cleaning/lecture/pVV6K/merging-data) |
| Week          | [ 3 ](https://www.coursera.org/learn/data-cleaning/home/week/3) |
| Lecturer      | [Roger D. Peng - PhD](https://github.com/rdpeng) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/03_05_mergingData/index.md) available on Github as well.

*Links from the slides are at the bottom of this document*

# Merging Data

### Peer Review Data

```r
# Create a data folder for the file if it doesn't exist already
if(!file.exists("./data")){dir.create("./data")}

# Define the URLs for the content
fileUrl1 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/reviews.csv"
fileUrl2 = "https://raw.githubusercontent.com/jtleek/dataanalysis/master/week2/007summarizingData/data/solutions.csv"

# Download the files
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")

# Read the content into R
reviews = read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
```
Lets look at the data
```r
head(reviews,2)
```
```
    id  solution_id     reviewer_id     start           stop            time_left       accept
1   1   3               27              1304095698      1304095758      1754            1
2   2   4               22              1304095188      1304095206      2306            1
```
```r
head(solutions,2)
```

```
    id  problem_id  subject_id  start           stop        time_left answer
1   1   156         29          1304095119      1304095169  2343      B
2   2   269         25          1304095119      1304095183  2329      C
```

### Merging data - merge()
Merge is like JOIN in SQL. Lets look at the variable names to figure out what we want to use as the merge variable(s)

```r
head(reviews)
```
```
  id solution_id reviewer_id      start       stop time_left accept
1  1           3          27 1304095698 1304095758      1754      1
2  2           4          22 1304095188 1304095206      2306      1
3  3           5          28 1304095276 1304095320      2192      1
4  4           1          26 1304095267 1304095423      2089      1
5  5          10          29 1304095456 1304095469      2043      1
6  6           2          29 1304095471 1304095513      1999      1
```

```r
head(solutions)
```
```

  id problem_id subject_id      start       stop time_left answer
1  1        156         29 1304095119 1304095169      2343      B
2  2        269         25 1304095119 1304095183      2329      C
3  3         34         22 1304095127 1304095146      2366      C
4  4         19         23 1304095127 1304095150      2362      D
5  5        605         26 1304095127 1304095167      2345      A
6  6        384         27 1304095131 1304095270      2242      C
```
R will merge by all the variable names that coincide - that is not  what we want so lets tell R which variable we want to use to merge

```r
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
```
The all=TRUE means that a row is empty in one set, R will create an empyt row to ensure that the merge stays in sync

Lets see what that looks like
```r
head(mergedData)
```

```

  solution_id id reviewer_id    start.x     stop.x time_left.x accept problem_id subject_id    start.y     stop.y time_left.y answer
1           1  4          26 1304095267 1304095423        2089      1        156         29 1304095119 1304095169        2343      B
2           2  6          29 1304095471 1304095513        1999      1        269         25 1304095119 1304095183        2329      C
3           3  1          27 1304095698 1304095758        1754      1         34         22 1304095127 1304095146        2366      C
4           4  2          22 1304095188 1304095206        2306      1         19         23 1304095127 1304095150        2362      D
5           5  3          28 1304095276 1304095320        2192      1        605         26 1304095127 1304095167        2345      A
6           6 16          22 1304095303 1304095471        2041      1        384         27 1304095131 1304095270        2242      C
```

### Default - merge all common column names
Use intersect to get what R would merge on if you do not specfy the variables to merge on
```r
intersect(names(solutions),names(reviews))
```

```
[1] "id"        "start"     "stop"      "time_left"
```
Lets try to merge the data without specifying what to merge on
```r
mergedData2 = merge(reviews,solutions,all=TRUE)
```
Lets see the results
```r
head(mergedData2)
```

```

  id      start       stop time_left solution_id reviewer_id accept problem_id subject_id answer
1  1 1304095119 1304095169      2343          NA          NA     NA        156         29      B
2  1 1304095698 1304095758      1754           3          27      1         NA         NA   <NA>
3  2 1304095119 1304095183      2329          NA          NA     NA        269         25      C
4  2 1304095188 1304095206      2306           4          22      1         NA         NA   <NA>
5  3 1304095127 1304095146      2366          NA          NA     NA         34         22      C
6  3 1304095276 1304095320      2192           5          28      1         NA         NA   <NA>
```

### Using join in the plyr package
The plyr package has a fast but less full featured join function that works like merge in base R. Worth noting is that dplyr always uses id to join on

First we create two random data frames
```r
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
```
Then we join them together and use arrange to sort the rows by id
```r
arrange(join(df1,df2),id)
```

```
   id          x           y
1   1 -0.6120291  0.40796203
2   2  3.0696490  0.72321192
3   3 -0.4679491  2.86284038
4   4 -0.7307544  0.05911275
5   5  0.3905000 -1.86387291
6   6  0.7096931  0.12935340
7   7  0.6373310 -2.50096272
8   8 -1.0665206 -0.22356446
9   9  1.7372423 -1.22534115
10 10 -0.4791803  0.23505973
```

### If you have multiple data frames
You can use join_all to join multiple data frames
```r
# First we create three random data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))

# Then we make a list of the three data frames
dfList = list(df1,df2,df3)

# And then we use join_all to join them
arrange(join_all(dfList), id)

```

```
   id          x          y             z
1   1 -1.1753771  2.1317247 -0.6322540828
2   2 -0.9697664 -0.6612839 -0.9180589867
3   3  0.1951738  0.7291598  1.4453942955
4   4 -1.0519948 -0.1533494 -1.4470470479
5   5 -0.2368178  1.3323840 -0.6056455290
6   6  1.1597621  0.2704268 -1.1726881106
7   7  0.4995603  1.3781885 -0.7706106662
8   8 -0.2866342  0.3490636 -2.2032166069
9   9  1.7525507  0.7723774  0.0005348703
10 10  1.7086338 -0.1826084  2.0695532495
```

### More on merging data
* The quick R data merging page - http://www.statmethods.net/management/merging.html
* plyr information - http://plyr.had.co.nz/
* Types of joins - http://en.wikipedia.org/wiki/Join_(SQL)

---

#### Links from the video
* http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895
