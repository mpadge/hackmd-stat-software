---
title: General Standards
tags: statistical-software
robots: noindex, nofollow
---


# General standards arising from specific categories

These standards refer to **Data Types** as the fundamental types defined by the
R language itself between the following:

- Continuous (numeric)
- Integer
- String / character
- Date/Time
- Factor
- Ordered Factor


## 1. Documentation

The following standards describe several forms of what might be considered
"Supplementary Material". While there are many places within an R package where
such material may be included, common locations include vignettes, or in
additional directories (such as `data-raw`) listed in `.Rbuildignore` to
prevent inclusion within installed packages.

Where software supports a publication, all claims made in the publication with
regard to software performance (for example, claims of algorithmic scaling or
efficiency; or claims of accuracy), the following standard applies:

- G1.0 Software should include all code necessary to reproduce results which
  form the basis of performance claims made in associated publications.

Where claims regarding aspects of software performance are made with respect to
other extant R packages, the following standard applies:

- G1.1 Software should include code necessary to compare performance claims
  with alternative implementations in other R packages.



## 2. Input Structures

This section considers general standards for *Input Structures*. These
standards may often effectively be addressed through implementing class
structures, although this is not a general requirement. Developers are
nevertheless encouraged to examine the guide to [S3
vectors](https://vctrs.r-lib.org/articles/s3-vector.html#casting-and-coercion)
in the [`vctrs` package](https://vctrs.r-lib.org) as an example of the kind of
assurances and validation checks that are possible with regard to input data.
Systems like those demonstrated in that vignette provide a very effective way
to ensure that software remains robust to diverse and unexpected classes and
types of input data.

### 2.1 Uni-variate (Vector) Input

It is important to note for univariate data that single values in R are vectors
with a length of one, and that `1` is of exactly the same *data type* as `1:n`.
Given this, inputs expected to be univariate should:

- G2.0 Provide explicit secondary documentation of any expectations on lengths
  of inputs (generally implying identifying whether an input is expected to be
  single- or multi-valued)
- G2.1 Provide explicit secondary documentation of expectations on *data types*
  of all vector inputs (see the above list).
- G2.2 Appropriately prohibit or restrict submission of multivariate input to
  parameters expected to be univariate.
- G2.3 Provide appropriate mechanisms to convert between different *data
  types*, potentially including:
    - G2.3a explicit conversion to `integer` via `as.integer()`
    - G2.3b explicit conversion to continuous via `as.numeric()`
    - G2.3c explicit conversion to character via `as.character()` (and not
      `paste` or `paste0`)
    - G2.3d explicit conversion to factor via `as.factor()`
    - G2.3e explicit conversion from factor via `as...()` functions
- G2.4 Where inputs are expected to be of `factor` type, secondary
  documentation should explicitly state whether these should be `ordered` or
  not, and those inputs should provide appropriate error or other routines to
  ensure inputs follow these expectations.


### 2.2 Multivariate Input

This sub-section refers to "standard rectangular forms" for input data. The
fundamental rectangular form in R is an `array`, which is just a vector with
additional attributes specifying rectangular dimensions. A `matrix` was
technically a special form of `array` which allowed additional attributes such
as dimension (row and column) names, but since R4.0.0 the two have become
largely equivalent such that an `array` constructor creates an object of class
`c("matrix", "array")`, and `inherits(m, "array")` is true for a `matrix` `m`.
Both terms may accordingly be considered entirely equivalent.

Given this, multivariate inputs may be in one or or more of the following forms:

- `matrix`
- `data.frame`
- Extensions such as
    - [`tibble`](https://tibble.tidyverse.org)
    - [`data.table`](https://rdatatable.gitlab.io/data.table)
    - domain-specific classes such as
      [`tsibble`](https://tsibble.tidyverts.org) for time series

General Standards applicable to software which is intended to accept any one or
more of these rectangular inputs are then that:

- G2.5 Software should accept as input as many of the above standard forms as
  possible, including extension to domain-specific forms
- G2.6 Software should provide appropriate conversion routines as part of initial
  pre-processing to ensure that all other sub-functions of a package receive
  inputs of a single defined type.
- G2.7 Software should issue diagnostic messages for type conversion in which
  information is lost (such as conversion of variables from factor to
  character; or standardisation of variable names) or added (such as insertion
  of variable or column names where none were provided).

### 2.3 Missing or Undefined Values

- G2.8 Statistical Software should implement appropriate checks for missing
  data as part of initial pre-processing prior to passing data to analytic
  algorithms.
- G2.9 Where possible, all functions should provide options for users to
  specify how to handle missing (`NA`) data, with options minimally including:
  - G2.9a error on missing data
  - G2.9b ignore missing data with default warnings or messages issued
  - G2.9c replace missing data with appropriately imputed values
- G2.10 Functions should never assume non-missingness, and should never pass
  data with potential missing values to any base routines with default `na.rm =
  FALSE`-type parameters (such as
  [`mean()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/mean.html),
  [`sd()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/sd.html) or
  [`cor()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html)).
- G2.11 All functions should also appropriately handle undefined values 
  (e.g., `NaN`, `Inf` and `-Inf`), including potentially providing options for
  ignoring or removing such values.

## 3. Output Structures

- G3.1 Statistical Software which enables outputs to be written to local files
  should parse parameters specifying file names to ensure appropriate file
  suffices are automatically generated where not provided.

## 4. Testing 

All packages should follow rOpenSci standards on [testing](https://devguide.ropensci.org/building.html#testing) and [continuous integration](https://devguide.ropensci.org/ci.html), including aiming for high test coverage.  For testing _statistical algorithms_, tests should include tests of the following types:


   -  **Correctness tests** to test that statistical algorithms produce expected output (predictions, fitted values) given test data sets.
       -  For new methods, it can be difficult to separate out correctness of the the method from the correctness of the implementation, as there may not be reference for comparison.  In this case, options include testing against simple, trivial cases or testing multiple implementations (e.g., an initial R implementation then ported to C/C++.)
        - For new implementations of existing methods, correctness tests should include tests against previous implementations.  Such testing may explicitly call those implementations in testing, preferably from fixed-versions of other software, or use stored outputs from those where it is not possible.
            - Stored values may even be drawn from published paper outputs when applicable and code from the original implementation is not available
            - Note binding frameworks such as [RStata](https://github.com/lbraglia/RStata) may help here.)
        - Where applicable, using standard data sets with known properties, (e.g., [NIST Standard Reference Datasets](https://www.itl.nist.gov/div898/strd/) is encouraged.
        - Correctness tests should be run with a fixed random seed

   - **Parameter recovery tests** to test that the implementation produce expected results given data with known properties.  For instance, a linear regression algorithm should return expected coefficient values for a simulated data set generated from a linear model.  In general parameter recovery tests should be expected to succeed within a tolerance rather than exact values.
       - Parameter recovery tests should be run with multiple random seeds when either data simulation or the algorithm contains a random component


   - **Algorithm performance tests** test that implementation performs as expected as properties of data change.  For instance, a test may show that parameters approach correct estimates within tolerance and data size increases.

   -  **Edge condition tests** to test that these conditions produce expected behavior such as clear warnings or errors when confronted with data with extreme properties 
       -  Zero-length data, 
       -  Data of unsupported types (e.g., character or complex numbers in for functions designed only for numeric data)
       -  Data with all-NA fields or all identical fields
       -  Data outside the scope of the algorithm (e.g., data with more fields (columns) than observations (rows) for some regression)

   - Packages should test for expected stochastic behavior, e.g., 
       - Adding trivial (e.g. `.Machine$double.eps`-scale) noise to data does not meaningfully change results
       - Running under differennt random seeds / initital conditions does not meaningfully change results

   - Data sets used in testing should be made available to the user in the package. 



- Export data sets used for testing in the package for user confirmation and examples
   -  

### 4.1 Extended tests

Tests on large data, tests with many permutations and other conditions are often ill-suited to workflows of unit tests run continuously with every code change.  In these cases authors may wish to provided extended tests.

Extended tests should run under a common framework of with other tests but be switched on by flags such as as a `MYPKG_EXTENDED_TESTS=1` environment variable.  Where extended tests require large data sets or other assets, these should be provided for downloaded and fetched as part of the testing workflow.

Conditions for running extended tests such as platform requirements, memory, expected runtime, and artifacts produced that may need manual inspection, should be described in developer documentation such as a `CONTRIBUTING.md` file. 
