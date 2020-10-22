---
title: ml-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Machine Learning Demonstrations
===============================

[`applicable`](https://applicable.tidymodels.org/)
--------------------------------------------------

    library (applicable)

------------------------------------------------------------------------

[General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)
----------------------------------------------------------------------------------------------------------------------------------------------

### 1 Documentation

-   [ ] **G1.0** *Statistical Software should list at least one primary
    reference from published academic literature.*

The package lists no primary reference, and only has itself has a
citation.

#### 1.1 Function-level Documentation

-   [ ] **G1.2a** *All internal (non-exported) functions should also be
    documented in standard [`roxygen`](https://roxygen2.r-lib.org/)
    format.*

Internal functions are not documented at all, merely given commented
titles to separate them.

### 2 Input Structures

#### 2.1 Uni-variate (Vector) Input

-   [ ] **G2.2** *Appropriately prohibit or restrict submission of
    multivariate input to parameters expected to be univariate.*

Length controls not implemented (for example,
`add_pca (..., threshold = rep (1, 2))` passes silently).

-   [ ] **G2.3** *For univariate character input:*
    -   [ ] **G2.3b** *Either: use `tolower()` or equivalent to ensure
        input of character parameters is not case dependent; or
        explicitly document that parameters are strictly
        case-sensitive.*

Parameters like `type` in `score.apd_hat_values` are matched but are
case sensitive. That’s probably okay here since “numeric” is the only
acceptable value anyway.

-   [ ] **G2.4** *Provide appropriate mechanisms to convert between
    different data types, potentially including:*

Explicit conversion is not implemented. The following is possible:

    predictors <- mtcars [, -1]
    mod <- apd_pca (predictors, threshold = "0.5")

That works silently, which is okay, but then:

    print (mod)

    ## [1] "Error in x$threshold * 100 : non-numeric argument to binary operator"

#### 2.2 Missing or Undefined Values

-   [ ] **G2.10** *Statistical Software should implement appropriate
    checks for missing data as part of initial pre-processing prior to
    passing data to analytic algorithms.*

<!-- -->

    predictors <- mtcars [, -1]
    predictors [1, 1] <- NA
    mod <- apd_pca (predictors)

    ## <simpleError in svd(x, nu = 0, nv = k): infinite or missing values in 'x'>

-   [ ] **G2.11** *Where possible, all functions should provide options
    for users to specify how to handle missing (`NA`) data, with options
    minimally including:*

Functions neither document whether or not missing data may be submitted,
nor do they implement any pre-processing checks. Missing data is passed
on to further routines, triggering unhelpful error messages.

-   [ ] **G2.12** *Functions should never assume non-missingness, and
    should never pass data with potential missing values to any base
    routines with default `na.rm = FALSE`-type parameters (such as
    [`mean()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/mean.html),
    [`sd()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/sd.html)
    or
    [`cor()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.html)).*

Functions assume non-missingness, and pass missing values through to
base routines such as `svd()`.

-   [ ] **G2.13** *All functions should also provide options to handle
    undefined values (e.g., `NaN`, `Inf` and `-Inf`), including
    potentially ignoring or removing such values.*

No such options provided.

### 3 Testing

-   [ ] **G4.4b** *Parameter recovery tests should be run with multiple
    random seeds when either data simulation or the algorithm contains a
    random component. (When long-running, such tests may be part of an
    extended, rather than regular, test suite; see G4.8-4.10, below).*

Tests are only run with a single random seed

-   [ ] **G4.6** **Edge condition tests** *to test that these conditions
    produce expected behaviour such as clear warnings or errors when
    confronted with data with extreme properties including but not
    limited to:*
-   [ ] **G4.6a** *Zero-length data* is not tested
-   [ ] **G4.6b** *Data of unsupported types (e.g., character or complex
    numbers in for functions designed only for numeric data)* is not
    tested
-   [ ] **G4.6c** *Data with all-`NA` fields or columns or all identical
    fields or columns* Processing of missing data is note tested
-   [ ] **G4.6d** *Data outside the scope of the algorithm (for example,
    data with more fields (columns) than observations (rows) for some
    regression algorithms)* are not tested
-   [ ] **G4.7** **Noise susceptibility tests** *Packages should test
    for expected stochastic behaviour, such as through the following
    conditions:*
-   [ ] **G4.7a** *Adding trivial noise (for example, at the scale of
    `.Machine$double.eps`) to data does not meaningfully change results*
    is not tested
-   [ ] **G4.7b** *Running under different random seeds or initial
    conditions does not meaningfully change results* is not tested

------------------------------------------------------------------------

[Machine Learning Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#machine-learning-software)
--------------------------------------------------------------------------------------------------------------------------------------

### 4 Input Data Specification

-   [ ] **ML1.0** Documentation should make a clear conceptual
    distinction between training and test data (even where such may
    ultimately be confounded as described above.)

Documentation refers frequently to “training data”, yet without any
clear interpretation of this phrase.

#### 4.1 Missing Values

-   [ ] **ML1.6** ML software which does not admit missing values, and
    which expects no missing values, should implement explicit
    pre-processing routines to identify whether data has any missing
    values, and should generally error appropriately and informatively
    when passed data with missing values. In addition, ML software which
    does not admit missing values should:

No such processing is implemented

-   [ ] **ML1.6a** Explain why missing values are not admitted.

No explanation is given of whether or not missing values are admitted.

-   [ ] **ML1.6b** Provide explicit examples (in function documentation,
    vignettes, or both) for how missing values may be imputed, rather
    than simply discarded.

No such examples are provided.

### 5 Pre-processing

-   [ ] **ML2.2b** Any extended documentation (such as vignettes) which
    demonstrates the use of explicit values for numeric transformations
    should explicitly describe why particular values are used.

The vignette for continuous data utilizes several `recipes` steps for
transforming, “variables to be distributed as Gaussian-like as
possible,” and normalizing, “numeric data to have a mean of zero and
standard deviation of one,” yet no explanation is given for why this is
necessary, nor for why these values are used.

### 6 Model and Algorithm Specification

-   [ ] **ML3.3** Where ML software implements its own distinct classes
    of model objects, the properties and behaviours of those specific
    classes of objects should be explicitly compared with objects
    produced by other ML software. In particular, where possible, ML
    software should provide extended documentation (as vignettes or
    equivalent) comparing model objects with those from other ML
    software, noting both unique abilities and restrictions of any
    implemented classes.

No comparisons are made with equivalent methods from other software,
even though this could readily be done.

### 7 Model Output and Performance

#### 7.1 Model Output

-   [ ] **ML5.1** … the properties and behaviours of trained models
    produced by ML software should be explicitly compared with
    equivalent objects produced by other ML software.

No such comparison is made.

-   [ ] **ML5.2** The structure and functionality of objects
    representing trained ML models should be thoroughly documented. In
    particular,
-   [ ] **ML5.2a** Either all functionality extending from the class of
    model object should be explicitly documented, or a method for
    listing or otherwise accessing all associated functionality
    explicitly documented and demonstrated in example code.

No such documentation is provided.

-   [ ] **ML5.2b** Documentation should include examples of how to save
    and re-load trained model objects for their re-use in accordance
    with **ML3.1**, above.

Such documentation is not provided, even though it could be.

#### 7.2 Model Performance

-   [ ] **ML5.4** Model performance should be able to be assessed
    according to a variety of metrics.

The `score` function is effectively hard-coded and unable to permit
usage of alternative scoring metrics.

-   [ ] **ML5.4b** It should be possible to submit custom metrics to a
    model assessment function, and the ability to do so should be
    clearly documented including through example code.

It is not possible to submit custom scoring metrics.

### 8 Documentation

-   [ ] **ML6.1** ML software intentionally designed to address only a
    restricted subset of the workflow described here should clearly
    document how it can be embedded within a typical *full* ML workflow
    in the sense considered here.

No demonstration is provided for how the workflow enabled by this
package can be embedded within a more complete ML workflow, even though
such documentation could readily be provided.

-   [ ] **ML6.1** Such demonstrations should include and contrast
    embedding within a full workflow using at least two other packages
    to implement that workflow.

Also not done.

### 9 Testing

#### 9.1 Input Data

-   [ ] **ML7.1** Tests should demonstrate effects of different numeric
    scaling of input data (see **ML2.2**).

No such tests implemented.

#### 9.2 Model Classes

-   [ ] **ML7.3a** These tests should explicitly identify restrictions
    on the functionality of model objects in comparison with those of
    other packages.

No tests implemented to demonstrate restrictions on classes of objects
generated by this package.

-   [ ] **ML7.3b** These tests should explicitly identify functional
    advantages and unique abilities of the model objects in comparison
    with those of other packages.

No such tests are present.