---
title: Unsupervised Learning Software
tags: statistical-software
robots: noindex, nofollow
---


# Dimensionality Reduction, Clustering, and Unsupervised Learning

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
    about distributional forms or locations (such as normal or
    zero-mean, respectively). Implications of violations of these
    assumptions should be both documented and tested.

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
