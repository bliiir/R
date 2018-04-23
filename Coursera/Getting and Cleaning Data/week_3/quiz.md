### Question 1
#### Problem

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

 and load the data into R. The code book, describing the variable names is here:

    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?

#### Solution
```r
# Check if the folder "data" exists, if not, create it
if(!file.exists("./data")){dir.create("./data")}

# Set the file URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

# Download the csv file into the data folder
download.file(fileUrl, destfile="./data/housing.csv", method="curl")

# Read the CSV into R
housing <- read.csv("./data/housing.csv")

# Codebook
# The ACR variable is a factor for Lot sizes and the value 3 means more than 10 acres
# The AGS variable is a factor for Sales and the value 6 means more than 10k$ of sales

agricultureLogical <- housing$ACR == 3 & housing$AGS == 6

which(agricultureLogical)
```
```
 [1]  125  238  262  470  555  568  608  643  787  808  824  849  952  955 1033 1265 1275 1315 1388 1607 1629 1651 1856 1919 2101 2194 2403 2443 2539 2580 2655 2680 2740
[34] 2838 2965 3131 3133 3163 3291 3370 3402 3585 3652 3852 3862 3912 4023 4045 4107 4113 4117 4185 4198 4310 4343 4354 4448 4453 4461 4718 4817 4835 4910 5140 5199 5236
[67] 5326 5417 5531 5574 5894 6033 6044 6089 6275 6376 6420
```
#### Result
```
125  238  262
```

---

### Question 2
#### Problem
Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

#### Solution
```r
# Check if the folder "data" exists, if not, create it
if(!file.exists("./data")){dir.create("./data")}

# Set the file URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

# Download the csv file into the data folder
download.file(fileUrl, destfile="./data/jtleek.jpg", method="curl")

data <- readJPEG("./data/jtleek.jpg", native = TRUE) %>%
    quantile(probs = c(0.3, 0.8)) %>%
    print
```
#### Result
```
      30%       80%
-15259150 -10575416
```

---

### Question 3
#### Problem
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

#### Solution
First a bit of household chores
```r
# Check if the folder "data" exists, if not, create it
if(!file.exists("./data")){dir.create("./data")}
```
Then lets work on the gdp dataset
```r
# Set the file URL
file1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

# Download file
download.file(file1, destfile="./data/gdp.csv", method="curl")

# Load the data
gdp <- read.csv("./data/gdp.csv", stringsAsFactors = F, header = F, na.strings = c("", "NA"))


# Remove irrelevant columns
gdp <- gdp[ , c(1, 2, 4, 5)]

# Rename the columns to make sense
colnames(gdp) <- (c("CountryCode", "Rank", "Name", "GDP"))

# Remove the rows with no data in the CountryCode - they don't actually want me to do this it seems from the choices in the quiz
gdp <- filter(gdp, CountryCode != "NA")

# Convert gdp to numeric by first replacing the "," with ""
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP))

# Convert rank to numeric
gdp$Rank <- as.numeric(gdp$Rank)

# Rearrange columns (because I am like that)
gdp <- select(gdp, CountryCode, Name, GDP, Rank)
```
And now the education stats
```r
# Set the file URL
file2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Download file
download.file(file2, destfile="./data/edstats.csv", method="curl")

# Load the data
edstats <- read.csv("./data/edstats.csv",stringsAsFactors = F)

# This data set is already tidy so I will go straight to merging
mergedData = merge(gdp,edstats,by="CountryCode", all=T)

# Sort the list so the countries with the lowest gdp are at the top
mergedData <- arrange(mergedData, desc(Rank))
```
#### Result
How many matches?
```r
# Get the unique ranks to avoid the ones that didn't match
sum(!is.na(unique(mergedData$Rank)))
```
```
[1] 189
```
What is the 13th country?
```r
mergedData[13, 2 ]
```
```
[1] "St. Kitts and Nevis"
```
---

### Question 4
#### Problem
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

#### Solution
First I need to convert the ranking to a numer so I can use it in a calculation. I already did that for the gpd table, but not the other one, so the resulting variable is a char and I need to do it for the merged table as well.
```r
mergedData$Rank <- as.numeric(mergedData$Rank)
```
For a better overview, I am going to subset the variables to only the ones I need
```r
icg <- select(mergedData, Rank, Income.Group)
```
And now a function to calculate the mean of the Rank column for a given income.Group
```r
avg_rank <- function(label) {
    icg <- filter(icg, Income.Group == label)
    mean(icg$Rank, na.rm = T)
}
```
#### Result
Finally calling the function, first with "High income: OECD" as the input
```r
avg_rank("High income: OECD")
```
```
[1] 32.96667
```
And lastly "High income: nonOECD" as the input
```r
avg_rank("High income: OECD")
```
```
[1] 91.91304
```

### Question 5
#### Problem
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.

How many countries are Lower middle income but among the 38 nations with highest GDP?

#### solution
First I am going to remove the NAs in the Rank column
```r
icg <- filter(icg, Rank != "NA")
```
Then I am going to add another column called RankGroups which I cut into 5. It would have been better to not use the Hmisc library and cut 2 and instead gone for a dplyr command in my opinion, but I was out of time and this got the job done nicely.
```r
library(Hmisc)
icg$RankGroups <- cut2(icg$Rank, g=5)
```
Then I am going to create a table with RankGroups as row names and Income Groups as column headers
```r
table(icg$RankGroups, icg$Income.Group)
```
```
               High income: nonOECD High income: OECD Low income Lower middle income Upper middle income
  [  1, 39)  0                    4                18          0                   5                  11
  [ 39, 77)  0                    5                10          1                  13                   9
  [ 77,115)  0                    8                 1          9                  12                   8
  [115,153)  0                    4                 1         16                   8                   8
  [153,190]  0                    2                 0         11                  16                   9
```
#### Result
Then I will subset the first row (1-39 ranking) and the fifth column (lower middle income)
```r
table(icg$RankGroups, icg$Income.Group)[1,5]
```
```
[1] 5
```
5/5 score
