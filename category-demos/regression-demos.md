---
title: regression-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Regression Demonstrations
=========================

lme4
----

The following generally note only those standards which the software
does not appear to meet, although explicit notes are also made where
aspects of the software meet or exceed the standards in particularly
exemplary ways.

### 1 General Standards

-   **G2.3b** *Either: use `tolower()` or equivalent to ensure input of
    character parameters is not case dependent; or explicitly document
    that parameters are strictly case-sensitive.*

Most character parameters for `lme4` are case-dependent.

-   **G2.8** *Software should issue diagnostic messages for type
    conversion in which information is lost (such as conversion of
    variables from factor to character; standardisation of variable
    names; or removal of meta-data) or added (such as insertion of
    variable or column names where none were provided).*

Main routines assume data to have a “grouping factor”, yet where or not
the relevant column is a `factor` or not, or whether or not it is
ordered, makes no difference. Thus submitting data in which the
“grouping factor” is, for example, a simple integer, lead to that being
interpreted as a `factor`, which is equivalent to the addition of
information describing the factor levels. Conversely, submitting as an
ordered factor makes no difference, thereby effectively removing the
information that the `factor` variable is ordered.

-   **G2.13** *All functions should also appropriately handle undefined
    values (e.g., `NaN`, `Inf` and `-Inf`), including potentially
    providing options for ignoring or removing such values.*

No options are provided for handling undefined values, rather routines
simply error with informative messages.

-   **G4.2** Appropriate error and warning behaviour of all functions
    should be explicitly demonstrated through tests.

The package issues numerous error and warning messages, neither the
triggering conditions nor values of which are explicitly tested.

-   **G4.6a** *Parameter recovery tests should generally be expected to
    succeed within a defined tolerance rather than recovering exact
    values.*

Many – but not all – parameter recovery tests expect exact value
matching without specifying tolerance.

-   **G4.6b** *Parameter recovery tests should be run with multiple
    random seeds when either data simulation or the algorithm contains a
    random component*

Parameter recovery tests are generally run once with only a single
random seed.

-   **G4.7** **Algorithm performance tests** *to test that
    implementation performs as expected as properties of data change.
    For instance, a test may show that parameters approach correct
    estimates within tolerance as data size increases, or that
    convergence times decrease for higher convergence thresholds.*

There appear to be no algorithm performance tests.

-   **G4.9** **Noise susceptibility tests** *Packages should test for
    expected stochastic behaviour, such as through the following
    conditions:*
    -   **G4.9a** *Adding trivial noise (for example, at the scale of
        `.Machine$double.eps`) to data does not meaningfully change
        results*
    -   **G4.9b** *Running under different random seeds or initial
        conditions does not meaningfully change results*

There appear to be no noise susceptibility tests, neither tests of the
effect of adding trivial noise, nor tests running under different random
seeds (see G4.6b, above).

-   **G4.10** *Extended tests should included and run under a common
    framework with other tests but be switched on by flags such as as a
    `<MYPKG>_EXTENDED_TESTS=1` environment variable.*

The `lme4` package provides exemplary use of exactly such an
environmental variable, carefully documented in a `tests/README.md`
file.

### 2 Standards for Regression Software

#### 2.1 1. Input data structures and validation

-   *RE1.1 Regression Software should document how formula interfaces
    are converted to matrix representations of input data.*

The main [package
vignette](https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf)
provides a particularly exemplary demonstration (in Section 2.3) of the
relationship between the package’s formula interface and the underlying
matrix representations.

-   *RE1.2 Regression Software should document expected format (types or
    classes) for inputting predictor variables, including descriptions
    of types or classes which are not accepted; for example,
    specification that software accepts only numeric inputs in `vector`
    or `matrix` form, or that all inputs must be in `data.frame` form
    with both column and row names.*

Documentation of the primary function (`lmer`) states that the main
`data` parameter is, “*an optional data frame containing the variables
named in `formula`*”. This function fails with equivalent `matrix` input
with the uninformative error,

    s <- sleepstudy
    s$Subject <- as.integer (s$Subject)
    s <- as.matrix (s)
    m <- lmer(Reaction ~ Days + (Days | Subject), data = s)

    ## Error in list2env(data) : first argument must be a named list

The function nevertheless accepts any generic rectangular input,
including `tibble`, and `data.table` formats. Rectification to this
standard would require only (i) updating the documentation to explicate
that the function accepts any objects able to be coerced to `data.frame`
representation; and (ii) ensuring that passing non-compliant `data`
objects generates informative messages.

#### 2.2 2. Pre-processing and Variable Transformation

-   *RE2.0 Regression Software should document any transformations
    applied to input data, for example conversion of label-values to
    `factor`, and should provide ways to explicitly avoid any default
    transformations (with error or warning conditions where
    appropriate).*

`lme4` implicitly converts all columns of input data specified in a
model formula as grouping factors (through being on the right-side of a
vertical bar, `|`, in the formula) to `factor`, yet this is not
explicitly stated in documentation. Avoiding such conversion would make
no sense here.

-   *RE2.2 Regression Software should provide different options for
    processing missing values in *predictor\* and *response* data. For
    example, it should be possible to fit a model with no missing
    predictor data in order to generate values for all associated
    response points, even where submitted response values may be
    missing.\*

`lme4` provides exemplary handling of this case, as illustrated by the
following code:

    set.seed (1)
    s <- sleepstudy
    s$Reaction [ceiling (runif (1, max = nrow (s)))] <- NA # random NA value in response variable
    m <- lmer(Reaction ~ Days + (Days | Subject), data = s)
    nobs (m)

    ## [1] 179

    length (predict (m))

    ## [1] 179

    length (predict (m, s))

    ## [1] 180

