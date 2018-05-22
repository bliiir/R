# Check if the folder "data" exists, if not, create it
if(!file.exists("./data")){dir.create("./data")}

# Set the file URL

# Tidy the data

## gdp

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

# Convert rank to numeric
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP))
gdp$Rank <- as.numeric(gdp$Rank)

# Rearrange columns (because I am like that)
gdp <- select(gdp, CountryCode, Name, GDP, Rank)

# Print to console
head(gdp)
    

## edstats

# Set the file URL
file2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Download file
download.file(file2, destfile="./data/edstats.csv", method="curl")

# Load the data
edstats <- read.csv("./data/edstats.csv",stringsAsFactors = F)

# This data set is already tidy so I will go straight to merging 
mergedData = merge(gdp,edstats,by="CountryCode", all=T)

mergedData <- arrange(mergedData, desc(Rank))

# Find number of matches
dim(mergedData)[1]


# Find the 13th
res2 <- mergedData[13, 2 ]