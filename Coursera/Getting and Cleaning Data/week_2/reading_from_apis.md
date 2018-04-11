| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Distribution  | [Coursera](https://www.coursera.org) |
| Part          | [Week 2, Storage Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Lecture       | [Reading data from APIs](https://www.coursera.org/learn/data-cleaning/lecture/gIaQK/reading-from-apis) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |


The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.  

To follow the lecture, I had to reconstruct all the URLs and code snippets anyway and thought they might be useful for others as well

*Links from the slides are at the bottom of this document*

# Storage Systems

## Reading from APIs

### Accessing Twitter from R
First create an app on Twitters [site](https://apps.twitter.com/). Then generate a new token and copy both the consumer key/secret and the access token key/secret.

Load the httr and jsonlite libraries into R
```r
library(httr)
library(jsonlite)
```

Start the authorization process for my app using my consumer credentials
```r
myapp <- oauth_app("twitter",
    key="yourConsumerKeyHere",
    secret="yourConsumerSecretHere", redirect_uri = NULL)
```
Then sign in to the app
```r
sig <- sign_oauth1.0(myapp,
    token = "yourTokenHere",
    token_secret = "yourTokenSecretHere")
```
Use GET to retrieve the json and then store it in an object
```r
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
```
Now parse the json into a variable
```r
json1 <- content(homeTL)
```
Convert it back into json to make it easier to read
```r
json2 <- jsonlite::fromJSON(toJSON(json1))
```
Output the first row of column 1 to 40 to the console
```r
json2[1, 1:4]
```
Voila!
```
created_at           id             id_str
1 Wed Apr 11 10:51:39 +0000 2018 9.840212e+17 984021150316539904
                                                                                                                   text
1 RT @VoxPodcast: We're about to go live on our Facebook page with @NicTrades looking at the charts of AB Dynamics #ABDP Flying Brands #FBDU…
```



#### Links from the video
```
https://dev.twitter.com/docs/api/1/get/blocks/blocking
https://dev.twitter.com/apps
https://dev.twitter.com/docs/api/1.1/get/search/tweets
https://dev.twitter.com/docs/api/1.1/overview
```