-   *RE2.4 Regression Software should implement pre-processing routines
    to identify whether aspects of input data are perfectly collinear,
    notably including:*
    -   *RE2.4a Perfect collinearity among predictor variables*
    -   *RE2.4b Perfect collinearity between independent and dependent
        variables*

These conditions are neither pre-identified nor appropriately processed,
with the first case returning an empty model, and the second initially
issuing an appropriate message (“dropping 1 column / coefficient”), yet
failing to subsequently fit an appropriate model. The following code
demonstrates:

    s1 <- s2 <- sleepstudy
    s1$Reaction <- s1$Days
    lmer(Reaction ~ Days + (Days | Subject), data = s1)

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
    ## convergence code 0; 0 optimizer warnings; 1 lme4 warnings

    s2$Days2 <- 2 * s2$Days
    m <- lmer(Reaction ~ Days + Days2 + (Days | Subject) + (Days2 | Subject), data = s2)

    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## unable to evaluate scaled gradient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## Model failed to converge: degenerate Hessian with 2 negative eigenvalues

#### 2.3 3. Algorithms

Control over algorithmic convergence in `lme4` is exemplarily handled
through the `lmerControl()` function and associated extensive
documentation.

#### 2.4 4. Return Results

**4.1 Accessor Methods**

All accessor methods for model data provided by the `stats` package, and
all model parameters, are also implemented for `lmerMod` objects.

**4.2 Extrapolation and Forecasting**

-   *RE4.14 Where Regression Software is intended to, or can, be used to
    extrapolate or forecast values, values should also be provided for
    extrapolation or forecast *errors*.*
-   *RE4.15 Sufficient documentation and/or testing should be provided
    to demonstrate that forecast errors, confidence intervals, or
    equivalent values increase with forecast horizons.*

The `lme4` package does not explicitly implement forecasting or
extrapolation algorithms, rather it is a generic model fitting package,
the results of which can be used with methods such as `predict()` to
generate forecast values beyond the ranges of input data. There are
nevertheless no explicit methods to use a model to generate confidence
intervals on forecasts in the ways offered by the `stats` package:

    x <- data.frame (x = 1:10,
                     y = runif (10))
    m0 <- lm (y ~ x, data = x)
    predict (m0, newdata = data.frame (x = 11:16), se.fit = TRUE)

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

    predict (m0, newdata = data.frame (x = 11:16), interval = "confidence")

    ##         fit        lwr       upr
    ## 1 0.3774055 -0.1381512 0.8929622
    ## 2 0.3468319 -0.2436299 0.9372936
    ## 3 0.3162582 -0.3510492 0.9835656
    ## 4 0.2856846 -0.4598092 1.0311784
    ## 5 0.2551110 -0.5695287 1.0797506
    ## 6 0.2245373 -0.6799558 1.1290305

    predict (m0, newdata = data.frame (x = 11:16), interval = "prediction")

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

    m <- lmer(Reaction ~ Days + (Days | Subject), data = sleepstudy)
    predict (m, data.frame (Days = 0:12, Subject = 308))

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

    predict (m, data.frame (Days = 0:12, Subject = 308), se.fit = TRUE)

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), se.fit =
    ## TRUE): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

    predict (m, data.frame (Days = 0:12, Subject = 308), interval = "confidence")

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), interval =
    ## "confidence"): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

    predict (m, data.frame (Days = 0:12, Subject = 308), interval = "prediction")

    ## Warning in predict.merMod(m, data.frame(Days = 0:12, Subject = 308), interval =
    ## "prediction"): unused arguments ignored

    ##        1        2        3        4        5        6        7        8 
    ## 253.6637 273.3299 292.9962 312.6624 332.3287 351.9950 371.6612 391.3275 
    ##        9       10       11       12       13 
    ## 410.9937 430.6600 450.3263 469.9925 489.6588

Similar comments apply to objects of class `glmerMod` returned by the
`glmer` function:

    gm <- glmer(cbind(incidence, size - incidence) ~ period + (1 |herd),
                data = cbpp,
                family = binomial)
    p <- predict (gm, type = "response", se.fit = TRUE)

    ## Warning in predict.merMod(gm, type = "response", se.fit = TRUE): unused
    ## arguments ignored

    p <- predict (gm, type = "response", interval = "confidence")

    ## Warning in predict.merMod(gm, type = "response", interval = "confidence"):
    ## unused arguments ignored

    p <- predict (gm, type = "response", interval = "prediction")

    ## Warning in predict.merMod(gm, type = "response", interval = "prediction"):
    ## unused arguments ignored

    p # numeric values only

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

#### 2.5 5. Documentation

-   *RE5.0 Scaling relationships between sizes of input data (numbers of
    observations, with potential extension to numbers of
    variables/columns) and speed of algorithm.*

`lme4` does not explicitly document scaling of model fitting algorithms

#### 2.6 6. Visualization

-   *RE6.3 Where a model object is used to generate a forecast (for
    example, through a `predict()` method), the default `plot` method
    should provide clear visual distinction between modelled
    (interpolated) and forecast (extrapolated) values.*

It is not possible to use `lme4` to distinguish *extrapolated* from
*interpolated* predicted values, and thus no visual distinction is
possible. See preceding comments regarding prediction methods under 4.2.

#### 2.7 7. Testing

-   *RE7.0 Tests with noiseless, exact relationships between predictor
    (independent) data.*
-   *RE7.1 Tests with noiseless, exact relationships between predictor
    (independent) and response (dependent) data.*

These tests do not appear to explicitly exist, although the test suite
is quite large, and they could nevertheless be present somewhere.
