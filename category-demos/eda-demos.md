---
title: EDA demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---


Exploratory Data Analysis - Demonstration Application of Standards
==================================================================

Prior to considering these demonstrations, it is recommended to peruse a
recent article which appeared in the R Journal entitled, [*The Landscape
of R Packages for Automated Exploratory Data
Analysis*](https://journal.r-project.org/archive/2019/RJ-2019-033/index.html).
A general overview of the packages mentioned in that article is also
provided in this [github repository
(work-in-progres)](https://github.com/m-clark/exploratory-data-analysis-tools).

[`SmartEDA`](https://github.com/daya6489/SmartEDA)
--------------------------------------------------

This package conveniently offers a single “master function”,
`ExpReport`, which generates a stand-alone `html` report containing the
output of most of the package’s functions. The current README of the
[`autotest` package](https://github.com/mpadge/autotest) includes an
example of this package which demonstrates a failure of this package to
appropriate process or reject rectangular input objects which have
list-columns.

### 1 General Standards

Responses to current general standards software with regard to this
package are:

-   [ ] G2.0 No documentation on expected lengths of any input variables
-   [x] G2.1 Types of most inputs clearly documented
-   [ ] G2.2 (Not yet implemented in `autotest`, but will be confirmed
    there.)
-   [ ] G2.3 `match.arg()` not used for single-valued character inputs,
    nor is `tolower()` or equivalent used to avoid sensitivity to case.
-   [x] G2.4 Not applicable
-   [ ] G2.5 No mention of how factors are handled
-   [x] G2.6 All standard input forms accepted
-   [ ] G2.7 (Not yet checked)
-   [x] G2.8 Not applicable
-   [x] G2.9 Different classes of tabular input yield consistent results
-   [x] G2.10 Missing data appropriately handled
-   [x] G2.11 No user control over missing data needed here
-   [x] G2.12 All missing data appropriately pre-processed
-   [x] G2.13 Undefined values appropriately handled, although no
    options provided to remove them, even though such options could be
    useful here.
-   [ ] G3.0 File name specifications (in `ExpReport()` function)
    **not** appropriately parsed, rather simply assumed to be `*.html`.
-   [x] G4.0 Tests use data sets provided by other widely-used R
    packages.
-   [x] G4.1 No data sets created within package, so not applicable
-   [ ] G4.2–4.3 Tests of responses to unexpected input either not
    given, or do not cover all cases.
-   [x] G4.4–4.7 Standards for testing statistical algorithms not
    applicable to EDA software
-   [ ] G4.8 No edge condition tests implemented
-   [ ] G4.9 No tests of noise susceptibility implemented
-   [x] G4.10–4.12 No extended tests needed, so not applicable

### 2 EDA Standards

Responses to current standards for EDA software with regard to this
package are:

-   [x] EA1.0 No target audience explicitly specified, but abilities of
    package sufficiently clearly explained to obviate this.
-   [ ] EA1.1 No target kinds of data explicitly specified, and they
    should be.
-   [ ] EA1.2 No target questions explicitly identified, but purpose of
    package is clearly the exploration of *associative* relationships.
-   [x] EA2.0-2.3 No table filtering or joining performed, so not
    relevant
-   [x] EA2.4-2.5 No multi-tabular input possible, so not relevant
-   [x] EA2.6-2.9 Software performs to these standards, as indicated by
    output of [`autotest`](https://github.com/mpadge/autotest).
-   [ ] EA4.0 `integer` input types not maintained, rather all values
    are converted to `numeric`.
-   [x] EA4.1 Control of numeric precision is explicitly provided
    throughout, with sensible default values.
-   [ ] EA4.2 Default `print` methods apply to all return objects, but
    default `plot` methods either fail (for `ExpData`), or are not
    accessible (for `ExpNumStat`, `ExpCTable`, and others, which rely on
    `plot.default`, and so simply plot a grid of *ncol*-by-*ncol*
    results, often with no labels to enable interpretation).
-   [x] EA5.0-5.1 Explicit graphical output, for example from
    `ExpNumViz` and `ExpCatViz` functions, provides accessible colour
    schemes, as well as allowing overrides of defaults through
    additional parameters.
-   [x] EA5.2 Screen-based output has sensibly printed numeric digits,
    defaulting to 3.
-   [ ] EA5.3 Column-based summary statistics do not indicate the
    `storage.mode`
-   [ ] EA5.4 The default plotted output of `ExpNumViz` includes no
    scale

[`insight`](https://github.com/easystats/insight)
-------------------------------------------------

### 3 General Standards

-   [x] G1.0–1.1 Package makes no performance claims, so not relevant
-   [ ] G2.0 Expected lengths of inputs are generally not documented
-   [ ] G2.1 Expected *data types* of vector inputs not documented (for
    example, the character vectors for `component` arguments of the
    `find_...()` functions).
-   [ ] G2.2 There are no checks or restrictions on parameters expected
    to be univariate.
-   [ ] G2.3 No checks implemented for assumed single-valued character
    input
    -   [ ] G2.3a `match.arg()` is not used
    -   [ ] G2.3b `tolower()` is not used to avoid sensitivity to case
-   [ ] G2.4 Provide appropriate mechanisms to convert between different
    *data types*, potentially including:
    -   [ ] G2.4a There is no explicit conversion to `integer` via
        `as.integer()`
    -   [x] G2.4b There is explicit conversion to continuous via
        `as.numeric()`
    -   [x] G2.4c explicit conversion to character uses `as.character()`
    -   [x] G2.4d explicit conversion to factor uses `as.factor()`
    -   [x] G2.4e explicit conversion from factor uses `as...()`
        functions
-   [x] G2.5 No inputs are expected to be of `factor` type, so not
    applicable
-   [x] G2.6–2.8 No functions accept rectangular input, so not
    applicable
-   [x] G2.9–2.12 No functions accept data able to contain missing
    values, so not applicable
-   [x] G3.0 No functions use local files, so not appicable
-   [x] G4.0 Tests use data sets provided by other widely-used R
    packages.
-   [x] G4.1 No data sets created within package, so not applicable
-   [ ] G4.2 Error and warning behaviour of functions is not explicitly
    tested.
-   [ ] G4.3 Absence of missing or undefined values in return objects is
    not explicitly tested.
-   [x] G4.4–4.7 Standards for testing statistical algorithms not
    applicable to EDA software
-   [x] G4.8 Input to software is models not raw data, so edge
    conditions neither relevant nor applicable.
-   [x] G4.9 Input to software is models not raw data, so noise tests
    neither relevant nor applicable.
-   [x] G4.10–4.12 Extended tests neither relevant nor applicable.

### 4 EDA Standards

-   [x] EA1.0 Target audiences clearly identified
-   [x] EA1.1 The kinds of data the software is capable of analysing
    clearly identified
-   [x] EA1.2 The kinds of questions the software is intended to help
    explore are clearly identified
-   [x] EA1.3 The kinds of data each function is intended to accept as
    input are clearly identified
-   [x] EA2.0–2.9 The software does not accept general inputs, so not
    applicable
-   [x] EA4.0 Generally not applicable, as almost all model parameters
    are `numeric`, although `get_random()` does return `factor` for
    `factor` input, so standard met in that regard.
-   [x] EA4.1 Parameters to enable explicit control of numeric precision
    are not directly implemented, rather the package offers a suite of
    `format_` functions to specify such.
-   [x] EA4.2 Primary routines return objects for which default `print`
    and `plot` methods give sensible results, and also implement
    additional `print_` and `format_` methods.
-   [x] EA5.0–5.1 There are no `plot` or other graphical functions.
-   [ ] EA5.2 Screen-based output follows `getOption("digits")`, and so
    uses default print formatting for `numeric` types, with no user
    control possible.
-   [ ] EA5.3 Column-based summary statistics do not indicate the
    `storage.mode`, `class`, or equivalent defining attribute of each
    column.
-   [x] EA5.4–5.5 There are no visualisations, so not relevant

[`naniar`](https://github.com/njtierney/naniar)
-----------------------------------------------

### 5 General Standards

-   [x] G1.0–1.1 Package makes no performance claims, so not relevant
-   [ ] G2.0 There is no documentation of expectations on lengths of
    inputs
-   [ ] G2.1 Provide explicit secondary documentation of expectations on
    *data types* of all vector inputs (see the above list).
-   [ ] G2.2 Lengths of parameters expected to be univariate are not
    checked, and lead to uninformative errors (for example, `missing`
    parameter of [`add_any_miss()`
    function](http://naniar.njtierney.com/reference/add_any_miss.html)).
-   [x] G2.3 No single-valued character parameters used, so not
    applicable.
-   [x] G2.4 Provide appropriate mechanisms to convert between different
    *data types*, potentially including:
    -   [x] G2.4a explicit conversion to `integer` uses `as.integer()`
    -   [x] G2.4b explicit conversion to continuous uses `as.numeric()`
    -   [x] G2.4c There is no explicit conversion to character, so not
        applicable `paste` or `paste0`)
    -   [x] G2.4d There is no explicit conversion to factor, so not
        applicable
    -   [x] G2.4e There is no explicit conversion from factor, so not
        applicable
-   [x] G2.5 No inputs expected to be of `factor` type, so not
    applicable.
-   [ ] G2.6 `naniar` does not accept `matrix`/`array` input, even
    though it easily could.
-   [ ] G2.7 There is no initial pre-processing to ensure that all other
    sub-functions of a package receive inputs of a single defined type.
-   [ ] G2.8 There is no type conversion, so no diagnostic messages for
    type conversion are issued.
-   [x] G2.9 Checks for missing data are a core part of every routine
-   [x] G2.10 Most functions provide multiple, custom options for
    handling missing
-   [x] G2.11 No functions assume non-missingness
-   [ ] G2.12 No functions appropriately handle undefined values other
    than `NA`. `NaN` is treated exactly as `NA`, and `Inf` is simply
    ignored.
-   [ ] G3.0 There are no outputs written to local files, so not
    applicable
-   [x] G4.0 Tests use data sets provided by other widely-used R
    packages.
-   [x] G4.1 No data sets created within package, so not applicable
    exported so that users can confirm tests and run examples.
-   [ ] G4.2 Error and warning behaviour not tested for all functions
-   [x] G4.3 Absence of missing or undefined values is tested
-   [x] G4.4–4.8 Standards for testing statistical algorithms not
    applicable to EDA software
-   [x] G4.8 Edge conditions tested appropriately
-   [x] G4.9 Test of noise susceptibility not applicable
-   [x] G4.10–4.12 Extended tests neither relevant nor applicable.

### 6 EDA Standards

-   [ ] EA1.0 The software does not identify any target audiences for
    whom it is intended
-   [ ] EA1.1 The software does not explicitly identify the kinds of
    data it is capable of analysing, rather refers to all inputs as
    (variously and either), “data frame” or “data.frame”, even though
    any rectangular inputs are accepted.
-   [x] EA1.2 The software clearly identifies the kinds of questions it
    is intended to help explore
-   [ ] EA1.3 The software does not identify the kinds of data each
    function is intended to accept as input (see EA1.1, above).
-   [x] EA2.0–2.2 Software does not rely on index columns
-   [x] EA2.3 Table join operations are not based on any assumed
    variable or column names, rather are only performed on inputs
    generated internally within the package to have standard format.
-   [x] EA2.4 Package does not use or admit multi-tabular input
-   [x] EA2.6 Routines appropriately process vector input of custom
    classes
-   [x] EA2.7 Routines appropriately process vector data regardless of
    additional attributes
-   [x] EA2.8 Routines appropriately process rectangular input of custom
    classes
-   [x] EA2.9 Routines accept and appropriately process rectangular
    input with columns of custom sub-classes including additional
    attributes.
-   [ ] EA4.0 Software does not ensure all return results have types
    which are consistent with input types, rather returns all results as
    `tibble` objects regardless of class of input.
-   [x] EA4.1 Universal use of `tibble` classes ensures explicit control
    of numeric precision
-   [x] EA4.2 Universal use of `tibble` classes ensures default `print`
    and `plot` methods give sensible results.
-   [x] EA5.0 Graphical presentation is as accessible as possible or
    practicable.
-   [x] EA5.1 Typefaces appear to consider accessibility
-   [x] EA5.2 Screen-based output does not rely on default print
    formatting of `numeric` types, rather relies on `print.tibble`
    throughout.
-   [x] EA5.3 Column-based summary statistics always indicates the
    `storage.mode` via `tibble`.
-   [ ] EA5.4 Visualisations do not include units on all axes, but do
    use `ggplot2` to produce sensibly rounded values.
-   [x] EA5.5 There are no routines for dynamic visualization.
