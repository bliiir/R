| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Lecture       |[Text Variables](https://www.coursera.org/learn/data-cleaning/lecture/drpnT/editing-text-variables) |
| Week          | [ 4 ](https://www.coursera.org/learn/data-cleaning/home/week/4) |
| Lecturer      | [Jeff Leek - PhD](https://github.com/jtleek) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Distribution  | [Coursera](https://www.coursera.org) |

The PDF slides from Coursera are image based instead of text based which means that it is not possible to select the code bits or click the URLS.

Mr. Leek has been so kind as to make the [material](https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_02_regularExpressions/index.md) available on Github as well.

---

# Regular expressions I

### Metacharacters

#### ^ (carrot) = start of the line

```
^i think
```
will match the lines

>**i think** we all rule for participating  
>**i think** i have been outed  
>**i think** this will be quite fun actually

#### $ (dollar) = end of the line

```
morning$
```
will match the lines

>well they had something this **morning**  
>then had to catch a tram home in the **morning**  
>dog obedience school in the **morning**

### Character classes with
#### [ ] = either of the characters in the brackets
```
[Bb][Uu][Ss][Hh]
```
Will match the lines

>The democrats are playing, "Name the worst thing about **Bush**!"  
>I smelled the desert creosote **bush**, brownies, BBQ chicken  
>BBQ and **bush**walking at Molonglo Gorge

Because the all have "bush" in upper or lower case in them

```
^[Ii] am
```
will match

>**i am** so angry at my boyfriend i can’t even bear to look at him  
>**i am** boycotting the apple store  
>**I am** twittering from iPhone

#### - (hyphen) = range
Specifies a range of characters between x and y - for example
```
^[0-9][a-zA-Z]
```
will match the lines

>**7t**h inning stretch  
>**2n**d half soon to begin. OSU did just win something  
>**3a**m - cant sleep - too hot still.. :(  

Because each line starts with a number between 0 and 9 followed by any upper or lower case letter

#### [^] = not
When used inside the character class brackets
```
[^?.]$
```
will match the lines

>i like basketballs  
>6 and 9  
>dont worry... we all die anyway!  
>Not in Baghdad  
>helicopter under water? hmmm

Because none of the lines end with a period or question mark. It says - look for lines that end with ($) NOT ([^ ]) a question mark or a period ([^?.])

# Regular expressions II

### More metacharacters
#### . (period) = any

```
9.11
```
will match the lines

>its stupid the post **9**-**11** rules  
>if any 1 of us did **9**/**11** we would have been caught in days.  
>NetBios: scanning ip 203.16**9**.**11**4.66  
>Front Door **9**:**11**:46 AM  
>Sings: 01189998819**9**9**11**9725...3 !  

Because all of those lines have a 9 followed by any other character followed by 11.

#### | (pipe) = or


```
flood|fire
```
will match the lines

>is **fire**wire like usb on none macs?  
>the global **flood** makes sense within the context of the bible  
>yeah ive had the **fire** on tonight  
>... and the **flood**s, hurricanes, killer heatwaves, rednecks, gun nuts, etc.

Because they all have the character strings "flood" or "fire" in them
```
flood|earthquake|hurricane|coldfire
```
will match the lines

>Not a whole lot of **hurricane**s in the Arctic.  
>We do have **earthquake**s nearly every day somewhere in our State  
>**hurricane**s swirl in the other direction  
>**coldfire** is STRAIGHT!  
>’cause we keep getting **earthquake**s

#### Combinations
```
^[Gg]ood|[Bb]ad
```
will match the lines

>**good** to hear some good knews from someone here  
>**Good** afternoon fellow american infidels!  
>**good** on you-what do you drive?  
>Katie... guess they had **bad** experiences...  
>my middle name is trouble, Miss **Bad** News

Because it will find good ```([Gg]ood)``` in the beginning```(^)``` of a line and bad ```([Bb]ad)``` anywhere in a line
```
^([Gg]ood|[Bb]ad)
```
will match the lines

>**bad** habbit  
>**bad** coordination today  
>**good**, becuase there is nothing worse than a man in kinky underwear  
>**Bad**cop, its because people want to use drugs  
>**Good** Monday Holiday  
>**Good** riddance to Limey

Because both expressions on each side of the | character are in paranthesis and the ^ is before the paranthesis

### More Metacharacters

### ?
```
[Gg]eorge( [Ww]\.)? [Bb]ush
```
will match the lines

>i bet i can spell better than you and **george bush** combined  
>BBC reported that President **George W. Bush** claimed God told him to invade  
>a bird in the hand is worth two **george bush**es  

Because the [Ww]\. (Finds "W." and "w.") is wrapped in paranthesis with a questionmark after which makes it optional. The "\" before the "." is there to escape the metacharacter "."

### * = any number including none



### + = at least one of the item

```
[0-9]+ (.*)[0-9]+
```
will match the lines

> working as MP here **72**0 MP battallion, 42nd birgade  
> so say **2** or **3** years at colleage and 4 at uni makes us 23 when and if we fin  
> it went down on several occasions for like, **3** or **4** *days*  
> Mmmm its time **4** me **2** go 2 bed

Because it finds at least one number between 0 and 9 first, and then any number of characters including none and then at least one number between 0 and 9

### {} = between (interval)
```
[Bb]ush( +[^ ]+ +){1,5} debate
```
will match the lines

>**Bush** has historically won all major **debates** he’s done.  
>in my view, **Bush** doesn’t need these **debate**s..  
>**bush** doesn’t need the **debates**? maybe you are right  
>That’s what **Bush* supporters are doing about the **debate**.  
>Felix, I don’t disagree that **Bush** was poorly prepared for the **debate**.  
>indeed, but still, **Bush** should have taken the **debate** more seriously.  
>Keep repeating that **Bush** smirked and scowled during the **debate**

Because:
* ```"[Bb]ush"``` The word Bush upper or lower case  
* ```" +"``` at least one space  
* ```"[^ ]"``` at least one character that is not a space  
* ```" +"``` at least one space  
* ```"{1,5}"``` between one and five times  
* ```" debate"``` the word debate preceeded by a space

More on {}

* ```{m,n}``` at least m, but no more than n matches  
* ```{m}``` exactly m matches  
*  ```{m,}``` at least m matches

## ( and ) revisited
```
 +([a-zA-Z]+) +\1 +
```
will match the lines

>time for bed, night night twitter!  
>blah blah blah blah  
>my tattoo is so so itchy today  
>i was standing all all alone against the world outside...  
>hi anybody anybody at home  
>estudiando css css css css.... que desastritooooo

```
" +"            at least one space
"(              Start parenthesis
    [           Start group
        a-z     lower case characters from a to z
        A-Z     lower case characters from a to z
    ]+          At least one group
)"              End parenthesis
" +"            at least one space
"\1"            One (1) replication of what what preceeds the \ metacharacter
" +"            at least one space
```

So, at least on space followed by characters followed by at least on space repeated at least once and at least one space at the end. It looks for a repetition of any phrase.

"\*" is greedy, meaning it takes the longest possible result
```
^s(.*)s
```
matches

>sitting at starbucks  
>setting up mysql and rails  
>studying stuff for the exams  
>spaghetti with marshmallows  
>stop fighting with crackers  
>sore shoulders, stupid ergonomics

Looks for a string that starts and ends with an "s". If more than one result is possible, like in the last like where one result could be "sore shoulders" and another "sore shoulders, stupid ergonomics", it matches the longer one.

Greediness can be turned off with "?"
```
^s(.*?)s$
```
In which case the expression would return

>sore shoulders

For the last line above
