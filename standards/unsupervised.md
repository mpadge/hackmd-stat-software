---
title: Unsupervised Learning Software
tags: statistical-software
robots: noindex, nofollow
---


<!-- Edit the .Rmd not the .md file -->

Dimensionality Reduction, Clustering, and Unsupervised Learning
---------------------------------------------------------------

Click on the following link to view a demonstration [Application of
Dimensionality Reduction, Clustering, and Unsupervised Learning
Standards](https://hackmd.io/iOZD_oCpT86zoY5z4memaQ).

This document details standards for Dimensionality Reduction,
Clustering, and Unsupervised Learning Software – referred to from here
on for simplicity as “Unsupervised Learning Software”. Software in this
category is distinguished from Regression Software though the latter
aiming to construct or analyse one or more mappings between two defined
data sets (for example, a set of “independent” data, *X*, and a set of
“dependent” data, “Y”), whereas Unsupervised Learning Software aims to
construct or analyse one or more mappings between a defined set of input
or independent data, and a second set of “output” data which are not
necessarily known or given prior to the analysis. A key distinction in
Unsupervised Learning Software and Algorithms is between that for which
output data represent (generally numerical) transformations of the input
data set, and that for which output data are discrete labels applied to
the input data. Examples of the former type include dimensionality
reduction and ordination software and algorithms, and examples of the
latter include clustering and discrete partitioning software and
algorithms.

### 1 Input Data Structures and Validation

-   **UL1.0** *Unsupervised Learning Software should explicitly document
    expected format (types or classes) for input data, including
    descriptions of types or classes which are not accepted; for
    example, specification that software accepts only numeric inputs in
    `vector` or `matrix` form, or that all inputs must be in
    `data.frame` form with both column and row names.*
-   **UL1.1** *Unsupervised Learning Software should provide distinct
    sub-routines to assert that all input data is of the expected form,
    and issue informative error messages when incompatible data are
    submitted.*

The following code demonstrates an example of a routine from the base
`stats` package which fails to meet this standard.

``` r
d <- dist (USArrests) # example from help file for 'hclust' function
hc <- hclust (d) # okay
hc <- hclust (as.matrix (d))
```

    ## Error in if (is.na(n) || n > 65536L) stop("size cannot be NA nor exceed 65536"): missing value where TRUE/FALSE needed

The latter fails, yet issues an uninformative error message that clearly
indicates a failure to provide sufficient checks on the class of input
data.

-   **UL1.2** *Unsupervised learning which uses row or column names to
    label output objects should assert that input data have non-default
    row or column names, and issue an informative message when these are
    not provided. (Such messages need not necessarily be provided by
    default, but should at least be optionally available.)*

The following code provides simple examples of checks whether row and
column names appear to have generic default values.

``` r
x <- data.frame (matrix (1:10, ncol = 2))
x
```

    ##   X1 X2
    ## 1  1  6
    ## 2  2  7
    ## 3  3  8
    ## 4  4  9
    ## 5  5 10

Generic row names are almost always simple integer sequences, which the
following condition confirms.

``` r
identical (rownames (x), as.character (seq (nrow (x))))
```

    ## [1] TRUE

Generic column names may come in a variety of formats. The following
code uses a `grep` expression to match any number of characters plus an
optional leading zero followed by a generic sequence of column numbers,
appropriate for matching column names produced by generic construction
of `data.frame` objects.

``` r
all (vapply (seq (ncol (x)), function (i)
             grepl (paste0 ("[[:alpha:]]0?", i), colnames (x) [i]), logical (1)))
```

    ## [1] TRUE

Messages should be issued in both of these cases. The following code
illustrates that the `hclust` function does not implement any such
checks or assertions, rather it silently returns an object with default
labels.

``` r
u <- USArrests
rownames (u) <- seq (nrow (u))
hc <- hclust (dist (u))
head (hc$labels)
```

    ## [1] "1" "2" "3" "4" "5" "6"

-   **UL1.3** *Unsupervised Learning Software should transfer all
    relevant aspects of input data, notably including row and column
    names, and potentially information from other `attributes()`, to
    corresponding aspects of return objects.*
    -   **UL1.3a** *Where otherwise relevant information is not
        transferred, this should be explicitly documented.*

An example of a function according with UL1.3 is
[`stats::cutree()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html)

``` r
hc <- hclust (dist (USArrests))
head (cutree (hc, 10))
```

    ##    Alabama     Alaska    Arizona   Arkansas California   Colorado 
    ##          1          2          3          4          5          4

The row names of `USArrests` are transferred to the output object. In
contrast, some routines from the [`cluster`
package](https://cran.r-project.org/package=cluster) do not comply with
this standard:

``` r
library (cluster)
ac <- agnes (USArrests) # agglomerative nesting
head (cutree (ac, 10))
```

    ## [1] 1 2 3 4 3 4

The case labels are not appropriately carried through to the object
returned by
[`agnes()`](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/agnes.html)
to enable them to be transferred within
[`cutree()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html).
(The labels are transferred to the object returned by `agnes`, just not
in a way that enables `cutree` to inherit them.)

-   **UL1.4** *Unsupervised Learning Software should explicitly document
    whether input data may include missing values.*
-   **UL1.5** *Functions in Unsupervised Learning Software which do not
    admit input data with missing values should provide informative
    error messages when data with missing values are submitted.*
-   **UL1.6** *Unsupervised Learning Software should document any
    assumptions made with regard to input data; for example assumptions
    about distributional forms or locations (such as that data are
    centred or on approximately equivalent distributional scales).
    Implications of violations of these assumptions should be both
    documented and tested, in particular:*
    -   **UL1.6a** *Software which responds qualitatively differently to
        input data which has components on markedly different scales
        should explicitly document such differences, and implications of
        submitting such data.*
    -   **UL1.6b** *Examples or other documentation should not use
        `scale()` or equivalent transformations without explaining why
        scale is applied, and explicitly illustrating and contrasting
        the consequences of not applying such transformations.*

### 2 Pre-processing and Variable Transformation

-   **UL2.0** *Routines likely to give unreliable or irreproducible
    results in response to violations of assumptions regarding input
    data (see UL1.6) should implement pre-processing steps to diagnose
    potential violations, and issue appropriately informative messages,
    and/or include parameters to enable suitable transformations to be
    applied (such as the `center` and `scale.` parameters of the
    [`stats::prcomp()`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html)
    function).*
-   **UL2.1** *Unsupervised Learning Software should document any
    transformations applied to input data, for example conversion of
    label-values to `factor`, and should provide ways to explicitly
    avoid any default transformations (with error or warning conditions
    where appropriate).*
-   **UL2.2** *For Unsupervised Learning Software which accepts missing
    values in input data, functions should implement explicit parameters
    controlling the processing of missing values, ideally distinguishing
    `NA` or `NaN` values from `Inf` values (for example, through use of
    `na.omit()` and related functions from the `stats` package).*
-   **UL2.3** *Unsupervised Learning Software should implement
    pre-processing routines to identify whether aspects of input data
    are perfectly collinear.*

### 3 Algorithms

#### 3.1 Labelling

-   **UL3.1** *Algorithms which apply sequential labels to input data
    (such as clustering or partitioning algorithms) should ensure that
    the sequence follows decreasing group sizes (so labels of “1”, “a”,
    or “A” describe the largest group, “2”, “b”, or “B” the second
    largest, and so on.)*

Note that the [`stats::cutree()`
function](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html)
does not accord with this standard:

``` r
hc <- hclust (dist (USArrests))
table (cutree (hc, k = 10))
```

    ## 
    ##  1  2  3  4  5  6  7  8  9 10 
    ##  3  3  3  6  5 10  2  5  5  8

The [`cutree()`
function](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/cutree.html)
applies arbitrary integer labels to the groups, yet the order of labels
is not related to the order of group sizes.

-   **UL3.2** *Dimensionality reduction or equivalent algorithms which
    label dimensions should ensure that that sequences of labels follows
    decreasing “importance” (for example, eigenvalues or variance
    contributions).*

The
[`stats::prcomp`](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html)
function accords with this standard:

``` r
z <- prcomp (eurodist, rank = 5) # return maximum of 5 components
summary (z)
```

    ## Importance of first k=5 (out of 21) components:
    ##                              PC1       PC2       PC3       PC4       PC5
    ## Standard deviation     2529.6298 2157.3434 1459.4839 551.68183 369.10901
    ## Proportion of Variance    0.4591    0.3339    0.1528   0.02184   0.00977
    ## Cumulative Proportion     0.4591    0.7930    0.9458   0.96764   0.97741

The proportion of variance explained by each component decreasing with
increasing numeric labelling of the components.

-   **UL3.3** *Unsupervised Learning Software for which input data does
    not generally include labels (such as `array`-like data with no row
    names) should provide an additional parameter to enable cases to be
    labelled.*

#### 3.2 Prediction

-   **UL3.4** *Where applicable, Unsupervised Learning Software should
    implement routines to predict the properties (such as numerical
    ordinates, or cluster memberships) of additional new data without
    re-running the entire algorithm.*

While many algorithms such as Hierarchical clustering can not (readily)
be used to predict memberships of new data, other algorithms can
nevertheless be applied to perform this task. The following demonstrates
how the output of
[`stats::hclust`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/hclust.html)
can be used to predict membership of new data using the [`class:knn()`
function](https://stat.ethz.ch/R-manual/R-devel/library/class/html/knn.html).
(This is intended to illustrate only one of many possible approaches.)

``` r
library (class)
set.seed (1)
hc <- hclust (dist (iris [, -5]))
groups <- cutree (hc, k = 3)
# function to randomly select part of a data.frame and # add some randomness
sample_df <- function (x, n = 5) {
    x [sample (nrow (x), size = n), ] + runif (ncol (x) * n)
}
iris_new <- sample_df (iris [, -5], n = 5)
# use knn to predict membership of those new points:
knnClust <- knn (train = iris [, -5], test = iris_new , k = 1, cl = groups)
knnClust
```

    ## [1] 2 2 1 1 2
    ## Levels: 1 2 3

The [`stats::prcomp()`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/prcomp.html)
implements its own `predict()` method which conforms to this standard:

``` r
res <- prcomp (USArrests)
arrests_new <- sample_df (USArrests, n = 5)
predict (res, newdata = arrests_new)
```

    ##                      PC1        PC2        PC3       PC4
    ## North Carolina 165.17494 -30.693263 -11.682811  1.304563
    ## Maryland       129.44401  -4.132644  -2.161693  1.258237
    ## Ohio           -49.51994  12.748248   2.104966 -2.777463
    ## Colorado        35.78896  14.023774  12.869816  1.233391
    ## Georgia         41.28054  -7.203986   3.987152 -7.818416

#### 3.3 Group Distributions and Associated Statistics

Many unsupervised learning algorithms serve to label, categorise, or
partition data. Software which performs any of these tasks will commonly
output some kind of labelling or grouping schemes. The above example of
principal components illustrates that the return object records the
standard deviations associated with each component:

``` r
res <- prcomp (USArrests)
print(res)
```

    ## Standard deviations (1, .., p=4):
    ## [1] 83.732400 14.212402  6.489426  2.482790
    ## 
    ## Rotation (n x k) = (4 x 4):
    ##                 PC1         PC2         PC3         PC4
    ## Murder   0.04170432 -0.04482166  0.07989066 -0.99492173
    ## Assault  0.99522128 -0.05876003 -0.06756974  0.03893830
    ## UrbanPop 0.04633575  0.97685748 -0.20054629 -0.05816914
    ## Rape     0.07515550  0.20071807  0.97408059  0.07232502

``` r
summary (res)
```

    ## Importance of components:
    ##                            PC1      PC2    PC3     PC4
    ## Standard deviation     83.7324 14.21240 6.4894 2.48279
    ## Proportion of Variance  0.9655  0.02782 0.0058 0.00085
    ## Cumulative Proportion   0.9655  0.99335 0.9991 1.00000

Such output accords with the following standard:

-   **UL3.5** *Objects returned from Unsupervised Learning Software
    which labels, categorise, or partitions data into discrete groups
    should include, or provide immediate access to, quantitative
    information on intra-group variances or equivalent, as well as on
    inter-group relationships where applicable.*

The above example of principal components is one where there are no
inter-group relationships, and so that standard is fulfilled by
providing information on intra-group variances alone. Discrete
clustering algorithms, in contrast, yield results for which inter-group
relationships are meaningful, and such relationships can generally be
meaningfully provided. The [`hclust()`
routine](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/hclust.html),
like many clustering routines, simply returns a *scheme* for devising an
arbitrary number of clusters, and so can not meaningfully provide
variances or relationships between such. The [`cutree()`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cutree.html),
however, does yield defined numbers of clusters, yet devoid of any
quantitative information on variances or equivalent.

``` r
res <- hclust (dist (USArrests))
str (cutree (res, k = 5))
```

    ##  Named int [1:50] 1 1 1 2 1 2 3 1 4 2 ...
    ##  - attr(*, "names")= chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...

Compare that with the output of a largely equivalent routine, the
[`clara()`
function](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/clara.html)
from the [`cluster`
package](https://cran.r-project.org/package=cluster).

``` r
library (cluster)
cl <- clara (USArrests, k = 10) # direct clustering into specified number of clusters
cl$clusinfo
```

    ##       size  max_diss   av_diss isolation
    ##  [1,]    4 24.708298 14.284874 1.4837745
    ##  [2,]    6 28.857755 16.759943 1.7329563
    ##  [3,]    6 44.640565 23.718040 0.9677229
    ##  [4,]    6 28.005892 17.382196 0.8442061
    ##  [5,]    6 15.901258  9.363471 1.1037219
    ##  [6,]    7 29.407822 14.817031 0.9080598
    ##  [7,]    4 11.764353  6.781659 0.8165753
    ##  [8,]    3  8.766984  5.768183 0.3547323
    ##  [9,]    3 18.848077 10.101505 0.7176276
    ## [10,]    5 16.477257  8.468541 0.6273603

That object contains information on dissimilarities between each
observation and cluster medoids, which in the context of UL3.4 is
“information on intra-group variances or equivalent”. Moreover,
inter-group information is also available as the
[“silhouette”](https://stat.ethz.ch/R-manual/R-devel/library/cluster/html/silhouette.html)
of the clustering scheme.

### 4 Return Results

-   **UL4.0** *Unsupervised Learning Software should return some form of
    “model” object, generally through using or modifying existing class
    structures for model objects, or creating a new class of model
    objects.*
-   **UL4.1** *Unsupervised Learning Software may enable an ability to
    generate a model object without actually fitting values. This may be
    useful for controlling batch processing of computationally intensive
    fitting algorithms.*
-   **UL4.2** *The return object from Unsupervised Learning Software
    should include, or otherwise enable immediate extraction of, all
    parameters used to control the algorithm used.*

#### 4.1 Reporting Return Results

-   **UL4.2** *Model objects returned by Unsupervised Learning Software
    should implement or appropriately extend a default `print` method
    which provides an on-screen summary of model (input) parameters and
    methods used to generate results. The `print` method may also
    summarise statistical aspects of the output data or results.*
    -   **UL4.2a** *The default `print` method should always ensure only
        a restricted number of rows of any result matrices or equivalent
        are printed to the screen.*

The [`prcomp`
objects](https://stat.ethz.ch/R-manual/R-patched/library/stats/html/prcomp.html)
returned from the function of the same name include potential large
matrices of component coordinates which are by default printed in their
entirety to the screen. This is because the default print behaviour for
most tabular objects in R (`matrix`, `data.frame`, and objects from the
`Matrix` package, for example) is to print objects in their entirety
(limited only by such options as `getOption("max.print")`, which
determines maximal numbers of printed objects, such as lines of
`data.frame` objects). Such default behaviour ought be avoided,
particularly in Unsupervised Learning Software which commonly returns
objects containing large numbers of numeric entries.

-   **UL4.3** *Unsupervised Learning Software should also implement
    `summary` methods for model objects which should summarise the
    primary statistics used in generating the model (such as numbers of
    observations, parameters of methods applied). The `summary` method
    may also provide summary statistics from the resultant model.*

### 5 Documentation

### 6 Visualization

-   **UL6.0** *Objects returned by Unsupervised Learning Software should
    have default `plot` methods, either through explicit implementation,
    extension of methods for existing model objects, through ensuring
    default methods work appropriately, or through explicit reference to
    helper packages such as
    [`factoextra`](https://github.com/kassambara/factoextra) and
    associated functions.*
-   **UL6.1** *Where the default `plot` method is **NOT** a generic
    `plot` method dispatched on the class of return objects (that is,
    through a `plot.<myclass>` function), that method dispatch should
    nevertheless exist in order to explicitly direct users to the
    appropriate function.*
-   **UL6.2** *Where default plot methods include labelling components
    of return objects (such as cluster labels), routines should ensure
    that labels are automatically placed to ensure readability, and/or
    that appropriate diagnostic messages are issued where readability is
    likely to be compromised (for example, through attempting to place
    too many labels).*

### 7 Testing

Unsupervised Learning Software should test the following properties and
behaviours:

-   **UL7.0** *Inappropriate types of input data are rejected with
    expected error messages.*

#### 7.1 Input Scaling

The following tests should be implement for Unsupervised Learning
Software for which inputs are presumed or required to be scaled in any
particular ways (such as having mean values of zero).

-   **UL7.1** *Tests should demonstrate that violations of assumed input
    properties yield unreliable or invalid outputs, and should clarify
    how such unreliability or invalidity is manifest through the
    properties of returned objects.*

#### 7.2 Output Labelling

With regard to labelling of output data, tests for Unsupervised Learning
Software should:

-   **UL7.2** *Demonstrate that labels placed on output data follow
    decreasing group sizes (**UL3.1**)*
-   **UL7.3** *Demonstrate that labels on input data are propagated to,
    or may be recovered from, output data (see **UL3.3**).*

#### 7.3 Prediction

With regard to prediction, tests for Unsupervised Learning Software
should:

-   **UL7.4** *Demonstrate that submission of new data to a previously
    fitted model can generate results more efficiently than initial
    model fitting.*

#### 7.4 Batch Processing

For Unsupervised Learning Software which implements batch processing
routines:

-   **UL7.5** *Batch processing routines should be explicitly tested,
    commonly via extended tests (see **G4.10**–**G4.12**).*
    -   **UL7.5a** *Tests of batch processing routines should
        demonstrate that equivalent results are obtained from direct
        (non-batch) processing.*
