#


| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Part          | [Week 2, Storage,  Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Sub           |[Reading from MySQL]() |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Distribution  | [Coursera](https://www.coursera.org) |
| OS            | Mac OSX High Sierra |

Annoyingly the PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

# Storage Systems
## MySQL
#### 1. Install MySQL
[Install on Mac OS using Native Packages](https://dev.mysql.com/doc/refman/5.7/en/osx-installation-pkg.html)
#### 2. Setup in R
* install.packages("RMySQL")
* library(RMySQL)

#### 3. Try it out in R
##### Connect to UCSC MySQL server:
```r
# Connect to the UCSC Genome MySQL server
ucscDb <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
# Query the connection for databases - "show databases" is SQL
result <- dbGetQuery(ucscDb, "show databases;");dbDisconnect(ucscDb)
# Print out the result
head(result)
```
```
        Database
    1   information_schema
    2   ailMel1
    3   allMis1
    4   anoCar1
    5   anoCar2
    6   anoGam1
```
##### Connect to UCSC MySQL server:

Connect to the MySQL server again and this time to the hg19 db  
```r
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
```

Store all the tables in the hg19 in the "allTables" object
```r
allTables <- dbListTables(hg19)
```

Get the length of the alltables object
```r
length(allTables)
```
    [1] 11116

Print the first five tables of the hg19 database
```r
allTables[1:5]
```
    [1] "HInv"  "HInvGeneMrna"  "acembly"   "acemblyClass"  "acemblyPep"

List all the fields in a specific table
```r
dbListFields(hg19, "affyU133Plus2")
```
    [1] "bin"         "matches"     "misMatches"  "repMatches"  "nCount"      "qNumInsert"  "qBaseInsert" "tNumInsert"  "tBaseInsert" "strand"     
    [11] "qName"       "qSize"       "qStart"      "qEnd"        "tName"       "tSize"       "tStart"      "tEnd"        "blockCount"  "blockSizes"
    [21] "qStarts"     "tStarts"  

```r
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
```
```
count(*)
1    58463
```

Read the affyU133Plus2 table
```r
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)
```

Print(using [knitr](https://yihui.name/knitr/))
```r
kable(head(affyData[1:5]))
```
```
| bin| matches| misMatches| repMatches| nCount|
|---:|-------:|----------:|----------:|------:|
| 585|     530|          4|          0|     23|
| 585|    3355|         17|          0|    109|
| 585|    4156|         14|          0|     83|
| 585|    4667|          9|          0|     68|
| 585|    5180|         14|          0|    167|
| 585|     468|          5|          0|     14|
```

Send a query to the database without pulling all the data for affyU133Plus2 via dbSendQuery
```r
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1  and 3")
affyMis <- fetch(query);quantile(affyMis$misMatches)
```
    0%  25%  50%  75% 100%
    1    1    2    2    3


Read in a subset of the query
```r
affyMisSmall <- fetch(query, n=10); dbClearResult(query)
```
    [1] TRUE
Check how big affyMisSmall is  
```r
dim(affyMisSmall)
```
```
    [1] 10 22
```

### Links from the video  
* http://en.wikipedia.org/wiki/MySQL
* http://www.mysql.com
* http://dev.mysql.com/doc/employee/en/sakils-structure.html
* http://dev.mysql.com/doc/refman/5.7/en/installing.html
* http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL
* http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/
* http://genome.ucsc.edu
* http://genome.ucsc.edu/goldenPath/help/mysql.html
* http://cran.r-project.org/web/packages/RMySQURMySQL.pdfhttp://www.pantz.org/software/mysql/mysqlcommands.html
* http://www.r-bloggers.com/mysql-and/r/
