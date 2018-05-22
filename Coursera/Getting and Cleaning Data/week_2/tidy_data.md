| Course        | [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome) |
| :---          | :--- |
| Distribution  | [Coursera](https://www.coursera.org) |
| Class          | [Week 2, Storage Systems](https://www.coursera.org/learn/data-cleaning/home/week/2) |
| Lecture       |[Tidy Data (extra) Web](https://vimeo.com/33727555) |
| Institution   | [Johns Hopkins University](https://www.jhu.edu/) |
| Educators     | [Jeff Leek - PhD](https://github.com/jtleek),  [Roger D. Peng - PhD](https://github.com/rdpeng),  [Brian Caffo - PhD](https://github.com/bcaffo) |
| Lecturer      | [Hadley Wickham](https://github.com/hadley), Assistant Professor of Statistics at Rice University, and creator of many of the most popular R packages in CRAN. |

# Tidy data



Spend time building a tidy dataset in the beginning so you can spend all your time on analysis later.


Data that makes data analysis easy


From [JTLeeks](https://github.com/jtleek) [Datasharing](https://github.com/jtleek/datasharing) Github page:

* Each variable you measure should be in one column  
* Each different observation of that variable should be in a different row  
* There should be one table for each "kind" of variable  
* If you have multiple tables, they should include a column in the table that allows them * to be joined or merged


|       | Variable  |
| ---   | ---       |
| Observation | Count |

## Examples
### Messy
| Religion | < $10K  | $10 - 20k | $20 - 40k | $30 40K |
| ---   | --- | --- | --- | --- |
| Agnostic | 27 | 34 | 60 | 81 |
| Atheist | 12 | 27 | 37 | 53 |
| Budhist | 27 | 21 | 30 | 34 |


### Tidy
| religion | income  | count |
| ---   | --- | --- |
| Agnostic | <$10K | 27 |
| Atheist | <$10K | 12 |
| Budhist | <$10K | 27 |
