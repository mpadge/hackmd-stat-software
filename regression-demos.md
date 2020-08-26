---
title: regression-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


# Regression Demonstrations

## lme4

``` r
library (lme4)
```

    ## Loading required package: Matrix

The following generally note only those standards which the software
does not appear to meet, although explicit notes are also made where
aspects of the software meet or exceed the standards in particularly
exemplary ways.

## 1\. Input data structures and validation

  - *RE1.1 Regression Software should document how formula interfaces
    are converted to matrix representations of input data.*

The main [package
vignette](https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf)
provides a particularly exemplary demonstration (in Section 2.3) of the
relationship between the package’s formula interface and the underlying
matrix representations.

  - *RE1.2 Regression Software should document expected format (types or
    classes) for inputting predictor variables, including descriptions
    of types or classes which are not accepted; for example,
    specification that software accepts only numeric inputs in `vector`
    or `matrix` form, or that all inputs must be in `data.frame` form
    with both column and row names.*

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

## 2\. Pre-processing and Variable Transformation

  - *RE2.0 Regression Software should document any transformations
    applied to input data, for example conversion of label-values to
    `factor`, and should provide ways to explicitly avoid any default
    transformations (with error or warning conditions where
    appropriate).*

`lme4` implicitly converts all columns of input data specified in a
model formula as grouping factors (through being on the right-side of a
vertical bar, `|`, in the formula) to `factor`, yet this is not
explicitly stated in documentation. Avoiding such conversion would make
no sense here.

  - *RE2.2 Regression Software should provide different options for
    processing missing values in *predictor\* and *response* data. For
    example, it should be possible to fit a model with no missing
    predictor data in order to generate values for all associated
    response points, even where submitted response values may be
    missing.\*

`lme4` provides exemplary handling of this case, as illustrated by the
following code:

``` r
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

  - *RE2.4 Regression Software should implement pre-processing routines
    to identify whether aspects of input data are perfectly collinear,
    notably including:*
      - *RE2.4a Perfect collinearity among predictor variables*
      - *RE2.4b Perfect collinearity between independent and dependent
        variables*

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
    ## convergence code 0; 0 optimizer warnings; 1 lme4 warnings

``` r
s2$Days2 <- 2 * s2$Days
m <- lmer(Reaction ~ Days + Days2 + (Days | Subject) + (Days2 | Subject), data = s2)
```

    ## fixed-effect model matrix is rank deficient so dropping 1 column / coefficient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## unable to evaluate scaled gradient

    ## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    ## Model failed to converge: degenerate Hessian with 2 negative eigenvalues

## 3\. Algorithms

Control over algorithmic convergence in `lme4` is exemplarily handled
through the `lmerControl()` function and associated extensive
documentation.

## 4\. Return Results

### 4.1 Accessor Methods

All accessor methods for model data provided by the `stats` package, and
all model parameters, are also implemented for `lmerMod` objects.

### 4.2 Extrapolation and Forecasting

  - *RE4.14 Where Regression Software is intended to, or can, be used to
    extrapolate or forecast values, values should also be provided for
    extrapolation or forecast *errors*.*
  - *RE4.15 Sufficient documentation and/or testing should be provided
    to demonstrate that forecast errors, confidence intervals, or
    equivalent values increase with forecast horizons.*

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
    ## 0.7312507 0.7363363 0.7414218 0.7465073 0.7515928 0.7566784 
    ## 
    ## $se.fit
    ##         1         2         3         4         5         6 
    ## 0.1740457 0.1993327 0.2252748 0.2516696 0.2783883 0.3053458 
    ## 
    ## $df
    ## [1] 8
    ## 
    ## $residual.scale
    ## [1] 0.2547767

``` r
predict (m0, newdata = data.frame (x = 11:16), interval = "confidence")
```

    ##         fit        lwr      upr
    ## 1 0.7312507 0.32990075 1.132601
    ## 2 0.7363363 0.27667429 1.195998
    ## 3 0.7414218 0.22193711 1.260906
    ## 4 0.7465073 0.16615619 1.326858
    ## 5 0.7515928 0.10962835 1.393557
    ## 6 0.7566784 0.05254963 1.460807

``` r
predict (m0, newdata = data.frame (x = 11:16), interval = "prediction")
```

    ##         fit          lwr      upr
    ## 1 0.7312507  0.019733256 1.442768
    ## 2 0.7363363 -0.009629183 1.482302
    ## 3 0.7414218 -0.042822851 1.525666
    ## 4 0.7465073 -0.079315154 1.572330
    ## 5 0.7515928 -0.118633413 1.621819
    ## 6 0.7566784 -0.160367217 1.673724

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

## 5\. Documentation

  - *RE5.0 Scaling relationships between sizes of input data (numbers of
    observations, with potential extension to numbers of
    variables/columns) and speed of algorithm.*

`lme4` does not explicitly document scaling of model fitting algorithms

## 6\. Visualization

  - *RE6.3 Where a model object is used to generate a forecast (for
    example, through a `predict()` method), the default `plot` method
    should provide clear visual distinction between modelled
    (interpolated) and forecast (extrapolated) values.*

It is not possible to use `lme4` to distinguish *extrapolated* from
*interpolated* predicted values, and thus no visual distinction is
possible. See preceding comments regarding prediction methods under 4.2.

## 7\. Testing

  - *RE7.0 Tests with noiseless, exact relationships between predictor
    (independent) data.*
  - *RE7.1 Tests with noiseless, exact relationships between predictor
    (independent) and response (dependent) data.*

These tests do not appear to explicitly exist, although the test suite
is quite large, and they could nevertheless be present somewhere.
