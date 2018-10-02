cm009 Exercises: tidy data
================

``` r
suppressPackageStartupMessages(library(tidyverse))
```

Reading and Writing Data: Exercises
-----------------------------------

Make a tibble of letters, their order in the alphabet, and then a pasting of the two columns together.

``` r
tibble(let = letters,
       num = 1:length(letters),
       comb = paste0(let, num))
```

    ## # A tibble: 26 x 3
    ##    let     num comb 
    ##    <chr> <int> <chr>
    ##  1 a         1 a1   
    ##  2 b         2 b2   
    ##  3 c         3 c3   
    ##  4 d         4 d4   
    ##  5 e         5 e5   
    ##  6 f         6 f6   
    ##  7 g         7 g7   
    ##  8 h         8 h8   
    ##  9 i         9 i9   
    ## 10 j        10 j10  
    ## # ... with 16 more rows

Make a tibble of three names and commute times.

``` r
tribble(
  ~name, ~time,
  "Frank", 30,
  "Lisa", 15,
  "Fred", 40
)
```

    ## # A tibble: 3 x 2
    ##   name   time
    ##   <chr> <dbl>
    ## 1 Frank    30
    ## 2 Lisa     15
    ## 3 Fred     40

Write the `iris` data frame as a `csv`.

``` r
write_csv(iris, "iris.csv")
```

Write the `iris` data frame to a file delimited by a dollar sign.

``` r
write_delim(iris, "iris.txt", delim = "$")
```

Read the dollar-delimited `iris` data to a tibble.

``` r
read_delim("iris.txt", delim = "$")
```

    ## Parsed with column specification:
    ## cols(
    ##   Sepal.Length = col_double(),
    ##   Sepal.Width = col_double(),
    ##   Petal.Length = col_double(),
    ##   Petal.Width = col_double(),
    ##   Species = col_character()
    ## )

    ## # A tibble: 150 x 5
    ##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
    ##  1          5.1         3.5          1.4         0.2 setosa 
    ##  2          4.9         3            1.4         0.2 setosa 
    ##  3          4.7         3.2          1.3         0.2 setosa 
    ##  4          4.6         3.1          1.5         0.2 setosa 
    ##  5          5           3.6          1.4         0.2 setosa 
    ##  6          5.4         3.9          1.7         0.4 setosa 
    ##  7          4.6         3.4          1.4         0.3 setosa 
    ##  8          5           3.4          1.5         0.2 setosa 
    ##  9          4.4         2.9          1.4         0.2 setosa 
    ## 10          4.9         3.1          1.5         0.1 setosa 
    ## # ... with 140 more rows

Read these three LOTR csv's, saving them to `lotr1`, `lotr2`, and `lotr3`:

-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv>
-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv>
-   <https://github.com/jennybc/lotr-tidy/blob/master/data/The_Return_Of_The_King.csv>

``` r
lotr1 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
lotr2 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
lotr3 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

`gather()`
----------

(Exercises largely based off of Jenny Bryan's [gather tutorial](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md))

This function is useful for making untidy data tidy (so that computers can more easily crunch the numbers).

1.  Combine the three LOTR untidy tables (`lotr1`, `lotr2`, `lotr3`) to a single untidy table by stacking them.

``` r
lotr_untidy <- bind_rows(lotr1, lotr2, lotr3)
```

1.  Convert to tidy. Also try this by specifying columns as a range, and with the `contains()` function.

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female, Male)
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Two Towers             Elf    Female   331
    ##  5 The Two Towers             Hobbit Female     0
    ##  6 The Two Towers             Man    Female   401
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Two Towers             Elf    Male     513
    ## 14 The Two Towers             Hobbit Male    2463
    ## 15 The Two Towers             Man    Male    3589
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female:Male)
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Two Towers             Elf    Female   331
    ##  5 The Two Towers             Hobbit Female     0
    ##  6 The Two Towers             Man    Female   401
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Two Towers             Elf    Male     513
    ## 14 The Two Towers             Hobbit Male    2463
    ## 15 The Two Towers             Man    Male    3589
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", contains("ale"))
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Two Towers             Elf    Female   331
    ##  5 The Two Towers             Hobbit Female     0
    ##  6 The Two Towers             Man    Female   401
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Two Towers             Elf    Male     513
    ## 14 The Two Towers             Hobbit Male    2463
    ## 15 The Two Towers             Man    Male    3589
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

1.  Try again (bind and tidy the three untidy data frames), but without knowing how many tables there are originally.
    -   The additional work here does not require any additional tools from the tidyverse, but instead uses a `do.call` from base R -- a useful tool in data analysis when the number of "items" is variable/unknown, or quite large.

``` r
lotr_list <- list(lotr1, lotr2, lotr3)
do.call(bind_rows, lotr_list)
```

    ## # A tibble: 9 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 4 The Two Towers             Elf       331   513
    ## 5 The Two Towers             Hobbit      0  2463
    ## 6 The Two Towers             Man       401  3589
    ## 7 The Return Of The King     Elf       183   510
    ## 8 The Return Of The King     Hobbit      2  2673
    ## 9 The Return Of The King     Man       268  2459

`spread()`
----------

(Exercises largely based off of Jenny Bryan's [spread tutorial](https://github.com/jennybc/lotr-tidy/blob/master/03-spread.md))

This function is useful for making tidy data untidy (to be more pleasing to the eye).

Read in the tidy LOTR data (despite having just made it):

``` r
lotr_tidy <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Gender = col_character(),
    ##   Words = col_integer()
    ## )

