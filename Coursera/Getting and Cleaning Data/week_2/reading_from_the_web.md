| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Distribution  | [Coursera](https://www.coursera.org) |
| Class          | [Week 2, Storage Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Lecture       |[Reading data from the Web](https://www.coursera.org/learn/data-cleaning/lecture/oKUph/reading-from-the-web) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |


The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.  

To follow the lecture, I had to reconstruct all the URLs and code snippets anyway and thought they might be useful for others as well

*Links from the slides are at the bottom of this document*

# Storage Systems

## Reading from the Web

### Getting data off webpages
Create a connection (con) to the site

```r
con= url( "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en" )
```
Read the html with readlines()
```
htmlCode = readLines(con)
```
Close the connection to the url
```r
close(con)
```
Print the result to the console
```r
htmlCode
```
```
 [1] "<!doctype html><html><head><title>Jeff Leek - Google Scholar Citations</title><meta http-equiv=\"Content-Type\" content=\"text/html;charset=ISO-8859-1\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\ ...
```
### Parsing with XML
Load the XML library into R
```r
library (XML)
```
Create a connection to the source (replaced the original url as https does not work with this method)
```r
url <- "http://web.mit.edu/"


```
Parse the HTML and store it
```r
html<- htmlTreeParse(url, useInternalNodes= T)
```
Get the title of the page
```r
xpathSApply(html, "//title" , xmlValue)
```
```
[1] "MIT - Massachusetts Institute of Technology"
```
Now get a specific section using the [xpath](https://docs.marklogic.com/guide/xquery/xpath)
```r
xpathSApply(html, path = "//div[@id='footer']/div/div/p[2]/a" , xmlValue)
```
```
[1] "MIT on Facebook"           "MIT on Twitter"            "MIT News Google Plus page" "MIT on YouTube"  
```

### GET from the httr package
Learn more about httr [here](https://cran.r-project.org/web/packages/httr/httr.pdf)

Load the httr library into R
```r
library (httr)
```
Set the URL
```r
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
```
Use the GET command from the httr package *(this **does** actually work with https/SSL)*
```r
html2 = GET(url)
```
Store the raw output from the GET command in a text file
```r
content2 = content(html2, as="text")
```
Parse the text file as html
```r
parsedHtml = htmlParse(content2,asText =TRUE)
```
Grab the title from the resulting html
```r
xpathSApply(parsedHtml, "//title" , xmlValue)
```
```
[1] "Jeff Leek - Google Scholar Citations"
```

### Accessing websites with passwords
Set the URL
```r
url <- "http://httpbin.org/basic-auth/user/passwd"
```
Get and store the content
```r
pg1 = GET(url)
```
Print the output to the console
```r
pg1
```
```html
Response [http://httpbin.org/basic-auth/user/passwd]
  Date: 2018-04-10 14:09
  Status: 401
  Content-Type: <unknown>
<EMPTY BODY>
```
Status [401](https://httpstatuses.com/401) means unauthorized access. This means we will have to authenticate ourselves to access the content
```r
pg2 = GET(url, authenticate( "user" , "passwd" ))
```
Print the result to the console
```r
pg2
```
```html
Response [http://httpbin.org/basic-auth/user/passwd]
  Date: 2018-04-10 14:15
  Status: 200
  Content-Type: application/json
  Size: 47 B
{
  "authenticated": true,
  "user": "user"
}
```
Get the names
```r
names(pg2)
```
```
[1] "url"   "status_code" "headers" "all_headers" "cookies" "content"   "date"  "times"      
[9] "request"   "handle"
```
Lets try to access some of these items
Content:
```r
content(pg2, as="text")
```
```
[1] "{\n  \"authenticated\": true, \n  \"user\": \"user\"\n}\n"
```
Status
```r
status_code(pg2)
```
```
[1] 200
```
Headers
```r
headers(pg2)
```
```
$connection
[1] "keep-alive"

$server
[1] "meinheld/0.6.1"

$date
[1] "Tue, 10 Apr 2018 14:15:11 GMT"

$`content-type`
[1] "application/json"

$`access-control-allow-origin`
[1] "*"

$`access-control-allow-credentials`
[1] "true"

$`x-powered-by`
[1] "Flask"

$`x-processed-time`
[1] "0"

$`content-length`
[1] "47"

$via
[1] "1.1 vegur"

attr(,"class")
[1] "insensitive" "list"
```
Cookies
```r
cookies(pg2)
```
```
[1] domain     flag       path       secure     expiration name       value     
<0 rows> (or 0-length row.names)
```

### Using handles
```r
url <- "http://httpbin.org/basic-auth/user/passwd"
hdl <- handle(url)
pg2 = GET(hdl, config = list(authenticate( "user", "passwd")))
```

google = handle("http://google.com")
pg1 = GET(handle=google, path = "/")
pg2 = GET(handle=google, path= "search")


#### Links from the video
* https://www.r-bloggers.com/how-netflix-reverse-engineered-hollywood/
* http://en.wikipedia.org/wiki/Web_scraping
* http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en
* http://cran.r-project.org/web/packages/httr/httr.pdf
* http://www.r-bloggers.com/?s=Web+Scraping
