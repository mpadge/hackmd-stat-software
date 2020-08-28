---
title: Unsupervised Learning Software
tags: statistical-software
robots: noindex, nofollow
---


# Dimensionality Reduction, Clustering, and Unsupervised Learning

This document details standards for Dimensionality Reduction,
Clustering, and Unsupervised Learning Software – referred to from here
on for simplicity as “Unsupervised Learning Software”. Software in this
category is distinguished from Regression Software though the latter
aiming to construct or analyse one or more mappings between two defined
data sets (for example, a set of “independent” data, \(X\), and a set of
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

## 1 Input Data Structures and Validation

  - **UL1.0** Unsupervised Learning Software should explicitly document
    expected format (types or classes) for input data, including
    descriptions of types or classes which are not accepted; for
    example, specification that software accepts only numeric inputs in
    `vector` or `matrix` form, or that all inputs must be in
    `data.frame` form with both column and row names.
  - **UL1.1**\* Unsupervised Learning Software should provide distinct
    sub-routines to assert that all input data is of the expected form,
    and issue informative error messages when incompatible data are
    submitted.

The following code demonstrates an example of a routine which fails to
meet this standard.

``` r
d <- dist (USArrests) # example from help file for 'hclust' function
hc <- hclust (d) # okay
hc <- hclust (as.matrix (d))
```

    ## <simpleError in if (is.na(n) || n > 65536L) stop("size cannot be NA nor exceed 65536"): missing value where TRUE/FALSE needed>

The latter fails, yet issues an informative error message that clearly
indicates a failure to provide sufficient checks on the class of input
data.

  - **UL1.2** Unsupervised learning which uses row or column names to
    label output objects should assert than input data have non-default
    row or column names, and issue an informative message when these are
    not provided.

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

``` r
identical (rownames (x), as.character (seq (nrow (x))))
```

    ## [1] TRUE

``` r
identical (colnames (x), paste0 ("X", seq (ncol (x))))
```

    ## [1] TRUE

Messages should be issued in both of these cases.

  - **UL1.3** Unsupervised Learning Software should explicitly document
    any aspects of input data (such as row names) which are not used in
    model construction.
  - **UL1.4** Unsupervised Learning Software should explicitly document
    whether input data may include missing values.
  - **UL1.5** Functions in Unsupervised Learning Software which do not
    admit input data with missing values should provide informative
    error messages when data with missing values are submitted.
  - **UL1.6** Unsupervised Learning Software should document any
    assumptions made with regard to input data; for example assumptions
    about distributional forms or locations (such as that data are
    centred or on approximately equivalent distributional scales).
    Implications of violations of these assumptions should be both
    documented and tested, in particular:
      - **UL1.6a** Software which responds qualitatively differently to
        input data which has components on markedly different scales
        should explicitly document such differences, and implications of
        submitting such data.

## 2\. Pre-processing and Variable Transformation

  - **UL2.0** Routines likely to give unreliable or irreproducible
    results in response to violations of assumptions regarding input
    data (see UL1.6) should implement pre-processing steps to diagnose
    potential violations, and issue appropriately informative messages,
    and/or include parameters to enable suitable transformations to be
    applied.
  - **UL2.1** Unsupervised Learning Software should document any
    transformations applied to input data, for example conversion of
    label-values to `factor`, and should provide ways to explicitly
    avoid any default transformations (with error or warning conditions
    where appropriate).
  - **UL2.2** For Unsupervised Learning Software which accepts missing
    values in input data, functions should implement explicit parameters
    controlling the processing of missing values, ideally distinguishing
    `NA` or `NaN` values from `Inf` values (for example, through use of
    `na.omit()` and related functions from the `stats` package).
  - **UL2.3** Unsupervised Learning Software should implement
    pre-processing routines to identify whether aspects of input data
    are perfectly collinear.

## 3\. Algorithms

### 3.1 Labelling

  - **UL3.1** Algorithms which apply sequential labels to input data
    (such as clustering or partitioning algorithms) should ensure that
    the sequence follows decreasing group sizes (so labels of “1”, “a”,
    or “A” describe the largest group, “2”, “b”, or “B” the second
    largest, and so on.)

Note that the `stats::cutree` function does not accord with this
standard:

``` r
hc <- hclust (dist (USArrests))
table (cutree (hc, k = 10))
```

    ## 
    ##  1  2  3  4  5  6  7  8  9 10 
    ##  3  3  3  6  5 10  2  5  5  8

Arbitrary integer labels are applied to the groups, yet the order of
labels is not related to the order of group sizes.

  - **UL3.2** Dimensionality reduction or equivalent algorithms which
    label dimensions should ensure that that sequences of labels follows
    decreasing “importance” (for example, variance contribution).

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

### 3.2 Prediction

  - **UL3.3** Where applicable, Unsupervised Learning Software should
    implement routines to predict the properties (such as numerical
    ordinates, or cluster memberships) of additional new data without
    re-running the entire algorithm.

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

    ## [1] 2 1 2 2 3
    ## Levels: 1 2 3

The [`stats::prcomp()`
function](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/prcomp.html)
directly implements its own `predict()` method:

``` r
res<-prcomp (USArrests)
arrests_new <- sample_df (USArrests, n = 5)
predict (res, newdata = arrests_new)
```

    ##                     PC1        PC2       PC3       PC4
    ## Maine         -88.33634 -11.011670 -3.973716  1.442910
    ## Arizona       125.03541   9.468784 -1.713422  3.562192
    ## Hawaii       -122.80461  24.540695  3.844404 -4.029047
    ## North Dakota -127.02315 -15.500848 -0.962151  1.540505
    ## Florida       165.41003   6.600461 -2.008139 -2.152029

## 4\. Return Results

  - **UL4.0** Unsupervised Learning Software should return some form of
    “model” object, generally through using or modifying existing
    class structures for model objects, or creating a new class of model
    objects.
  - **UL4.1** Unsupervised Learning Software may enable an ability to
    generate a model object without actually fitting values. This may be
    useful for controlling batch processing of computationally intensive
    fitting algorithms.
  - **UL4.2** The return object from Unsupervised Learning Software
    should include, or otherwise enable immediate extraction of, all
    parameters used to control the algorithm used.

### 4.1 Reporting Return Results

  - **RE4.2** Model objects returned by Unsupervised Learning Software
    should implement or appropriately extend a default `print` method
    which provides an on-screen summary of model (input) parameters and
    methods used to generate results. The `print` method may also
    summarise statistical aspects of the output data or results.
  - **RE4.3** Unsupervised Learning Software should also implement
    `summary` methods for model objects which should summarise the
    primary statistics used in generating the model (such as numbers of
    observations, parameters of methods applied). The `summary` method
    may also provide summary statistics from the resultant model.

## 5\. Documentation

## 6\. Visualization

  - **UL7.0** Objects returned by Unsupervised Learning Software should
    have default `plot` methods, either through explicit implementation,
    extension of methods for existing model objects, through ensuring
    default methods work appropriately, or through explicit reference to
    helper packages such as
    [`factoextra`](https://github.com/kassambara/factoextra) and
    associated functions.
  - **UL7.1** Where the default `plot` method is **NOT** a generic
    `plot` method dispatched on the class of return objects (that is,
    through a `plot.<myclass>` function), that method dispatch should
    nevertheless exist in order to explicitly direct users to the
    appropriate function.
  - **UL7.2** Where default plot methods include labelling components of
    return objects (such as cluster labels), routines should ensure that
    labels are automatically placed to ensure readability, and/or that
    appropriate diagnostic messages are issued where readability is
    likely to be compromised (for example, through attempting to place
    too many labels).

## 7\. Testing
