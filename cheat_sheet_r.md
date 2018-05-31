# Cheat Sheet
| | |
| :---          | :--- |
| Author | [bliiir](https://github.com/bliiir) |
| Version | 1.0 |
| Created | 20180531 |
| Last updated | 20180531 |

---

## Regular Expressions

#### Meta characters
If inside "" these characters will be interpreted as regex unless they are escaped using a double backslash \\\
| Metacharacter | Nickname |  Effect |
| :--- | :--- | :--- |
| ```^``` | carrot | start of the line |
| ```$``` | dollar | end of the line |
| ```[]``` | brackets | either of the characters inside the brackets |
| ```[^x]``` | bracket carrot bracket | not x |
| ```x-y```  | hyphen | range from x to y |
| ```.``` | period | any character |
| ```x | y``` | pipe | x or y |
| ```x?``` | questionmark | x is optional |
| ```x*``` | asterisk | any number of x including none |
| ```x+``` | plus | any number of x including none |
| ```{x, y}``` | curly braces | between x and y |

---

## R
### Text manipulation
| Command | Description | Example | |
| :--- | :--- | :--- | :--- |
| ```tolower(x)``` | changes all characters in x to lowercase | tolower("HelLO") | "hello" |  
| ```toupper(x)``` | changes all characters in x to uppercase | toupper("HelLO") | "HELLO" |
| ```strsplit(x,y)``` | splits x up into a vector of elements using y as the split criteria | strsplit("Hello World!"), " ") | "Hello" "World" |
| ```list(x, y, z)``` | Creates a list of x, y, z  | ```list(numbers = c(1,2,3), hello = c("Hello","World"), "end")``` | $numbers\n"Hello" "World"|
| ```sapply(x,y)``` | Apply y to x   |
| ```sub(x, y, z)``` | Substitutes the first instance of x with y in z and returns z|
| ```gsub(x, y, z)``` | Substitutes all instances of x with y in z and returns z |
| ```nchar(x)``` | returns number of characters in x |
| ```substr(x,y,z)``` | cut out character y to z from x |
| ```paste(x,y,..)``` | concatenate x, y, ... |
| ```str_trim(x)``` | remove whitspace in x |
| ```grep(x, y)``` | Finds x regex in y and returns a vector of their positions |
| ```grpl(x, y)``` | Finds x regex in y and returns a vector of booleans corresponding to the positons in y |
