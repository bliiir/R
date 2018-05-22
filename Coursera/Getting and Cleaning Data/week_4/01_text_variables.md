| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Text Variables](https://www.coursera.org/learn/data-cleaning/lecture/drpnT/editing-text-variables) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_01_editingTextVariables/index.md) available on Github as well.

*Links from the slides are at the bottom of this document*

# Text variables

First we import some data to work with from the baltimore camera data Site

```r
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
```
Then we read the csv data into a table
```r
cameraData <- read.csv("./data/cameras.csv")
```
And print the names to the console
```r
names(cameraData)
```
```
[1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location.1"
```
## Fixing character vectors

### tolower()
Lets make sure all the variable names are lower-case
```r
tolower(names(cameraData))
```
```
[1] "address"      "direction"    "street"       "crossstreet"  "intersection" "location.1"
```
### toupper()
And now all to upper-case:
```r
toupper(names(cameraData))
```
```
[1] "ADDRESS"      "DIRECTION"    "STREET"       "CROSSSTREET"  "INTERSECTION" "LOCATION.1"  
```
### strsplit()
Split a text variable at a specific character - in this case the "." character
```r
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
```
```
[1] "intersection"
```
Nothing happened because there were no "." characters
```r
splitNames[[6]]
```
```
[1] "location" "1"
```
In this case the "location.1" was split into "location" and "1"
The two "\\\\" characters are escape characters

## lists
A list of named lists
```r
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
```
Looks like this:
```
$letters
[1] "A" "b" "c"

$numbers
[1] 1 2 3

[[3]]
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    6   11   16   21
[2,]    2    7   12   17   22
[3,]    3    8   13   18   23
[4,]    4    9   14   19   24
[5,]    5   10   15   20   25
```
Subset the first named sub-list
```r
mylist[1]
```
```
$letters
[1] "A" "b" "c"
```
This gets the named list of the list of lists we made earlier. In order to get to the content of that first element, we can select it by the name:
```r
mylist$letters
```
```
[1] "A" "b" "c"
```
Or use the [[ ]] selector
```r
mylist[[1]]
```
```
[1] "A" "b" "c"
```


And the third sublist
```r
mylist[3]
```
```
[[1]]
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    6   11   16   21
[2,]    2    7   12   17   22
[3,]    3    8   13   18   23
[4,]    4    9   14   19   24
[5,]    5   10   15   20   25
```
And the first (and only) element of the third sublist
```r
mylist[3][[1]]
```
```
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    6   11   16   21
[2,]    2    7   12   17   22
[3,]    3    8   13   18   23
[4,]    4    9   14   19   24
[5,]    5   10   15   20   25
```
And the third variable of the first element of the third sublist
```r
mylist[3][[1]][,3]
```
```
[1] 11 12 13 14 15
```

Lets look at splitNames again:
```r
splitNames
```
```
[[1]]
[1] "address"

[[2]]
[1] "direction"

[[3]]
[1] "street"

[[4]]
[1] "crossStreet"

[[5]]
[1] "intersection"

[[6]]
[1] "Location" "1"
```
Lets grab the 6th element
```r
splitNames[6]
```
```
[[1]]
[1] "Location" "1"  
```
Lets grab the first element of the sixth element:
```r
splitNames[6][1]
```
```
[[1]]
[1] "Location" "1"
```
That isn't what we wanted - We wanted "Location" to be returned. When using single brackets, R returns the list wrapper. in this case, it returns the 1st element of the 6th element - which only has one element - itself.

```r
splitNames[[6]][1]
```
```
[1] "Location"
```
A little context is needed here. The names(cameraData) functioncall creates character strings out of the names, then the strsplit() function is able to split them. That means that you wouldn't be able to do the following
```r
cameraData[10,1]
```
```
[1] ORLEANS ST & N LINWOOD AVE
71 Levels: E 33RD ST & THE ALAMEDA E COLD SPRING LN & HILLEN RD E COLD SPRING LN & LOCH RAVEN BLVD E LOMBARD ST & S GAY ST ... YORK RD & GITTINGS AVE
```
```r
strsplit(cameraData[10,1], "\\&")
```
Returns
```
Error in strsplit(cameraData, "\\&") : non-character argument
```
Because cameraData[10,1] does not return a string but some sort of structured data. Instead we can do like this
```r
as.character(cameraData[10,1])
```
```
[1] "ORLEANS ST & N LINWOOD AVE"
```
```r
strsplit(as.character(cameraData[10,1]), "\\&")
```
```
[[1]]
[1] "ORLEANS ST "    " N LINWOOD AVE"
```
Ok, back to the lecture...

## Fixing character vectors

### sapply()

```r
splitNames[[6]][1]
```
```
[1] "Location"
```

```r
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)
```
```
[1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location"
```

## [Peer review experiment data](http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895)

```r
## Download the content
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- "http://www.sharecsv.com/dl/e70e9c289adc4b87c900fdf69093f996/reviews.csv"
fileUrl2 <- "http://www.sharecsv.com/dl/0863fd2414355555be0260f46dbe937b/solutions.csv"
download.file(fileUrl1, destfile="./data/reviews.csv", method="curl")
download.file(fileUrl2, destfile="./data/solutions.csv", method="curl")

## Load the data into R
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
```
```
  id solution_id reviewer_id      start       stop time_left accept
1  1           3          27 1304095698 1304095758      1754      1
2  2           4          22 1304095188 1304095206      2306      1
```
```r
head(solutions,2)
```
```
  id problem_id subject_id      start       stop time_left answer
1  1        156         29 1304095119 1304095169      2343      B
2  2        269         25 1304095119 1304095183      2329      C
```

Note : The link in the original slides are dead, I've changed them to an alternative source. I still had to download the file manually because AWS was rate limiting me after a few tries.

## Fixing character vectors

### sub()
```r
names(reviews)
```
```
[1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept"
```
Lets substitute "\_" (underscore) with "" using the sub() command
```r
sub("_","",names(reviews),)
```
```
[1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"   "accept"
```

### gsub()
If you have a string with multiple instances of a character, sub() will only substitute the first instance
```r
testName <- "this_is_a_test"
sub("_","",testName)
```
```
[1] "thisis_a_test"
```
gsub() (global substitute) removes all instances os the character
```r
gsub("_","",testName)
```
```
[1] "thisisatest"
```

## Finding values

### grep()
Lets go back to the camera dataset
```r
cameraData$intersection
```
```
 [1] Caton Ave & Benson Ave                Caton Ave & Benson Ave                Wilkens Ave & Pine Heights            The Alameda  & 33rd St               
 [5] E 33rd  & The Alameda                 Erdman  & Macon St                    Erdman  & Macon St                    Charles & Lake Ave                   
 [9] Madison  & Caroline St                Orleans   & Linwood Ave               Eastern  & Kane St                    Edmonson  & Cooks Lane               
[13] Franklin  & Pulaski St                Orleans  & Gay St                     MLK Jr. Blvd.  & Washington Blvd      Hillen Rd  & Argonne Drive           
[17] North Ave  & Howard St                Patapsco  \n & 4th St                 Reisterstown   & Fallstaff Road       Park Heights   & Hayward Ave         
[21] Park Heights   & Hayward Ave          MLK Jr. Blvd \n & Pratt St            Northern Pkwy   & Greenspring Ave     Northern Pkwy  & Greenspring Ave     
[25] Edmonson\n  & Woodbridge Ave          Edmonson \n & Woodbridge Ave          Fredrick Ave\n & Catherine Ave        Park Heights  & Voilet Ave           
[29] Sinclair  & Moravia Road              Wilkens  & DeSoto                     Northern Pkwy  & Waverly St           Cold Spring  & Hillen Road           
[33] Cold Spring\n  & Roland Ave           Cold Spring\n  & Loch Raven Blvd      Tamarind\n  & Coldspring Lane         Harford \n & The Alameda             
[37] Harford\n  & Rosalie Ave              Harford \n & Christopher Ave          Sinclair\n  & Shannon Drive           Sinclair \n & Shannon Drive          
[41] Liberty Hghts\n  & Hillsdale Ave      Liberty Hghts\n  & Hillsdale Ave      Northern Pkwy\n  & Springlake Way     Harford  & Walther Ave               
[45] Northern Pkwy  & Falls Road           Edmonson  & Hilton St                 President  & Fayette St               Russell \n & Hamburg St              
[49] Russell\n  & Hamburg St               Light SB \n & Pratt St                Lombard \n & Gay St                   Harford Rd\n  & North Ave            
[53] Ft Smallwood\n  & Fort Armstead       Garrison \n & Wabash Ave              Walther \n & Glenmore                 Franklin \n & Cathedral              
[57] Perring Pkwy\n  & Belvedere Ave       Gwynns Falls \n  & Garrison Blvd      Reistertown Rd\n  & Druid Lake Drive  Potee\n  & Talbot                    
[61] York Rd \n & Gitting Ave              Wabash \n & Belvedere Ave             Northern Pkwy\n  & York Road          Reistertown \n  & Patterson Ave      
[65] Pulaski Hwy \n  & Monument St         Franklin \n  & Franklintown Road       &                                    Reisterstown \n & Menlo Drive        
[69] Russell \n & Bayard St                Liberty Hghts\n  & Dukeland St        Hanover \n & Reedbird Ave             Fayette\n  & Liberty Heights Ave     
[73] Gwynns Falls \n  & Garrison Blvd      Loch Raven\n  & Walker Ave            \nPulaski Hwy \n & Moravia Park Drive Hillen \n & Forrest St               
[77] Pulaski \n & North Point Blvd         Monroe\n & Lafayette                  Mt Royal\n & North                    Mt Royal\n & North                   
74 Levels: \nPulaski Hwy \n & Moravia Park Drive  & Caton Ave & Benson Ave Charles & Lake Ave Cold Spring\n  & Loch Raven Blvd ... York Rd \n & Gitting Ave
```
Using grep ([regular expression](http://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html)), we can search through the list of intersections for the term "Alameda". grep will return a list of integers corresponding to the positions in the list it searches through
```r
grep("Alameda",cameraData$intersection)
```
```
[1]  4  5 36
```
Lets just check that this is true
```r
as.character(cameraData$intersection[c(4,5,36)])
```
```
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"
```
Looks good.
We can use grepl() to get true/false value returned for each element of the list when searching for "Alameda"
```r
grepl("Alameda",cameraData$intersection)
```
```
[1] FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[29] FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[57] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```
```r
table(grepl("Alameda",cameraData$intersection))
```
```
FALSE  TRUE
   77     3
```
Thats 77 positions in the list with no "Alameda" and 3 with

I can then subset the original cameraData data frame with only those rows in which "Alameda" occurs in the "intersection" column
```r
cameraData3 <- cameraData[grepl("Alameda",cameraData$intersection),]
cameraData3
```
```
                    address direction      street crossStreet             intersection                      Location.1
4   THE ALAMEDA & E 33RD ST       S/B The Alameda     33rd St   The Alameda  & 33rd St (39.3285013141, -76.5953545714)
5   E 33RD ST & THE ALAMEDA       E/B      E 33rd The Alameda    E 33rd  & The Alameda (39.3283410623, -76.5953594625)
36 HARFORD RD & THE ALAMEDA       N/B  Harford \n The Alameda Harford \n & The Alameda (39.3212074758, -76.5907705888)
```

### More on grep()
If you set value=True, R will return the values instead of the positions
```r
grep("Alameda",cameraData$intersection,value=TRUE)
```
```
[1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"
```
You can use a combination of length() and grep() to count the number of occurences of a string

```r
length(grep("Alameda",cameraData$intersection))
```
```
[1] 3
```

## More useful string functions

```r
library(stringr)
nchar("white bread with marmelade")
```
```
[1] 25
```
(I am fasting today and fantasizing about food)

Use substr() to cut out a piece of the string
```r
substr("white bread with marmelade",7,11)
```
```
[1] "bread"
```
Concatenation
```r
paste("High","Five")
```
```
[1] "High Five"
```
paste0() does the same without the space between the bits
```r
paste0("Holi", "day")
```
```
[1] "Holiday"
```
Use str_trim() to remove excess whitespace
```r
str_trim("     Coffee      ")
```
```
[1] "Coffee"
```

---

## Important points about text in data sets
**Names of variables should be**
* All lower case when possible
* Descriptive (Diagnosis versus Dx)
* Not duplicated
* Not have underscores or dots or white spaces
* Variables with character values
* Should usually be made into factor variables (depends on application)
* Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F)

**Variables with character values**
* Should usually be made into factor variables (depends on application)
* Should be descriptive (use TRUE/FALSE instead of 0/1 and Male/Female versus 0/1 or M/F)

---

#### Links from the video
* https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru
* http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf
* http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895
