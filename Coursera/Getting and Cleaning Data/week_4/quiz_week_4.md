| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Quiz](https://www.coursera.org/learn/data-cleaning/exam/9W3Y2/week-4-quiz) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | NA |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

### Question 1
#### Problem

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?


#### Solution
```r
# Set the file URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

# Set a name for the csv file
filename <- paste("housing", ".csv", sep = "")

# Set the folder
foldername <- "./data"

# set path
path <- paste(foldername, "/", filename, sep = "")

# Check if the folder exists, if not, create it
if(!file.exists(foldername)) {
dir.create(foldername)}

# Download file
download.file(url, destfile=path, method="curl")

# Load the data, replacing empty fields with NA, and with header
housing <- read.csv(path, stringsAsFactors = F, header = T, na.strings = c("", "NA"))

# print
str(housing)
```
```
'data.frame':	6496 obs. of  188 variables:
$ RT      : chr  "H" "H" "H" "H" ...
$ SERIALNO: int  186 306 395 506 835 989 1861 2120 2278 2428 ...
$ DIVISION: int  8 8 8 8 8 8 8 8 8 8 ...
$ PUMA    : int  700 700 100 700 800 700 700 200 400 500 ...
$ REGION  : int  4 4 4 4 4 4 4 4 4 4 ...
$ ST      : int  16 16 16 16 16 16 16 16 16 16 ...
$ ADJUST  : int  1015675 1015675 1015675 1015675 1015675 1015675 1015675
...(more)
```
```r
splitnames <- strsplit(names(housing), "wgtp")
```
#### Result
```
[1] ""   "15"
```

---

### Question 2
#### Problem

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

#### solution
```r
# Set the file URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

# Set a name for the csv file
filename <- paste("gdp", ".csv", sep = "")

# Set the folder
foldername <- "./data"

# set path
path <- paste(foldername, "/", filename, sep = "")

# Check if the folder exists, if not, create it
if(!file.exists(foldername)) {
dir.create(foldername)}

# Download file
download.file(url, destfile=path, method="curl")

# Load the data, replacing empty fields with NA, and with header - and (I found out the hard way - only load the first 215 rows - everything below is regional data)
gdp <- read.csv(path, skip = 4, stringsAsFactors = F, nrows = 215, header = T, na.strings = c("", "NA"))

# print
head(gdp)
```
```
X X.1 X.2            X.3          X.4  X.5 X.6 X.7 X.8 X.9
1 USA   1  NA  United States  16,244,600  <NA>  NA  NA  NA  NA
2 CHN   2  NA          China   8,227,103  <NA>  NA  NA  NA  NA
3 JPN   3  NA          Japan   5,959,718  <NA>  NA  NA  NA  NA
4 DEU   4  NA        Germany   3,428,131  <NA>  NA  NA  NA  NA
5 FRA   5  NA         France   2,612,878  <NA>  NA  NA  NA  NA
6 GBR   6  NA United Kingdom   2,471,784  <NA>  NA  NA  NA  NA
```
Ok, lets crop that a bit

```r
gdp <- gdp[, c(1,2,4,5)]
head(gdp2)
```
```
X X.1            X.3          X.4
1 USA   1  United States  16,244,600
2 CHN   2          China   8,227,103
3 JPN   3          Japan   5,959,718
4 DEU   4        Germany   3,428,131
5 FRA   5         France   2,612,878
6 GBR   6 United Kingdom   2,471,784
```

And lets give it some better names
```r
names(gdp) <- c("short", "rank", "economy", "gdp")
head(gdp)
```
```
short rank        economy          gdp
1   USA    1  United States  16,244,600
2   CHN    2          China   8,227,103
3   JPN    3          Japan   5,959,718
4   DEU    4        Germany   3,428,131
5   FRA    5         France   2,612,878
6   GBR    6 United Kingdom   2,471,784
```
```r
gdplst <- as.numeric(gsub(",", "", gdp$gdp))
head(gdplst)
```
```
[1] 16244600  8227103  5959718  3428131  2612878  2471784
```
Ok, great. Lets average that list of gdp
```r
avggdp <- mean(gdplst, na.rm = TRUE)
avggdp
```
#### Result
```
[1] 377652.4
```

---

### Question 3
#### Problem
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

#### Solution

```r
# Set the file URL
url_GDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url_EDSTAT <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Set a name for the csv file
f_GDP <- paste("gdp", ".csv", sep = "")
edstat <- paste("edstat", ".csv", sep = "")

# Set the folder
foldername <- "./data"

# set path
path_gdp <- paste(foldername, "/", filename, sep = "")
path_edstat <- paste(foldername, "/", filename, sep = "")

# Check if the folder exists, if not, create it
if(!file.exists(foldername)) {dir.create(foldername)}

# Download file
download.file(url_GDP, destfile=path_gdp, method="curl")
download.file(url_EDSTAT, destfile=f_edstat, method="curl")

# Load the data, replacing empty fields with NA, and with header - and (I found out the hard way - only load the first 215 rows - everything below is regional data)
gdp <- read.csv(path, skip = 4, stringsAsFactors = F, nrows = 215, header = T, na.strings = c("", "NA"))
edstat <- read.csv(path, stringsAsFactors = F, header = T, na.strings = c("", "NA"))
```
```r
str(gdp)
```
```
'data.frame':	215 obs. of  10 variables:
$ X  : chr  "USA" "CHN" "JPN" "DEU" ...
$ X.1: int  1 2 3 4 5 6 7 8 9 10 ...
$ X.2: logi  NA NA NA NA NA NA ...
$ X.3: chr  "United States" "China" "Japan" "Germany" ...
$ X.4: chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
$ X.5: chr  NA NA NA NA ...
$ X.6: logi  NA NA NA NA NA NA ...
$ X.7: logi  NA NA NA NA NA NA ...
$ X.8: logi  NA NA NA NA NA NA ...
$ X.9: logi  NA NA NA NA NA NA ...
```
```r
str(edstat)
```
```
'data.frame':	234 obs. of  31 variables:
$ CountryCode                                      : chr  "ABW" "ADO" "AFG" "AGO" ...
$ Long.Name                                        : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
$ Income.Group                                     : chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
$ Region                                           : chr  "Latin America & Caribbean" "Europe & Central Asia" "South Asia" "Sub-Saharan Africa" ...
$ Lending.category                                 : chr  NA NA "IDA" "IDA" ...
$ Other.groups                                     : chr  NA NA "HIPC" NA ...
$ Currency.Unit                                    : chr  "Aruban florin" "Euro" "Afghan afghani" "Angolan kwanza" ...
$ Latest.population.census                         : chr  "2000" "Register based" "1979" "1970" ...
$ Latest.household.survey                          : chr  NA NA "MICS, 2003" "MICS, 2001, MIS, 2006/07" ...
$ Special.Notes                                    : chr  NA NA "Fiscal year end: March 20; reporting period for national accounts data: FY." NA ...
$ National.accounts.base.year                      : chr  "1995" NA "2002/2003" "1997" ...
$ National.accounts.reference.year                 : int  NA NA NA NA 1996 NA NA 1996 NA NA ...
$ System.of.National.Accounts                      : int  NA NA NA NA 1993 NA 1993 1993 NA NA ...
$ SNA.price.valuation                              : chr  NA NA "VAB" "VAP" ...
$ Alternative.conversion.factor                    : chr  NA NA NA "1991-96" ...
$ PPP.survey.year                                  : int  NA NA NA 2005 2005 NA 2005 2005 NA NA ...
$ Balance.of.Payments.Manual.in.use                : chr  NA NA NA "BPM5" ...
$ External.debt.Reporting.status                   : chr  NA NA "Actual" "Actual" ...
$ System.of.trade                                  : chr  "Special" "General" "General" "Special" ...
$ Government.Accounting.concept                    : chr  NA NA "Consolidated" NA ...
$ IMF.data.dissemination.standard                  : chr  NA NA "GDDS" "GDDS" ...
$ Source.of.most.recent.Income.and.expenditure.data: chr  NA NA NA "IHS, 2000" ...
$ Vital.registration.complete                      : chr  NA "Yes" NA NA ...
$ Latest.agricultural.census                       : chr  NA NA NA "1964-65" ...
$ Latest.industrial.data                           : int  NA NA NA NA 2005 NA 2001 NA NA NA ...
$ Latest.trade.data                                : int  2008 2006 2008 1991 2008 2008 2008 2008 NA 2007 ...
$ Latest.water.withdrawal.data                     : int  NA NA 2000 2000 2000 2005 2000 2000 NA 1990 ...
$ X2.alpha.code                                    : chr  "AW" "AD" "AF" "AO" ...
$ WB.2.code                                        : chr  "AW" "AD" "AF" "AO" ...
$ Table.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
$ Short.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
```
Before I move on, I will just rename the variables in the gdp data frame to make the merge easier
```r
names(gdp)
```
```
[1] "X"   "X.1" "X.2" "X.3" "X.4" "X.5" "X.6" "X.7" "X.8" "X.9"
```

```r
names(gdp) <- c("CountryCode", "Rank", "Unknown", "Long.Name", "gdp")
str(gdp)
```
```
'data.frame':	215 obs. of  10 variables:
$ CountryCode: chr  "USA" "CHN" "JPN" "DEU" ...
$ Rank       : int  1 2 3 4 5 6 7 8 9 10 ...
$ Unknown    : logi  NA NA NA NA NA NA ...
$ Long.Name  : chr  "United States" "China" "Japan" "Germany" ...
$ gdp        : chr  " 16,244,600 " " 8,227,103 " " 5,959,718 " " 3,428,131 " ...
$ NA         : chr  NA NA NA NA ...
$ NA         : logi  NA NA NA NA NA NA ...
$ NA         : logi  NA NA NA NA NA NA ...
$ NA         : logi  NA NA NA NA NA NA ...
$ NA         : logi  NA NA NA NA NA NA ...
```

Great, and now to merge the two data frames
```r
mergedData = merge(gdp,edstat,by.x="CountryCode", by.y="CountryCode", all.x = T)
str(mergedData)
```
```

'data.frame':	215 obs. of  40 variables:
 $ CountryCode                                      : chr  "ABW" "ADO" "AFG" "AGO" ...
 $ Rank                                             : int  161 NA 105 60 125 32 26 133 NA 172 ...
 $ Unknown                                          : logi  NA NA NA NA NA NA ...
 $ Long.Name.x                                      : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
 $ gdp                                              : chr  " 2,584 " ".." " 20,497 " " 114,147 " ...
 $ NA                                               : chr  NA NA NA NA ...
 $ NA                                               : logi  NA NA NA NA NA NA ...
 $ NA                                               : logi  NA NA NA NA NA NA ...
 $ NA                                               : logi  NA NA NA NA NA NA ...
 $ NA                                               : logi  NA NA NA NA NA NA ...
 $ Long.Name.y                                      : chr  "Aruba" "Principality of Andorra" "Islamic State of Afghanistan" "People's Republic of Angola" ...
 $ Income.Group                                     : chr  "High income: nonOECD" "High income: nonOECD" "Low income" "Lower middle income" ...
 $ Region                                           : chr  "Latin America & Caribbean" "Europe & Central Asia" "South Asia" "Sub-Saharan Africa" ...
 $ Lending.category                                 : chr  NA NA "IDA" "IDA" ...
 $ Other.groups                                     : chr  NA NA "HIPC" NA ...
 $ Currency.Unit                                    : chr  "Aruban florin" "Euro" "Afghan afghani" "Angolan kwanza" ...
 $ Latest.population.census                         : chr  "2000" "Register based" "1979" "1970" ...
 $ Latest.household.survey                          : chr  NA NA "MICS, 2003" "MICS, 2001, MIS, 2006/07" ...
 $ Special.Notes                                    : chr  NA NA "Fiscal year end: March 20; reporting period for national accounts data: FY." NA ...
 $ National.accounts.base.year                      : chr  "1995" NA "2002/2003" "1997" ...
 $ National.accounts.reference.year                 : int  NA NA NA NA 1996 NA NA 1996 NA NA ...
 $ System.of.National.Accounts                      : int  NA NA NA NA 1993 NA 1993 1993 NA NA ...
 $ SNA.price.valuation                              : chr  NA NA "VAB" "VAP" ...
 $ Alternative.conversion.factor                    : chr  NA NA NA "1991-96" ...
 $ PPP.survey.year                                  : int  NA NA NA 2005 2005 NA 2005 2005 NA NA ...
 $ Balance.of.Payments.Manual.in.use                : chr  NA NA NA "BPM5" ...
 $ External.debt.Reporting.status                   : chr  NA NA "Actual" "Actual" ...
 $ System.of.trade                                  : chr  "Special" "General" "General" "Special" ...
 $ Government.Accounting.concept                    : chr  NA NA "Consolidated" NA ...
 $ IMF.data.dissemination.standard                  : chr  NA NA "GDDS" "GDDS" ...
 $ Source.of.most.recent.Income.and.expenditure.data: chr  NA NA NA "IHS, 2000" ...
 $ Vital.registration.complete                      : chr  NA "Yes" NA NA ...
 $ Latest.agricultural.census                       : chr  NA NA NA "1964-65" ...
 $ Latest.industrial.data                           : int  NA NA NA NA 2005 NA 2001 NA NA NA ...
 $ Latest.trade.data                                : int  2008 2006 2008 1991 2008 2008 2008 2008 NA 2007 ...
 $ Latest.water.withdrawal.data                     : int  NA NA 2000 2000 2000 2005 2000 2000 NA 1990 ...
 $ X2.alpha.code                                    : chr  "AW" "AD" "AF" "AO" ...
 $ WB.2.code                                        : chr  "AW" "AD" "AF" "AO" ...
 $ Table.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
 $ Short.Name                                       : chr  "Aruba" "Andorra" "Afghanistan" "Angola" ...
```
Right. Which countries have the fiscal year available?

First lets cut the data down to only the nessesary bits. Looks like that Fiscal year end information is available in the "Special.Notes" variable.
```r
croppedData <- mergedData[,c("CountryCode", "Special.Notes")]
head(croppedData)
```
```
  CountryCode                                                               Special.Notes
1         ABW                                                                        <NA>
2         ADO                                                                        <NA>
3         AFG Fiscal year end: March 20; reporting period for national accounts data: FY.
4         AGO                                                                        <NA>
5         ALB                                                                        <NA>
6         ARE                                                                        <NA>
```
 Cool. Lets filter for observations containing "Fiscal year end: June" in the "Special.Notes" variable.
```r
filter(croppedData, grepl("Fiscal year end: June", croppedData$Special.Notes))
```
```
   CountryCode                                                              Special.Notes
1          AUS Fiscal year end: June 30; reporting period for national accounts data: FY.
2          BGD Fiscal year end: June 30; reporting period for national accounts data: FY.
3          BWA Fiscal year end: June 30; reporting period for national accounts data: FY.
4          EGY Fiscal year end: June 30; reporting period for national accounts data: FY.
5          GMB Fiscal year end: June 30; reporting period for national accounts data: CY.
6          KEN Fiscal year end: June 30; reporting period for national accounts data: CY.
7          KWT Fiscal year end: June 30; reporting period for national accounts data: CY.
8          PAK Fiscal year end: June 30; reporting period for national accounts data: FY.
9          PRI Fiscal year end: June 30; reporting period for national accounts data: FY.
10         SLE Fiscal year end: June 30; reporting period for national accounts data: CY.
11         SWE Fiscal year end: June 30; reporting period for national accounts data: CY.
12         UGA Fiscal year end: June 30; reporting period for national accounts data: FY.
13         ZWE Fiscal year end: June 30; reporting period for national accounts data: CY.
```
Or we could get the row numbers in the data frame
```r
grep("Fiscal year end: June", croppedData$Special.Notes)
```
```
[1]  11  18  31  57  72  99 106 149 156 170 180 198 214
```
Lets just chack that is true:
```r
croppedData[c(11,  18,  31,  57,  72,  99, 106, 149, 156, 170, 180, 198, 214),]
```
```
    CountryCode                                                              Special.Notes
11          AUS Fiscal year end: June 30; reporting period for national accounts data: FY.
18          BGD Fiscal year end: June 30; reporting period for national accounts data: FY.
31          BWA Fiscal year end: June 30; reporting period for national accounts data: FY.
57          EGY Fiscal year end: June 30; reporting period for national accounts data: FY.
72          GMB Fiscal year end: June 30; reporting period for national accounts data: CY.
99          KEN Fiscal year end: June 30; reporting period for national accounts data: CY.
106         KWT Fiscal year end: June 30; reporting period for national accounts data: CY.
149         PAK Fiscal year end: June 30; reporting period for national accounts data: FY.
156         PRI Fiscal year end: June 30; reporting period for national accounts data: FY.
170         SLE Fiscal year end: June 30; reporting period for national accounts data: CY.
180         SWE Fiscal year end: June 30; reporting period for national accounts data: CY.
198         UGA Fiscal year end: June 30; reporting period for national accounts data: FY.
214         ZWE Fiscal year end: June 30; reporting period for national accounts data: CY.
```
Or even better
```r
croppedData[grep("Fiscal year end: June", croppedData$Special.Notes),]
```
```
    CountryCode                                                              Special.Notes
11          AUS Fiscal year end: June 30; reporting period for national accounts data: FY.
18          BGD Fiscal year end: June 30; reporting period for national accounts data: FY.
31          BWA Fiscal year end: June 30; reporting period for national accounts data: FY.
57          EGY Fiscal year end: June 30; reporting period for national accounts data: FY.
72          GMB Fiscal year end: June 30; reporting period for national accounts data: CY.
99          KEN Fiscal year end: June 30; reporting period for national accounts data: CY.
106         KWT Fiscal year end: June 30; reporting period for national accounts data: CY.
149         PAK Fiscal year end: June 30; reporting period for national accounts data: FY.
156         PRI Fiscal year end: June 30; reporting period for national accounts data: FY.
170         SLE Fiscal year end: June 30; reporting period for national accounts data: CY.
180         SWE Fiscal year end: June 30; reporting period for national accounts data: CY.
198         UGA Fiscal year end: June 30; reporting period for national accounts data: FY.
214         ZWE Fiscal year end: June 30; reporting period for national accounts data: CY.
```
Or like this:
```r
subset(croppedData, grepl("Fiscal year end: June", Special.Notes))
```
```
    CountryCode                                                              Special.Notes
11          AUS Fiscal year end: June 30; reporting period for national accounts data: FY.
18          BGD Fiscal year end: June 30; reporting period for national accounts data: FY.
31          BWA Fiscal year end: June 30; reporting period for national accounts data: FY.
57          EGY Fiscal year end: June 30; reporting period for national accounts data: FY.
72          GMB Fiscal year end: June 30; reporting period for national accounts data: CY.
99          KEN Fiscal year end: June 30; reporting period for national accounts data: CY.
106         KWT Fiscal year end: June 30; reporting period for national accounts data: CY.
149         PAK Fiscal year end: June 30; reporting period for national accounts data: FY.
156         PRI Fiscal year end: June 30; reporting period for national accounts data: FY.
170         SLE Fiscal year end: June 30; reporting period for national accounts data: CY.
180         SWE Fiscal year end: June 30; reporting period for national accounts data: CY.
198         UGA Fiscal year end: June 30; reporting period for national accounts data: FY.
214         ZWE Fiscal year end: June 30; reporting period for national accounts data: CY.
```
To make sure we got it right, we could subset those rows not in the above result
```r
subset(croppedData, !grepl("Fiscal year end: June", Special.Notes))
```
(The result is long, boring and does not contain "Fiscal year end: June")

How about summarising the result in a table instead?
```r
table(grepl("Fiscal year end: June", croppedData$Special.Notes))
```
```
FALSE  TRUE
  202    13
```

Or we could just have done this:
```r
sum(grepl("Fiscal year end: June", croppedData$Special.Notes))
```
#### Result
```
[1] 13
```

---
### Question 4
#### Problem
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.
```r
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
```

1. How many values were collected in 2012?
2. How many values were collected on Mondays in 2012?

#### Solution
```r
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
```
Lets check out those two tables
```r
head(amzn)
```
```
           AMZN.Open AMZN.High AMZN.Low AMZN.Close AMZN.Volume AMZN.Adjusted
2007-01-03     38.68     39.06    38.05      38.70    12405100         38.70
2007-01-04     38.59     39.14    38.26      38.90     6318400         38.90
2007-01-05     38.72     38.79    37.60      38.37     6619700         38.37
2007-01-08     38.22     38.31    37.17      37.50     6783000         37.50
2007-01-09     37.60     38.06    37.34      37.78     5703000         37.78
2007-01-10     37.49     37.70    37.07      37.15     6527500         37.15
```
Ok, so that is a dataframe with OHLCV information
```r
head(sampleTimes)
```
```
[1] "2007-01-03" "2007-01-04" "2007-01-05" "2007-01-08" "2007-01-09" "2007-01-10"
```
And that is just a list with the dates of the samples from the other table. Right - lets find out how many values were collected in 2012. The Index of the table is in date format - its easier to just grepl the sampleTimes list

```r
table(grepl("^2012", sampleTimes))
```
```
FALSE  TRUE
 2621   250
 ```
How many observations on Mondays?
```r
table(grepl("Monday", weekdays(sampleTimes)) & grepl("2012", sampleTimes))
```
```
FALSE  TRUE
 2824    47
 ```
 #### Result
 250, 47
