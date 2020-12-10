---
title: regression-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Regression Demonstrations
=========================

This file demonstrates the application of
[rOpenSci](https://ropensci.org) ’s [standards for statistical
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html)
to one [Regression
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#regression-and-supervised-learning)
package. These applications are not intended to represent or reflect
evaluations or assessment of the packages, and particularly not of the
extent to which they fail to meet standards. Rather, the demonstrations
are intended to highlight aspects of the software which could be
productively improved by adhering to the standards, and thereby more
generally to demonstrate the general usefulness of these standards in
advancing and improving software quality.

[lme4](https://github.com/lme4/lme4)
------------------------------------

### 1 [General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)

#### 1.1 Documentation

-   [x] **G1.0** primary reference provided

**Statistical Terminology**

-   [x] **G1.1** Statistical terminology clarified and defined.

**Function-level Documentation**

-   [x] **G1.2** [`roxygen`](https://roxygen2.r-lib.org/) is
    (conditionally and appropriately) used to document all functions.
    -   [ ] **G1.2a** Internal functions generally not appropriately
        documented

**Supplementary Documentation**

-   [x] **G1.3** Code necessary to reproduce performance claims is
    provided.
-   [x] **G1.4** Code necessary to compare performance with alternative
    implementations in other R packages is provided.

#### 1.2 Input Structures

**Uni-variate (Vector) Input**

-   [x] **G2.0** Expected lengths of inputs generally documented and
    asserted.
-   [x] **G2.1** Expected types of inputs generally documented and
    asserted.
-   [x] **G2.2** Parameters expected to be univariate do not accept
    multivariate input
-   [ ] **G2.3** *For univariate character input:*
-   [x] **G2.3a** `match.arg()` is used to only permit expected values.
-   [ ] **G2.3b** `tolower()` is not used, and character parameters are
    case-dependent
-   [x] **G2.4** Mechanisms provided to convert between different data
    types
-   [x] **G2.5** `factor` type inputs appropriate documented and
    processed.

**Tabular Input**

-   [x] **G2.6** Software accepts standard tabular inputs
-   [x] **G2.7** Software appropriately converts inputs to a single
    defined class or type.
-   [ ] **G2.8** Software does not issue diagnostic messages for type
    conversion in which information is lost or added

Main routines assume data to have a “grouping factor”, yet where or not
the relevant column is a `factor` or not, or whether or not it is
ordered, makes no difference. Thus submitting data in which the
“grouping factor” is, for example, a simple integer, lead to that being
interpreted as a `factor`, which is equivalent to the addition of
information describing the factor levels. Conversely, submitting as an
ordered factor makes no difference, thereby effectively removing the
information that the `factor` variable is ordered.

-   [x] **G2.9** Extraction or filtering of single columns from tabular
    is appropriately performed regardless of input class.

**Missing or Undefined Values**

-   [x] **G2.10**–**G2.12** Missing values appropriately handled
    throughout, with ability for user control
-   [ ] **G2.13** No options are provided for handling undefined values,
    rather routines simply error with informative messages.

#### 1.3 Output Structures

-   [x] **G4.0** No local files produced, so not relvant

#### 1.4 Testing

**Test Data Sets**

-   [x] **G5.0** Tests use standard data sets with known properties
-   [x] **G5.1** Data sets created within package are exported

**Responses to Unexpected Input**

-   [ ] **G5.2** The package issues numerous error and warning messages,
    neither the triggering conditions nor values of which are explicitly
    tested.
    -   [x] **G5.2a** Messages produced by `stop()`, `warning()`,
        `message()`are unique.
    -   [ ] **G5.2b** Tests do not trigger every one of those messages
-   [x] **G5.3** Absence of missing values form return results is
    explicitly tested.

**Algorithm Tests**

-   [x] **G5.4** Correctness tests are implemented.
-   [x] **G5.5** Correctness tests are run with a fixed random seed
-   [x] **G5.6** Parameter recovery tests impelemented
    -   [ ] **G5.6a** Many, but not all, parameter recovery tests are
        expected to succeed within a defined tolerance
    -   [ ] **G5.6b** Parameter recovery are generally only run with one
        single random seeds when algorithm contains a random component.
-   [ ] **G5.7** There appear to be no algorithm performance tests
-   [x] **G5.8** Edge condition appropriately tested
-   [ ] **G5.9** There appear to be no noise susceptibility tests,
    neither tests of the effect of adding trivial noise, nor tests
    running under different random seeds.

**Extended tests**

-   [x] **G5.10**–**G5.12** The `lme4` package provides exemplary use of
    exactly such an environmental variable, carefully documented in a
    `tests/README.md` file.

------------------------------------------------------------------------

### 2 [Regression and Supervised Learning Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#regression-and-supervised-learning)

#### 2.1 Input data structures and validation

-   [x] **RE1.0** Models are specified via a formula interface
-   [x] **RE1.1** Documentation is provided for how formula interfaces
    are converted to matrix representations of input data.

The main [package
vignette](https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf)
provides a particularly exemplary demonstration (in Section 2.3) of the
relationship between the package’s formula interface and the underlying
matrix representations.

-   [ ] **RE1.2** Expected input formats are documented, but errors from
    other formats are not informative.

Documentation of the primary function (`lmer`) states that the main
`data` parameter is, “*an optional data frame containing the variables
named in `formula`*”. This function fails with equivalent `matrix` input
with the uninformative error,

``` r
s <- sleepstudy
s$Subject <- as.integer (s$Subject)
s <- as.matrix (s)
m <- lmer(Reaction ~ Days + (Days | Subject), data = s)
```

    ## Error in list2env(data) : first argument must be a named list

The function nevertheless accepts any generic rectangular input,
including `tibble`, and `data.table` formats. Rectification to this
standard would require only (i) updating the documentation to explicate
that the function accepts any objects able to be coerced to `data.frame`
representation; and (ii) ensuring that passing non-compliant `data`
objects generates informative messages.

-   [x] **RE1.3** All relevant aspects of input data are transferred to
    return objects
-   [x] **RE1.4** Assumptions made with regard to input data are clearly
    documented.

#### 2.2 Pre-processing and Variable Transformation

-   [ ] **RE2.0** Not all transformations applied to input data are
    documented

`lme4` implicitly converts all columns of input data specified in a
model formula as grouping factors (through being on the right-side of a
vertical bar, `|`, in the formula) to `factor`, yet this is not
explicitly stated in documentation. Avoiding such conversion would make
no sense here.

-   [x] **RE2.1**–**RE2.2** Appropriate processing of missing values is
    implemented.

`lme4` provides exemplary handling of this case, as illustrated by the
following code:

``` r
set.seed (1)
s <- sleepstudy
s$Reaction [ceiling (runif (1, max = nrow (s)))] <- NA # random NA value in response variable
m <- lmer(Reaction ~ Days + (Days | Subject), data = s)
nobs (m)
```

    ## [1] 179

``` r
length (predict (m))
```

    ## [1] 179

``` r
length (predict (m, s))
```

    ## [1] 180

-   [x] **RE2.3** Centering of data is appropriately diagnosed and
    implemented.
-   [ ] **RE2.4** *Regression Software should implement pre-processing
    routines to identify whether aspects of input data are perfectly
    collinear, notably including:*
-   [ ] **RE2.4a** *Perfect collinearity among predictor variables*
-   [ ] **RE2.4b** *Perfect collinearity between independent and
    dependent variables*

These conditions are neither pre-identified nor appropriately processed,
with the first case returning an empty model, and the second initially
issuing an appropriate message (“dropping 1 column / coefficient”), yet
failing to subsequently fit an appropriate model. The following code
demonstrates:

``` r
s1 <- s2 <- sleepstudy
s1$Reaction <- s1$Days
lmer(Reaction ~ Days + (Days | Subject), data = s1)
```

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: Reaction ~ Days + (Days | Subject)
    ##    Data: s1
    ## REML criterion at convergence: -Inf
    ## Random effects:
    ##  Groups   Name        Std.Dev. Corr
    ##  Subject  (Intercept) 0            
    ##           Days        0         NaN
    ##  Residual             0            
    ## Number of obs: 180, groups:  Subject, 18
    ## Fixed Effects:
    ## (Intercept)         Days  
    ##           0            1  
    ## optimizer (nloptwrap) convergence code: 0 (OK) ; 0 optimizer warnings; 1 lme4 warnings

``` r
s2$Days2 <- 2 * s2$Days
m <- lmer(Reaction ~ Days + Days2 + (Days | Subject) + (Days2 | Subject), data = s2)
```

    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## unable to evaluate scaled gradient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## Model failed to converge: degenerate Hessian with 2 negative eigenvalues

#### 2.3 Algorithms

-   [x] **RE3.0**–**RE3.3** Control over algorithmic convergence in
    `lme4` is exemplarily handled through the `lmerControl()` function
    and associated extensive documentation.

#### 2.4 Return Results

-   [ ] **RE4.0**–**RE4.13** All accessor methods for model data
    provided by the `stats` package, and all model parameters, are also
    implemented for `lmerMod` objects.

**Prediction, Extrapolation, and Forecasting**

-   [ ] **RE4.14** *Where possible, values should also be provided for
    extrapolation or forecast *errors*.*
-   [ ] **RE4.15** *Sufficient documentation and/or testing should be
    provided to demonstrate that forecast errors, confidence intervals,
    or equivalent values increase with forecast horizons.*

The `lme4` package does not explicitly implement forecasting or
extrapolation algorithms, rather it is a generic model fitting package,
the results of which can be used with methods such as `predict()` to
generate forecast values beyond the ranges of input data. There are
nevertheless no explicit methods to use a model to generate confidence
intervals on forecasts in the ways offered by the `stats` package:

``` r
x <- data.frame (x = 1:10,
                 y = runif (10))
m0 <- lm (y ~ x, data = x)
predict (m0, newdata = data.frame (x = 11:16), se.fit = TRUE)
```

    ## $fit
    ##         1         2         3         4         5         6 
    ## 0.3774055 0.3468319 0.3162582 0.2856846 0.2551110 0.2245373 
    ## 
    ## $se.fit
    ##         1         2         3         4         5         6 
    ## 0.2235715 0.2560541 0.2893782 0.3232838 0.3576055 0.3922340 
    ## 
    ## $df
    ## [1] 8
    ## 
    ## $residual.scale
    ## [1] 0.3272751

``` r
predict (m0, newdata = data.frame (x = 11:16), interval = "confidence")
```

    ##         fit        lwr       upr
    ## 1 0.3774055 -0.1381512 0.8929622
    ## 2 0.3468319 -0.2436299 0.9372936
    ## 3 0.3162582 -0.3510492 0.9835656
    ## 4 0.2856846 -0.4598092 1.0311784
    ## 5 0.2551110 -0.5695287 1.0797506
    ## 6 0.2245373 -0.6799558 1.1290305

``` r
predict (m0, newdata = data.frame (x = 11:16), interval = "prediction")
```

    ##         fit        lwr      upr
    ## 1 0.3774055 -0.5365789 1.291390
    ## 2 0.3468319 -0.6114029 1.305067
    ## 3 0.3162582 -0.6911483 1.323665
    ## 4 0.2856846 -0.7751310 1.346500
    ## 5 0.2551110 -0.8627438 1.372966
    ## 6 0.2245373 -0.9534595 1.402534

The three calls to `precict()` illustrate different ways of using the
model to generate estimates of uncertainty involved in using that model
to make forecasts. No such equivalent methods exist for objects of class
`lmerMod`:

``` r
m <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)
predict (m, data.frame (Days = 0:12, Subject = 308))
```

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

``` r
predict (m, data.frame (Days = 0:12, Subject = 308), se.fit = TRUE)
```

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), se.fit =
    ## TRUE): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

``` r
predict (m, data.frame (Days = 0:12, Subject = 308), interval = "confidence")
```

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), interval =
    ## "confidence"): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

``` r
predict (m, data.frame (Days = 0:12, Subject = 308), interval = "prediction")
```

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), interval =
    ## "prediction"): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

