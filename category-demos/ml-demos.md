---
title: ml-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Machine Learning Demonstrations
===============================

This file demonstrates the application of
[rOpenSci](https://ropensci.org) ’s [standards for statistical
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html)
to one [Machine Learning
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#machine-learning-softwaree)
package. These applications are not intended to represent or reflect
evaluations or assessment of the packages, and particularly not of the
extent to which they fail to meet standards. Rather, the demonstrations
are intended to highlight aspects of the software which could be
productively improved by adhering to the standards, and thereby more
generally to demonstrate the general usefulness of these standards in
advancing and improving software quality.

[`applicable`](https://applicable.tidymodels.org/)
--------------------------------------------------

``` r
library (applicable)
```

------------------------------------------------------------------------

[General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)
----------------------------------------------------------------------------------------------------------------------------------------------

### 1 Documentation

-   [ ] **G1.0** *Statistical Software should list at least one primary
    reference from published academic literature.*

The package lists no primary reference, and only has itself has a
citation.

#### 1.1 Statistical Terminology

-   [x] **G1.1** *All statistical terminology is clarified and
    unambiguously defined.*

#### 1.2 Function-level Documentation

-   [x] **G1.2** *Software should use
    [`roxygen`](https://roxygen2.r-lib.org/) to document all functions.*
    -   [ ] **G1.2a** *All internal (non-exported) functions should also
        be documented in standard
        [`roxygen`](https://roxygen2.r-lib.org/) format.*
-   [x] **G1.3**-**G1.4** Not applicable, as no performance claims are
    made.

Internal functions are not documented at all, merely given commented
titles to separate them.

### 2 Input Structures

#### 2.1 Uni-variate (Vector) Input

-   [ ] **G2.0** *Implement assertions on lengths of inputs,
    particularly through asserting that inputs expected to be single- or
    multi-valued are indeed so.*
-   [ ] **G2.0a** Provide explicit secondary documentation of any
    expectations on lengths of inputs
-   [x] **G2.1** *Implement assertions on types of inputs (see the
    initial point on nomenclature above).*
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

``` r
predictors <- mtcars [, -1]
mod <- apd_pca (predictors, threshold = "0.5")
```

That works silently, which is okay, but then:

``` r
print (mod)
```

    ## [1] "Error in x$threshold * 100 : non-numeric argument to binary operator"

-   [x] **G2.5** No `factor` input expected, so not relevant
-   [x] **G2.6** Standard tabular forms accepted
-   [x] **G2.7** Standard tabular forms converted appropriately
-   [x] **G2.8** Not applicable
-   [x] **G2.9** List-column extraction works consistently

#### 2.2 Missing or Undefined Values

-   [ ] **G2.10** *Statistical Software should implement appropriate
    checks for missing data as part of initial pre-processing prior to
    passing data to analytic algorithms.*

``` r
predictors <- mtcars [, -1]
predictors [1, 1] <- NA
mod <- apd_pca (predictors)
```

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

### 3 Output Structures

-   [x] **G4.0** No writing to local files implemented, so not
    applicable.

### 4 Testing

#### 4.1 Test Data Sets

-   [x] **G5.0** *Where applicable or practicable, tests should use
    standard data sets with known properties (for example, the [NIST
    Standard Reference Datasets](https://www.itl.nist.gov/div898/strd/),
    or data sets provided by other widely-used R packages).*
-   [x] **G5.1** *Data sets created within, and used to test, a package
    should be exported (or otherwise made generally available) so that
    users can confirm tests and run examples.*

These standards are not explicitly fulfilled, but as tests can all be
implemented with relatively small data sets, they may be considered not
relevant.

#### 4.2 Responses to Unexpected Input

-   [ ] **G5.2** Some but not all error and warning behaviour is
    explicitly tested
-   [ ] **G5.3** Absence of missing or undefined data in return objects
    is not explicitly tested.

#### 4.3 Algorithm Tests

-   [x] **G5.4**–**G5.5** Correctness tests are not applicable
-   [ ] **G5.6b** *Parameter recovery tests should be run with multiple
    random seeds when either data simulation or the algorithm contains a
    random component. (When long-running, such tests may be part of an
    extended, rather than regular, test suite; see G4.8-4.10, below).*

Tests are only run with a single random seed

-   [ ] **G5.8** Algorithm performance tests are not implemented.
-   [ ] **G5.8** **Edge condition tests** *to test that these conditions
    produce expected behaviour such as clear warnings or errors when
    confronted with data with extreme properties including but not
    limited to:*
-   [ ] **G5.8a** *Zero-length data*

is not tested

-   [ ] **G5.8b** *Data of unsupported types (e.g., character or complex
    numbers in for functions designed only for numeric data)*

is not tested

-   [ ] **G5.8c** *Data with all-`NA` fields or columns or all identical
    fields or columns*

Processing of missing data is note tested

-   [ ] **G5.8d** *Data outside the scope of the algorithm (for example,
    data with more fields (columns) than observations (rows) for some
    regression algorithms)*

are not tested

-   [ ] **G5.9** **Noise susceptibility tests** *Packages should test
    for expected stochastic behaviour, such as through the following
    conditions:*
-   [ ] **G5.9a** *Adding trivial noise (for example, at the scale of
    `.Machine$double.eps`) to data does not meaningfully change results*

is not tested

-   [ ] **G5.9b** *Running under different random seeds or initial
    conditions does not meaningfully change results*

is not tested

------------------------------------------------------------------------

[Machine Learning Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#machine-learning-software)
--------------------------------------------------------------------------------------------------------------------------------------

### 5 Input Data Specification

-   [ ] **ML1.0** Documentation should make a clear conceptual
    distinction between training and test data (even where such may
    ultimately be confounded as described above.)

Documentation refers frequently to “training data”, yet without any
clear interpretation of this phrase.

-   [x] **ML1.1**–**ML1.** Design decisions distinguishing “training”
    from “test” data clarified and justified
-   [x] **ML1.5** Default `print` methods summarise contents of training
    data sets.

#### 5.1 Missing Values

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

-   [x] **ML1.7**–**ML1.8** Missing values not admitted, so not
    applicable.

### 6 Pre-processing

-   [x] **ML2.0** Pre-processing steps are appropriately defined and
    parametrized.
-   [x] **ML2.1** Broadcasting not used to reconcile dimensionally
    incommensurate input data, so not applicable.
-   [ ] **ML2.2b** Any extended documentation (such as vignettes) which
    demonstrates the use of explicit values for numeric transformations
    should explicitly describe why particular values are used.

The vignette for continuous data utilizes several `recipes` steps for
transforming, “variables to be distributed as Gaussian-like as
possible,” and normalizing, “numeric data to have a mean of zero and
standard deviation of one,” yet no explanation is given for why this is
necessary, nor for why these values are used.

-   [ ] **ML2.3** No data on numeric transformations recorded in return
    objects.
-   [x] **ML2.4** There are no default values defining numeric
    transformations, so not applicable.
-   [x] **ML2.5** Transformations must be explicitly defined, so not
    applicable.
-   [x] **ML2.6** There are no distinct functions for implementing
    transformations, so not applicable.
-   [ ] **ML2.7** Explicit transformations are documented, but not how
    these may be reversed, even though this could be documented.

### 7 Model and Algorithm Specification

-   [x] **ML3.1** Model specification is implemented as a distinct stage
-   [x] **ML3.2** Models can not be specified without directly fitting,
    but nor is this meaningful in the context of this pacakge.
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

-   [x] **ML3.4** No training rates used or implemented, so not
    applicable.

#### 7.1 Control Parameters

-   [x] **ML3.5** No control parameters implemented, so not applicable.
-   [ ] **ML3.6** Unless explicitly justified otherwise (for example
    because ML software under consideration is an implementation of one
    specific algorithm), ML software should:
-   [ ] **ML3.6a** Implement or otherwise permit usage of multiple ways
    of exploring search space
-   [ ] **ML3.6b** Implement or otherwise permit usage of multiple loss
    functions.

There is no ability to use alternative ways of exploring search space,
nor of multiple loss functions (or equivalent).

#### 7.2 CPU and GPU processing

-   [x] **ML3.7** There is no C++ code, so not applicable.

### 8 Model Training

-   [ ] **ML4.0** *ML software should generally implement a unified
    single-function interface to model training, able to receive as
    input a model specified according to all preceding standards.*

The package exports several distinct functions for model training, both
leaving it up to the user to select an appropriate one, and suggesting a
design decision likely to expand functions through adding new functions
for each new mode of training.

-   [x] **ML4.1**–**ML4.2** No optimizer implemented directly, so not
    applicable.

#### 8.1 Batch Processing

-   [x] **ML4.3**–**ML4.6** There is no explicitly ability to implement
    batch processing, so not applicable.

#### 8.2 Re-sampling

-   [x] **ML4.7**–**ML4.8** There are no explicit re-sampling routines,
    so not applicable.

### 9 Model Output and Performance

#### 9.1 Model Output

-   [ ] **ML5.0** No single function defined via **ML4.0**, so a variety
    of return objects are implemented rather than a single, unified
    object.
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

#### 9.2 Model Performance

-   [x] **ML5.3** Model performance is assessed via distinct functions.
-   [ ] **ML5.4** Model performance should be able to be assessed
    according to a variety of metrics.

The `score` function is effectively hard-coded and unable to permit
usage of alternative scoring metrics.

-   [ ] **ML5.4b** It should be possible to submit custom metrics to a
    model assessment function, and the ability to do so should be
    clearly documented including through example code.

It is not possible to submit custom scoring metrics.

### 10 Documentation

-   [x] **ML6.0** Descriptions clearly distinguish training and testing
    stages and associated data sets.
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

### 11 Testing

#### 11.1 Input Data

-   [x] **ML7.0** Input data need not be labelled, so not applicable.
-   [ ] **ML7.1** Tests should demonstrate effects of different numeric
    scaling of input data (see **ML2.2**).

No such tests implemented.

-   [x] **ML7.2** Missing data are not imputed, so not applicable.

#### 11.2 Model Classes

-   [ ] **ML7.3a** These tests should explicitly identify restrictions
    on the functionality of model objects in comparison with those of
    other packages.

No tests implemented to demonstrate restrictions on classes of objects
generated by this package.

-   [ ] **ML7.3b** These tests should explicitly identify functional
    advantages and unique abilities of the model objects in comparison
    with those of other packages.

No such tests are present.

#### 11.3 Model Training

-   [x] **ML7.4**–**ML7.5** Training rates not explicitly considered, so
    not applicable.
-   [x] **ML7.6** Training epochs not explicitly considered, so not
    applicable.
-   [ ] **ML7.7** ML software should explicitly test different
    optimization algorithms, even where software is intended to
    implement one specific algorithm.

Different algorithms not tested, and they could be.

-   [ ] **ML7.8** ML software should explicitly test different loss
    functions, even where software is intended to implement one specific
    measure of loss.

Different loss functions not tested, and they could be.

-   [ ] **ML7.9** Tests should explicitly compare all possible
    combinations in categorical differences in model architecture, such
    as different model architectures with same optimization algorithms,
    same model architectures with different optimization algorithms, and
    differences in both.

Not implemented

-   [x] **ML7.10** There is no information on paths taken by optimizers,
    so this can not be tested and is not applicable.

#### 11.4 Model Performance

-   [ ] **ML7.11** All performance metrics available for a given class
    of trained model should be thoroughly tested and compared.

Performance metrics are neither tested nor compared, and they could
readily be.
