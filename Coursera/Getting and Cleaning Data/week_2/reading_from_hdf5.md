| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Distribution  | [Coursera](https://www.coursera.org) |
| Part          | [Week 2, Storage,  Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Lecture       |[Reading from HDF5]() |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |


The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.  

To follow the lecture, I had to reconstruct all the URLs and code snippets anyway and thought they might be useful for others as well

# Storage Systems

## HDF5

### R HDF5 package

Source the file from Biconductor
```r
source("http://bioconductor.org/biocLite.R")
```
Load the rhd5 package using the biocLite function from the BiocLite file
```r
biocLite("rhdf5")
```
Load the hdf5 library
```r
library (rhdf5)
```

### Create a hdf5 file
```r
created <- h5createFile("example.h5")
created
```
    [1] TRUE

### Create groups
*within the hdf5 file*

created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "bar")
created <- h5createGroup("example.h5", "foo/foobaa")
```
List the contents of the example.h5 file using Knitr  
```r
kable(h5ls("example.h5"))
```
```
|   |group |name   |otype     |dclass |dim |
|:--|:-----|:------|:---------|:------|:---|
|0  |/     |bar    |H5I_GROUP |       |    |
|1  |/     |foo    |H5I_GROUP |       |    |
|2  |/foo  |foobaa |H5I_GROUP |       |    |
```
### Write to groups
Create a matrix A
```r
A = matrix(1:10, nr=5, nc=2)
```
Store the matrix A in th file and in the group foo
```r
h5write(A, "example.h5", "foo/A")
```
Print it to the console
```r
kable(h5ls("example.h5"))
```
```
|   |group |name   |otype       |dclass  |dim   |
|:--|:-----|:------|:-----------|:-------|:-----|
|0  |/     |bar    |H5I_GROUP   |        |      |
|1  |/     |foo    |H5I_GROUP   |        |      |
|2  |/foo  |A      |H5I_DATASET |INTEGER |5 x 2 |
|3  |/foo  |foobaa |H5I_GROUP   |        |      |
```

Create an array B and add an attribute "scale" to it
```r
B = array(seq(0.1, 2.0, by=0.1), dim=c(5, 2, 2))
attr(B, "scale") <- "liter"
```
Store the array B in the  - This part didn't work for me.
```r
h5write(B, "example.h5", "foo/foobaa/B")
```
Print it to the console
```r
kable(h5ls("example.h5"))
```
```
|   |group       |name   |otype       |dclass  |dim       |
|:--|:-----------|:------|:-----------|:-------|:---------|
|0  |/           |bar    |H5I_GROUP   |        |          |
|1  |/           |foo    |H5I_GROUP   |        |          |
|2  |/foo        |A      |H5I_DATASET |INTEGER |5 x 2     |
|3  |/foo        |foobaa |H5I_GROUP   |        |          |
|4  |/foo/foobaa |B      |H5I_DATASET |FLOAT   |5 x 2 x 2 |
```

### Write a data set
```r
df <- data.frame(1L:5L, seq(0, 1, length.out = 5 ), c("ab" , "cde" , "fghi" , "a" , "s" ), stringsAsFactors= FALSE)
h5write(df, "example.h5" , "df")
kable(h5ls("example.h5"))
```
```
|   |group       |name   |otype       |dclass   |dim       |
|:--|:-----------|:------|:-----------|:--------|:---------|
|0  |/           |bar    |H5I_GROUP   |         |          |
|1  |/           |df     |H5I_DATASET |COMPOUND |5         |
|2  |/           |foo    |H5I_GROUP   |         |          |
|3  |/foo        |A      |H5I_DATASET |INTEGER  |5 x 2     |
|4  |/foo        |foobaa |H5I_GROUP   |         |          |
|5  |/foo/foobaa |B      |H5I_DATASET |FLOAT    |5 x 2 x 2 |
```

### Reading data
```r
readA = h5read( "example.h5", "foo/A" )
readB = h5read( "example.h5", "foo/foobaa/B" )
readdf= h5read( "example.h5", "df" )
readA
```
```
    [,1]    [,2]
[1,]    1    6
[2,]    2    7
[3,]    3    8
[4,]    4    9
[5,]    5   10
```




#### Links from the video
```
http://www.hdfgroup.org/
http://bioconductor.org/
http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
http://www.hdfgroup.org/HDF5/
```