Similar comments apply to objects of class `glmerMod` returned by the
`glmer` function:

``` r
gm <- glmer(cbind(incidence, size - incidence) ~ period + (1 |herd),
            data = cbpp,
            family = binomial)
p <- predict (gm, type = "response", se.fit = TRUE)
```

    ## Warning in predict.merMod(gm, type = "response", se.fit = TRUE): unused
    ## arguments ignored

``` r
p <- predict (gm, type = "response", interval = "confidence")
```

    ## Warning in predict.merMod(gm, type = "response", interval = "confidence"):
    ## unused arguments ignored

``` r
p <- predict (gm, type = "response", interval = "prediction")
```

    ## Warning in predict.merMod(gm, type = "response", interval = "prediction"):
    ## unused arguments ignored

``` r
p # numeric values only
```

    ##          1          2          3          4          5          6          7 
    ## 0.30816472 0.14177337 0.12598556 0.08405701 0.15480041 0.06360406 0.05595361 
    ##          8          9         10         11         12         13         14 
    ## 0.27042309 0.12085036 0.10710175 0.07094767 0.20435088 0.08696688 0.07673659 
    ##         15         16         17         18         19         20         21 
    ## 0.05025587 0.16957699 0.07040052 0.06198670 0.04037338 0.14199540 0.05782664 
    ##         22         23         24         25         26         27         28 
    ## 0.05083338 0.03297227 0.37533879 0.18223092 0.16279236 0.11015824 0.31019619 
    ##         29         30         31         32         33         34         35 
    ## 0.16299384 0.06735522 0.05928214 0.03857306 0.12570809 0.05062411 0.04446079 
    ##         36         37         38         39         40         41         42 
    ## 0.02877092 0.18492941 0.07761332 0.06840089 0.04465757 0.18795612 0.07905396 
    ##         43         44         45         46         47         48         49 
    ## 0.06968345 0.04551668 0.11022977 0.04392632 0.03854533 0.02488860 0.39460615 
    ##         50         51         52         53         54         55         56 
    ## 0.19467475 0.17419155 0.11839303 0.12686730 0.05113143 0.04490927 0.02906595

