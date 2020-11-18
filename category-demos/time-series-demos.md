---
title: time-series-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Time Series Demonstrations
==========================

[nse](https://github.com/keblu/nse)
-----------------------------------

### 1 [General Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#general-standards-for-statistical-software)

#### 1.1 Documentation

-   [x] **G1.0** Software lists primary reference from published
    academic literature.

**Statistical Terminology**

-   [x] **G1.1** Statistical terminology is clarified and defined.

**Function-level Documentation**

-   [x] **G1.2** Uses [`roxygen`](https://roxygen2.r-lib.org/) to
    document all functions.
-   [ ] **G1.2a** Internal functions are generally not documented in any
    form.

**Supplementary Documentation**

-   [x] **G1.3**–**G1.4** No performance claims made so not applicable

#### 1.2 Input Structures

**Uni-variate (Vector) Input**

-   [ ] **G2.0** There are no assertions on lengths of inputs
-   [ ] **G2.0a** There is no documentation of expectations on lengths
    of inputs
-   [ ] **G2.1** There are no assertions on types of inputs
-   [x] **G2.1a** Expectations on data types of vector inputs are
    documented
-   [ ] **G2.2** There are no explicit restrictions to prevent
    submission of multivariate input to parameters expected to be
    univariate.
-   [x] **G2.3** For univariate character input:
-   [x] **G2.3a** `match.arg()` or equivalent used for character input
-   [ ] **G2.3b** `tolower()` or equivalent not used, so character input
    is case-sensitive
-   [x] **G2.4** Appropriate mechanisms generally provided to convert
    between different data types
-   [x] **G2.5** No inputs expected to be of `factor` type, so not
    applicable.

**Tabular Input**

-   [x] **G2.6**–**G2.9** Tabular input not admitted, so not relevant

**Missing or Undefined Values**

-   [ ] **G2.10** There are no checks for missing data, with all data
    passed through to analytic algorithms.
-   [ ] **G2.11** There are no options for users to specify how to
    handle missing data.
-   [ ] **G2.12** All functions assume non-missingness
-   [ ] **G2.13** Functions do not provide options to handle undefined
    values

#### 1.3 Output Structures

-   [x] **G3.0** Software does not enable outputs to local files, so not
    applicable.

#### 1.4 Testing

**Test Data Sets**

-   [ ] **G4.0** Tests do not use standard data sets with known
    properties, although in this case arguably should.
-   [x] **G4.1** Data sets created within tests are not exported, but
    are sufficiently simple that this standard is not applicable.

**Responses to Unexpected Input**

-   [ ] **G4.2** There are no tests of error or warning behaviour
-   [ ] **G4.3** Absence of missing (`NA`) or undefined (`NaN`, `Inf`)
    values in return objects is not tested.

**Algorithm Tests**

-   [ ] **G4.4** There are no correctness tests, although there could
    and should be.
-   [ ] **G4.4a**–**G4.4b** There are no tests against alternative or
    prior implementations, although there could and should be.
-   [x] **G4.4c** Use of stored values from published paper outputs not
    applicable here.
-   [x] **G4.5** Tests are be run with a fixed random seed
-   [ ] **G4.6** Parameter recovery tests are not implemented.
-   [ ] **G4.7** Algorithm performance tests are not implemented.
-   [ ] **G4.8** Edge condition tests are not implemented.
-   [ ] **G4.9** Noise susceptibility tests are not implemented.

**Extended tests**

-   [x] **G4.10**–**G4.12** There are no extended tests, so not
    applicable.

------------------------------------------------------------------------

### 2 [Time Series Standards](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#time-series-software)

#### 2.1 Input data structures and validation

-   [ ] **TS1.0** Explicit classes for time-series data not used
-   [x] **TS1.1** Types and classes of input data are explicitly
    documented.
-   [ ] **TS1.2** Software does not accept input data in as many time
    series specific classes as possible, yet could readily do so.
-   [x] **TS1.3** Validation routines implemented to confirm that inputs
    are of acceptable classes
-   [x] **TS1.4** Single pre-processing routine is used to validate
    input data
-   [x] **TS1.5**–**TS1.7** Time- or date-based components or attributes
    of input data not used, so not applicable.

**Time Intervals and Relative Time**

-   [ ] **TS1.8** Software does not accept inputs defined via the
    [`units` package](https://github.com/r-quantities/units/) because it
    does not use explicit classes for time-series data.
-   [ ] **TS1.9** Time intervals or periods not accepted, because the
    software does not use explicit classes for time-series data.

#### 2.2 Pre-processing and Variable Transformation

**Missing Data**

-   [ ] **TS2.0** There are no checks for missing data
-   [ ] **TS2.1** Software presumes regular data, yet is unable to
    affirm this, nor enable interpretation of missing values.
-   [ ] **TS2.2** Functions do not provide options to specify how to
    handle missing data
-   [ ] **TS2.3** Functions assume non-missingness, and pass data with
    potential missing values to base routines with default
    `na.rm = FALSE`-type parameters.

**Stationarity**

-   [ ] **TS2.4**–**TS2.6** There are implicit assumptions on
    stationarity, yet these are not documented, diagnosed, or used to
    generate warnings or diagnostic messages.

**Covariance Matrices**

-   [x] **TS2.7**–**TS2.8** Considerations of covariance matrices not
    applicable to this software.

#### 2.3 Analytic Algorithms

**Forecasting**

-   [x] **TS3.0**–**TS3.3** Forecasting neither relevant nor appliable
    here.

#### 2.4 Return Results

-   [ ] **TS4.0** Return values do not use a class system.
-   [x] **TS4.1** Input data have no units, so not applicable to return
    values.
-   [ ] **TS4.2** Type and classes of return values not explicitly
    documented.
-   [ ] **TS4.3** Return values do not include appropriate units and/or
    time scales

**Data Transformation**

-   [ ] **TS4.4**–**TS4.5** Data transformations are not implemented, so
    not applicable.

**Forecasting**

-   [ ] **TS4.6**–**TS4.6** No forecasting abilities implemented, so not
    applicable.

#### 2.5 Visualization

-   [x] **TS5.0**–**TS5.8** Software uses no class systems, so
    visualizations not possible and these standards not applicable.

[`survPen`](https://github.com/fauvernierma/survPen)
----------------------------------------------------

[`memochange`](https://github.com/KaiWenger/memochange)
-------------------------------------------------------

[`dtwsat`](https://github.com/vwmaus/dtwSat)
--------------------------------------------

[`bigtime`](https://github.com/ineswilms/bigtime)
-------------------------------------------------

[`bootUR`](https://github.com/smeekes/bootUR)
---------------------------------------------
