---
title: unsupervised-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Unsupervised Learning Demonstrations
====================================

This file demonstrates the application of
[rOpenSci](https://ropensci.org) ’s [standards for statistical
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html)
to one [Unsupervised Learning
software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#dimensionality-reduction-clustering-and-unsupervised-learning)
package. These applications are not intended to represent or reflect
evaluations or assessment of the packages, and particularly not of the
extent to which they fail to meet standards. Rather, the demonstrations
are intended to highlight aspects of the software which could be
productively improved by adhering to the standards, and thereby more
generally to demonstrate the general usefulness of these standards in
advancing and improving software quality.

[`mbkmeans`](https://github.com/drisso/mbkmeans)
------------------------------------------------

### 1 General Standards

-   [ ] **G1.0–1.1** Clear performance claims are made in the associated
    publication, yet the software includes no code able to reproduce
    these results, nor to compare with alternative implementations.
-   [ ] **G2.0** There is no documentation of any expectations on
    lengths of inputs.
-   [ ] **G2.1** There is no secondary documentation of expectations on
    *data types* of vector inputs
-   [x] G2.2 Multivariate input to parameters expected to be univariate
    is generally appropriately prohibited
-   [ ] G2.3 For univariate character input:
    -   [ ] G2.3a `match.arg()` is not used, and would yield more
        sensible errors
    -   [ ] G2.3b `tolower()` or equivalent is not used, and would yield
        more sensible errors
-   [ ] G2.4 Provide appropriate mechanisms to convert between different
    data types, potentially including:
    -   [ ] G2.4a There is no explicit conversion to `integer` via
        `as.integer()`, and should be (for example for `clusters`, which
        is ultimately *implicitly* converted by being passed as an
        assumed [C++
        `<int>`](https://github.com/drisso/mbkmeans/blob/master/src/mini_batch.cpp#L394)).
    -   [ ] G2.4b Nor is there any explicit conversion via
        `as.numeric()`
    -   [ ] G2.4c Nor is there any explicit conversion via
        `as.character()` (for example for `reduceMethod`).
    -   [x] G2.4d–e Conversion to/from factor not used, so not
        applicable
-   [x] G2.5 No inputs expected to be of `factor` type, so not
    applicable
-   [x] G2.6 Only input of specified classes permitted, with
    [appropriate class checks
    impelemented](https://github.com/drisso/mbkmeans/blob/master/R/kmeans.R#L169-L170).
-   [ ] G2.7 Software does not provide appropriate routines to convert
    main input to standard form. For example, all input matrices are
    [transposed](https://github.com/drisso/mbkmeans/blob/master/R/kmeans.R#L174)
    without pre-processing checks for row-column orientation.
-   [ ] G2.8 Input objects generally include a large amount of
    meta-data, most of which is lost. In this context, such silent
    discarding nevertheless seems appropriate.
-   [x] G2.9 Primary inputs derive from `matrix`, and so do not use list
    columns, therefore not applicable.
-   [ ] G2.10 Checks for missing data are not implemented as
    pre-processing steps, rather data is passed to main routines (the
    C++ `mini_batch` routine), where uninformative errors are generated.
-   [ ] G2.11 No options are provided for users to specify how to handle
    missing data.
-   [ ] G2.12 Functions assume non-missingness, and generate unhelpful
    error messages when missing data are submitted.
-   [ ] G2.13 There are neither options, nor pre-processing checks, for
    undefined values, rather data is again passed to C++ routines,
    resulting in uninformative error messages.
-   [x] G3.0 The package itself relies on external packages to produce
    local files, so not applicable
-   [x] G4.0 Tests use standard data sets with known properties (notably
    `iris`).
-   [x] G4.1 No data sets created within, and used to test, package, so
    not applicable.
-   [ ] G4.2 Tests do not exist for appropriate error and warning
    behaviour of all functions
-   [ ] G4.3 The absence of missing or undefined values in return
    objects is not explicitly tested.
-   [ ] G4.4 **Correctness tests** appropriately implemented
    -   [ ] G4.4a No tests again alternative implementations, yet such
        tests could be plausibly included.
    -   [x] G4.4b Tests against previous implementations not applicable.
    -   [x] G4.4c Use of stored values from published paper outputs not
        applicable
-   [x] G4.5 Correctness tests are run with a fixed random seed
-   [x] G4.6 **Parameter recovery tests** appropriately impelemented.
    -   [x] G4.6a Parameter recovery tests use defined tolerance.
    -   [ ] G4.6b Parameter recovery tests are not run with multiple
        random seeds
-   [ ] G4.7 There are no algorithm performance tests (and I am not sure
    these would be relevant here?)
-   [ ] G4.8 There are no edge condition tests, and there should be
    -   [ ] G4.8a No tests for zero-length data
    -   [ ] G4.8b No tests for data of unsupported types
    -   [ ] G4.8c No tests for data with all-`NA` fields or columns or
        all identical fields or columns
    -   [ ] G4.8d No tests for data outside the scope of the algorithm
-   [ ] G4.9 There are no noise susceptibility tests
    -   [ ] G4.9a There are no tests that adding trivial noise does not
        meaningfully change results, and there should be.
    -   [ ] G4.9b There are no tests that running under different random
        seeds or initial conditions does not meaningfully change
        results, and there should be
-   [x] G4.10–4.12 There are no extended tests, so not applicable.

### 2 Unsupervised Learning Standards

-   [ ] UL1.0 Although there is explicit documentation of expected
    format for input data, there are no descriptions of types or classes
    which are not accepted, nor sufficiently clarity (for example, in
    the function examples) on exactly what is accepted.
-   [x] UL1.1 Sub-routines assert that all input data is of the expected
    form, with informative error messages issued when incompatible data
    are submitted.
-   [x] UL1.2–3 Input inherits from `matrix` only, so row or column
    names not used, and these standards not applicable.
-   [ ] UL1.4 There is no explicit documentation on whether input data
    may include missing values.
-   [ ] UL1.5 Functions do not provide informative error messages when
    data with missing values are submitted.
-   [ ] UL1.6 There is no documentation of assumptions made with regard
    to input data, and there likely should be (for `mini_batch`, for
    example).
    -   [ ] UL1.6a Software responds qualitatively differently to input
        data which has components on markedly different scales, yet this
        is not documented (for `mini_batch`, for example).
    -   [ ] UL1.6b There are no illustrations or contrasts of the
        consequences of submitted scaled versus unscaled data.
-   [ ] UL2.0 Routines are likely to give unreliable or irreproducible
    results in response to violations of assumptions regarding input
    data, yet there are no pre-processing checks for such.
-   [ ] UL2.1 Transformations are applied to input data without
    documentation or ways of avoiding (notably transposing the input to
    `mbkmeans()`).
-   [x] UL2.2 Missing values not accepted in input data, so not
    applicable.
-   [ ] UL2.3 There are no pre-processing routines to identify whether
    aspects of input data are perfectly collinear.
-   [x] UL3.1 No labels applied to input data, so not applicable.
-   [x] UL3.2 There is no labelling of dimensions or groups, so not
    applicable.
-   [ ] UL3.3 Input data does not generally include labels, yet there is
    no additional parameter to enable cases to be labelled, and there
    should be.
-   [x] UL3.4 Prediction of the properties of additional new data
    neither possible nor applicable to this software.
-   [ ] UL3.5 There is no quantitative information on intra-group
    variances or equivalent, yet this could be provided.
-   [ ] UL4.0 Return values are not “model” objects, rather simple lists
    not immediately able to be submitted to any further functions.
-   [x] UL4.1 Ability to generate a model object without actually
    fitting values arguably not applicable here.
-   [ ] UL4.2 Return objects neither include, nor enable immediate
    extraction of, parameters used to control the algorithm used.
-   [ ] UL4.2 There is no default `print` method for objects returned
    from main functions.
    -   [ ] UL4.2a In the absence of the above, the default `print`
        method fails to ensure only a restricted number of rows of any
        result matrices or equivalent are printed to the screen.
-   [x] UL4.3 The default `summary.list` methods for return objects are
    arguably sufficient here (although a non-default method would enable
    more informative `summary` data to be generated).
-   [ ] UL6.0–6.2 There are no default `plot` methods.

### 3 Summary

| Standards | Total Number | Pass | Not Applicable | Fail |
|-----------|--------------|------|----------------|------|
| General   | 28           | 5    | 7              | 16   |
| UL        | 24           | 2    | 6              | 16   |

### 4 [`autotest`](https://github.com/mpadge/autotest) output

Current `autotest` only produces output where issues arises. This is a
relatively very clean response, none of which ought be considered
particularly important, except perhaps for the notes about missing
documentation on permitted parameter ranges.

-   Parameter `clusters` responds to integer values in \[1, 110\]
-   Warning: ✖ Parameter range for clusters is NOT documented
-   Parameter `batch_size` responds to integer values in \[1, 110\]
-   Warning: ✖ Parameter range for batch\_size is NOT documented
-   Parameter `max_iters` permits unrestricted integer inputs
-   Parameter `initializer` of function `mini_batch` is assumed to a
    single character, but is case dependent
-   Parameter `compute_labels` of function `mini_batch` is assumed to be
    logical, but responds to general integer values.
-   Parameter `calc_wcss` of function `mini_batch` is assumed to be
    logical, but responds to general integer values.
-   Parameter `early_stop_iter` responds to integer values in \[1, 28\]
-   Warning: ✖ Parameter range for `early_stop_iter` is NOT documented
-   Parameter verbose of function `mini_batch` is assumed to be logical,
    but responds to general integer values.