Get word counts across "Race". Then try "Gender".

``` r
spread(lotr_tidy, key = "Race", value = "Words")
```

    ## # A tibble: 6 x 5
    ##   Film                       Gender   Elf Hobbit   Man
    ##   <chr>                      <chr>  <int>  <int> <int>
    ## 1 The Fellowship Of The Ring Female  1229     14     0
    ## 2 The Fellowship Of The Ring Male     971   3644  1995
    ## 3 The Return Of The King     Female   183      2   268
    ## 4 The Return Of The King     Male     510   2673  2459
    ## 5 The Two Towers             Female   331      0   401
    ## 6 The Two Towers             Male     513   2463  3589

Now try combining race and gender. Use `unite()` from `tidyr` instead of `paste()`.

``` r
lotr_tidy %>% 
  unite(Race_Gender, Race, Gender) %>% 
  spread(key = "Race_Gender", value = "Words")
```

    ## # A tibble: 3 x 7
    ##   Film   Elf_Female Elf_Male Hobbit_Female Hobbit_Male Man_Female Man_Male
    ##   <chr>       <int>    <int>         <int>       <int>      <int>    <int>
    ## 1 The F~       1229      971            14        3644          0     1995
    ## 2 The R~        183      510             2        2673        268     2459
    ## 3 The T~        331      513             0        2463        401     3589

``` r
lotr_tidy %>% 
  mutate(x = rnorm(nrow(lotr_tidy))) %>% 
  spread(key = "Gender", value = "x")
```

    ## # A tibble: 18 x 5
    ##    Film                       Race   Words  Female    Male
    ##    <chr>                      <chr>  <int>   <dbl>   <dbl>
    ##  1 The Fellowship Of The Ring Elf      971  NA      -1.60 
    ##  2 The Fellowship Of The Ring Elf     1229   0.352  NA    
    ##  3 The Fellowship Of The Ring Hobbit    14   0.722  NA    
    ##  4 The Fellowship Of The Ring Hobbit  3644  NA       0.594
    ##  5 The Fellowship Of The Ring Man        0   0.487  NA    
    ##  6 The Fellowship Of The Ring Man     1995  NA      -0.179
    ##  7 The Return Of The King     Elf      183  -0.268  NA    
    ##  8 The Return Of The King     Elf      510  NA       0.402
    ##  9 The Return Of The King     Hobbit     2   1.39   NA    
    ## 10 The Return Of The King     Hobbit  2673  NA      -0.605
    ## 11 The Return Of The King     Man      268  -2.24   NA    
    ## 12 The Return Of The King     Man     2459  NA      -1.22 
    ## 13 The Two Towers             Elf      331   0.299  NA    
    ## 14 The Two Towers             Elf      513  NA       0.302
    ## 15 The Two Towers             Hobbit     0  -1.16   NA    
    ## 16 The Two Towers             Hobbit  2463  NA       0.429
    ## 17 The Two Towers             Man      401   0.487  NA    
    ## 18 The Two Towers             Man     3589  NA      -1.08

Other `tidyr` goodies
---------------------