-   [x] **RE4.16** It is possible to submit new groups to `predict()`
    methods.\*

**Reporting Return Results**

-   [x] **RE4.17**–**RE4.18** Default `print` and `summary` methods for
    model objects are implemented.

#### 2.5 Documentation

-   [ ] **RE5.0** `lme4` does not explicitly document scaling of model
    fitting algorithms

#### 2.6 Visualization

-   [x] **RE6.0** Default plot methods provided for model objects
-   [x] **RE6.3** It is not possible to use `lme4` to distinguish
    *extrapolated* from *interpolated* predicted values, and thus no
    visual distinction is possible. See preceding comments regarding
    prediction methods under 4.2.

#### 2.7 Testing

**Input Data**

-   [ ] **RE7.0** *Tests with noiseless, exact relationships between
    predictor (independent) data.*
-   [ ] **RE7.0a** In particular, these tests should confirm ability to
    reject perfectly noiseless input data.
-   [ ] **RE7.1** *Tests with noiseless, exact relationships between
    predictor (independent) and response (dependent) data.*
-   [ ] **RE7.1a** *In particular, these tests should confirm that model
    fitting is at least as fast or (preferably) faster than testing with
    equivalent noisy data (see RE2.4b).*

These tests do not appear to explicitly exist, although the test suite
is quite large, and they could nevertheless be present somewhere.

**Diagnostic Messages**

-   [ ] **RE7.2** Not all error and warning messages are explicitly
    triggered in tests

**Return Results**

-   [x] **RE7.3** Tests demonstrate that output objects retain aspects
    of input data such as row or case names.
-   [x] **RE7.4** Tests demonstrate expected behaviour when return
    objects are submitted to the accessor methods of
    **RE4.2**–**RE4.7**.
-   [ ] **RE7.5** Test do not demonstrate that forecast errors,
    confidence intervals, or equivalent values increase with forecast
    horizons, although that could readily be argued to be inappropriate
    here.