Check out the Examples in the documentation to explore the following.

`expand` vs `complete` (trim vs keep everything). Together with `nesting`. Check out the Examples in the `expand` documentation.

``` r
mtcars
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

``` r
expand(mtcars, vs, cyl)
```

    ## # A tibble: 6 x 2
    ##      vs   cyl
    ##   <dbl> <dbl>
    ## 1     0     4
    ## 2     0     6
    ## 3     0     8
    ## 4     1     4
    ## 5     1     6
    ## 6     1     8

``` r
df <- tibble(
  year   = c(2010, 2010, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   1,    2,    3,    4,    1,    2,    3),
  return = rnorm(7)
)
df %>% expand(year, qtr)
```

    ## # A tibble: 8 x 2
    ##    year   qtr
    ##   <dbl> <dbl>
    ## 1  2010     1
    ## 2  2010     2
    ## 3  2010     3
    ## 4  2010     4
    ## 5  2012     1
    ## 6  2012     2
    ## 7  2012     3
    ## 8  2012     4

``` r
df %>% expand(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <dbl> <dbl>
    ##  1  2010     1
    ##  2  2010     2
    ##  3  2010     3
    ##  4  2010     4
    ##  5  2011     1
    ##  6  2011     2
    ##  7  2011     3
    ##  8  2011     4
    ##  9  2012     1
    ## 10  2012     2
    ## 11  2012     3
    ## 12  2012     4

``` r
df %>% complete(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 3
    ##     year   qtr  return
    ##    <dbl> <dbl>   <dbl>
    ##  1  2010     1   1.68 
    ##  2  2010     2  -0.382
    ##  3  2010     3  -0.247
    ##  4  2010     4   0.245
    ##  5  2011     1  NA    
    ##  6  2011     2  NA    
    ##  7  2011     3  NA    
    ##  8  2011     4  NA    
    ##  9  2012     1   1.03 
    ## 10  2012     2  -0.813
    ## 11  2012     3  -0.770
    ## 12  2012     4  NA

``` r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurment_1 = runif(6),
  measurment_2 = runif(6)
)
experiment
```

    ## # A tibble: 6 x 5
    ##   name   trt     rep measurment_1 measurment_2
    ##   <chr>  <chr> <dbl>        <dbl>        <dbl>
    ## 1 Alex   a         1      0.00957      0.182  
    ## 2 Alex   a         2      0.133        0.116  
    ## 3 Alex   a         3      0.370        0.542  
    ## 4 Robert b         1      0.642        0.00789
    ## 5 Robert b         2      0.214        0.925  
    ## 6 Sam    a         1      0.860        0.600

``` r
all <- experiment %>% expand(nesting(name, trt), rep)
all
```

    ## # A tibble: 9 x 3
    ##   name   trt     rep
    ##   <chr>  <chr> <dbl>
    ## 1 Alex   a         1
    ## 2 Alex   a         2
    ## 3 Alex   a         3
    ## 4 Robert b         1
    ## 5 Robert b         2
    ## 6 Robert b         3
    ## 7 Sam    a         1
    ## 8 Sam    a         2
    ## 9 Sam    a         3

`separate_rows`: useful when you have a variable number of entries in a "cell".

``` r
df <- data.frame(
  x = 1:3,
  y = c("a", "d,e,f", "g,h"),
  z = c("1", "2,3,4", "5,6"),
  stringsAsFactors = FALSE
)
separate_rows(df, y, z, convert = TRUE)
```

    ##   x y z
    ## 1 1 a 1
    ## 2 2 d 2
    ## 3 2 e 3
    ## 4 2 f 4
    ## 5 3 g 5
    ## 6 3 h 6

`unite` and `separate`.

`uncount` (as the opposite of `dplyr::count()`)

``` r
df <- tibble::tibble(x = c("a", "b"), n = c(1, 2))
df
```

    ## # A tibble: 2 x 2
    ##   x         n
    ##   <chr> <dbl>
    ## 1 a         1
    ## 2 b         2

``` r
uncount(df, n)
```

    ## # A tibble: 3 x 1
    ##   x    
    ##   <chr>
    ## 1 a    
    ## 2 b    
    ## 3 b

`drop_na` and `replace_na`

`fill`

`full_seq`

Time remaining?
---------------

Time permitting, do [this exercise](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md#exercises) to practice tidying data.
