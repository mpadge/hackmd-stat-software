---
title: Bayesian-demos
tags: statistical-software-demos, statistical-software
robots: noindex, nofollow
---

# Bayesian and Monte Carlo Software - Demonstration Application of Standards

## [`fmcmc`](https://github.com/USCbiostats/fmcmc)


### General Standards

- [ ] G1.0 No code included to reproduce results which
  form the basis of performance claims made in associated publications.
- [ ] G1.1 No code included to compare performance claims with alternative
  implementations in other R packages.
- [x] G2.0 Explicit secondary documentation of expected lengths of inputs
  generally provided.
- [x] G2.1 Explicit documentation of expected *data types* of vector inputs
  generally provided.
- [ ] G2.2 Submission of multivariate input to parameters expected to be
  univariate is possible, and not caught in pre-processing
- [x] G2.3 No functions have single-valued character inputs, so not applicable.
- [ ] G2.3 Provide appropriate mechanisms to convert between different *data
  types*, potentially including:
    - [ ] G2.3a There is no explicit conversion to `integer` via `as.integer()`
    - [x] G2.3b explicit conversion to continuous uses `as.numeric()`
    - [x] G2.3c explicit conversion to character uses `as.character()`
    - [x] G2.3d--e No `factor` data used, so not applicable
- [x] G2.5 No `factor` data used, so not applicable
- [x] G2.6--2.9 Pre-processing of rectangular input expected to be explicitly
  controlled through user specification of a log-likelihood function, so not
  applicable.
- [ ] G2.10 There are no checks for missing data
- [ ] G2.11 There are no options for users to specify how to handle missing
  (`NA`) data
- [ ] G2.12 Functions assume non-missingness, without explicitly stating such
- [ ] G2.13 There is no processing of other (non-`NA`) undefined values.
- [ ] G3.0 Nothing is written to local files, so not applicable
- [ ] G4.0 No standard data sets used in tests (rather, all tests use random
  data simulated with fixed random seeds)
- [x] G4.1 Data sets are created within software, but not in a way that is
  appropriate for export, so not applicable.
- [ ] G4.2 Tests do not cover all error and warning conditions
- [ ] G4.3 Absence of missing or undefined values in return objects not
  explicitly tested.
- [x] G4.4 Correctness tests appropriately implemented.
- [x] G4.5 Correctness tests are run with a fixed random seed
- [x] G4.6 Parameter recovery tests appropriately implemented.
- [x] G4.7 Algorithm performance tests appropriately implemented.
- [x] G4.8 Edge condition tests appropriately implemented.
- [ ] G4.9 No noise susceptibility tests implemented.
- [ ] G4.10 No extended tests included, so not applicable

### Bayesian Standards

- [ ] BS1.0 Uses the term "parameter" to refer to "hyperparameters", although
  does so entirely consistently
- [x] BS1.1 Extensive descriptions of how to enter data, primarily via
  vignettes.
- [ ] BS1.2 Descriptions of how to specify prior distributions provided
    - [ ] BS1.2a Not in `README`
    - [x] BS1.2b In vignette
    - [ ] BS1.2c Not in Function-level documentation
- [x] BS1.3 All parameters which control the computational process extensively
  described.
    - [x] BS1.3a Documents how to use the output of previous simulations as
      starting points of subsequent simulations.
    - [x] BS1.3b Does not document how to use different sampling algorithms
      because only implements one.
- [x] BS1.4 Explicitly describes and provides examples of convergence checkers.
- [x] BS1.5 Differences between convergence checkers are explicitly tested.
- [x] BS2.0 Vector inputs are appropriately pre-processed regardless of class
  structures.
- [ ] BS2.1 Some pre-processing routines are implemented for alternative
  columns
    - [x] BS2.1a Re-classed columns are processed via `as.data.frame`
    - [ ] BS2.1b List columns fail
- [ ] BS2.2 No *pre-checks* are implemented to ensure input data are
  commensurate, rather unhelpful errors are issued instead.
- [ ] BS2.3 Hyperparameters are neither validated nor pre-processed prior to
  submitting to analytic routines, with errors passed through to multiple
  parallel computational chains (`burnin`, for example, is only used *after*
  chains have been calculated, to determine which parts of result are to be
  discarded).
- [ ] BS2.4 Lengths of hyperparameter vectors are not explicitly checked,
  rather passed through to attempted matrix multiplication, and then issuing
  unhelpful error message ("Error in coeffs * x. : non-conformable arrays").
- [x] BS2.5 Passing to "coeffs * x." described above ensures that lengths of
  hyperparameter vectors are commensurate with expected model input
- [ ] BS2.6 There are no pre-processing checks to validate
  appropriateness of numeric values submitted for hyperparameters; for example,
  hyperparameters defining second-order moments and given negative values are
  passed through, and lead to unhelpful errors ("Error in if (R[i] < klogratio)
  { : missing value where TRUE/FALSE needed").
- [ ] BS2.7 There are no checks that values for parameters are positive (see
  BS2.3 above; negative `burnin` values still lead to chains being calculated).
- [ ] BS2.8 There are no check on lengths of inputs, for example, passing a
  length = 2 vector to `burnin` generates warnings on various conditional
  checks expecting single values.
- [ ] BS2.9 There are no checks that arguments are of expected classes or
  types, rather passing unexpected classes or types generally fails at some
  stage with uninformative error messages.
- [ ] BS2.10 Parameters of inappropriate type are not automatically rejected,
  rather usually fail as described above (BS2.9).
- [ ] BS2.11 Seeds are not able to be passed as a parameter, rather random
  generation is determined by the system `seed` value.
- [x] BS2.12 Results of previous runs can be used as starting points 
- [x] BS2.13 Each chain is started with a different seed by default
- [ ] BS2.14 Seeds can not be passed, so no diagnostic messages can be issued
  when identical seeds are passed to distinct computational chains
- [ ] BS2.15 There is no advice *not* to use `set.seed()`, rather it is the
  suggested way to control random generation.
- [x] BS2.16 The relevant parameter is called "initial", which require no
  pluralization.
- [ ] BS2.17 There is no parameter controlling the verbosity of output, rather
  just a single `progress` parameter to switch the progress bar on and off,
  while convergence checkers have no verbosity control at all.
- [x] BS2.18 It is possible to suppress progress indicators while retaining
  verbosity of warnings and errors, through the `progress` parameter described
  above (BS2.17).
- [ ] BS2.19 It is not possible to suppress warnings, and many uninformative
  warnings may be triggered as described above.
- [ ] BS2.20 There is no explicit way to catch errors
- [ ] BS3.0 No missing values are permitted, and no checks are performed,
  rather missing values are passed through unchecked, leading to unhelpful
  error messages.
- [ ] BS3.1 There are no routines to pre-process missing values prior to
  passing data through to main computational algorithms.
- [ ] BS3.2 There are no pre-processing routines to diagnose perfect
  collinearity, and there are no diagnostic messages or warnings
- [ ] BS3.3 There are no distinct routines for processing perfectly collinear
  data.
- [x] BS4.0 Sampling algorithms are documented, including literary citation
- [ ] BS4.1 There are no comparisons with external samplers
- [ ] BS4.2 There are no methods to validate posterior estimates (other than
  convergence checkers used during simulation chains).
- [x] BS4.3 Several different kinds of convergence checkers are implemented and documented.
- [x] BS4.4 Computations are able to be stopped on convergence
- [x] BS4.5 Appropriate mechanisms are provided for models which do not
  converge, by stopping after specified numbers of iterations regardless of
  convergence.
- [ ] BS4.6 There are no tests to confirm that results with convergence checker
  are statistically equivalent to results from equivalent fixed number of
  samples without convergence checking.
- [ ] BS4.7 Effects of parameters of convergence checkers are not tested.
- [ ] BS5.0 Return objects do not include information on seed(s) or starting
  value(s)
- [ ] BS5.1 Return objects do not include metadata on types (or classes) and
  dimensions of input data
- [ ] BS5.2 Software returns neither their input function of distributional
  parameters, nor enables subsequent access to such.
- [ ] BS5.3 Return object does not include convergence statistics 
- [ ] BS5.4 Return object does not include details of convergence checker used 
- [ ] BS5.5 Return object does not include diagnostic statistics to indicate
  absence of convergence
- [ ] BS6.0 Return object does not Implement a default `print` method
- [x] BS6.1 Return object does Implement a default `plot` method
- [ ] BS6.2 Software provides and documents abilities to plot sequences of
  posterior samples, although burn-in periods are simply excluded from plots.
- [x] BS6.3 There are straightforward abilities to plot posterior
  distributional estimates
- [x] BS6.4 Provide `summary` methods for return objects are provided
- [x] BS6.5 It is possible to plot both sequences of posterior samples and
  distributional estimates together in single graphic

---

## [`rstan`](https://github.com/stan-dev/rstan)


### General Standards

- [x] G1.0 Code is provided to reproduce results which form the basis of
  performance claims made in associated publications (for example, for
  `sbc()`).
- [x] G1.1 Code is provided to compare performance claims with alternative
  implementations in other R packages (for example, for `sbc()`).
- [ ] G2.0 There is no explicit documentation of expected lengths of inputs
- [ ] G2.1 There is no explicit documentation of expected *data types* of
  vector inputs
- [ ] G2.2 There is no explicit prohibition or restriction on submission of
  multivariate input to parameters expected to be univariate.
- [ ] G2.3 Some control of single-valued character input provides
    - [x] G2.3a `match.arg` is used
    - [ ] `tolower` is not used, nor is their explicit mention of strict case
      sensitivity
- [x] G2.4 Provide appropriate mechanisms to convert between different *data
  types*, potentially including:
    - [x] G2.4a explicit conversion to `integer` via `as.integer()`
    - [x] G2.4b explicit conversion to continuous via `as.numeric()`
    - [x] G2.4c explicit conversion to character via `as.character()` (and not
      `paste` or `paste0`)
    - [x] G2.4d--e There is no explicit `factor` input, so not applicable
- [x] G2.5 There is no explicit `factor` input, so not applicable
- [x] G2.6 Restrictions on tabular input very carefully documented
- [x] G2.7 There are conversion routines for multivariate input, for reasons
  explained in documentation.
- [x] G2.8 There is no type conversion in which information is lost, so not
  applicable.
- [x] G2.9 Restrictions on tabular input very carefully documented.
- [x] G2.10--2.13 Missing data is explicitly prohibited, as extensively
  documented, and all appropriate checks are also implemented.
- [x] G3.1 Processing of names of local files explicitly documented
- [x] G4.0 Tests use standard data sets
- [x] G4.1 Data sets created to test package are not exported, but are made
  generally available through direct inclusion within package sub-directory.
- [ ] G4.2 Tests do not cover all error and warning conditions
- [ ] G4.3 Absence of missing or undefined values in return objects not
  explicitly tested.
- [x] G4.3 Correctness tests appropriately implemented.
- [x] G4.5 Correctness tests are run with a fixed random seed
- [x] G4.6 Parameter recovery tests appropriately implemented.
- [x] G4.7 Algorithm performance tests appropriately implemented.
- [x] G4.8 Edge condition tests appropriately implemented.
- [ ] G4.9 No noise susceptibility tests implemented
- [x] G4.10 Extended tests appropriately implemented (notably for underlying C++ code).
- [x] G4.11 Extended tests require no large data sets, so not applicable
- [ ] G4.12 Conditions necessary to run extended tests not appropriately documented

### Bayesian Standards


- [ ] BS1.0 There terms "parameter" and "hyperparameter" are used
  interchangeably and ambiguously in much documentation (for example, in
  [*Prior Choice
  Recommendations*](https://github.com/stan-dev/stan/wiki/Prior-Choice-Recommendations)).
- [x] BS1.1 There is extensive description of how to enter data
- [x] BS1.2 There is extensive Description of how to specify prior distributions
    - [ ] BS1.2a Not in the main package `README`, although that seems okay
      here, as the stan project is too big for that to serve a simple
      demonstration purpose.
    - [x] BS1.2b In at least one package vignette
    - [x] BS1.2c In function-level documentation, preferably with code included in examples
- [x] BS1.3 All parameters which control the computational process are extensively described
    - [x] BS1.3a There is sufficient documentation of how to use the output of
      previous simulations as starting points of subsequent simulations.
    - [x] BS1.3b There is sufficient documentation of how to use different
      sampling algorithms.
- [x] BS1.4 `rstan` does not directly implement convergence checkers, rather
  provides convergence statistics throughout, and exports several
  well-documented helper functions to aid subsequent analyses of such.
- [x] BS1.5 The documentation for the [`optimizing()`
  function](https://mc-stan.org/rstan/reference/stanmodel-method-optimizing.html)
  describes several ways of controlling convergence to point estimates.
- [ ] BS2.0 one-dimensional input is not appropriately pre-processed, with
  submission of `units` vectors erroring ("both operands of the expression
  should be 'units' objects").
- [x] BS2.1 `rstan` does not convert all plausible forms of two-dimension input
  to standard forms, but does document very explicitly the expected forms for
  such, and strongly discourages submitting non-standard formats or classes.
    - [x] BS2.1a `data.frame` or equivalent objects which have columns with
      non-standard class attributes are simply coerced to numeric, as clearly
      documented.
    - [x] BS2.1b Submitting list columns is explicitly and strongly discouraged
      in the
      [documentation](https://mc-stan.org/rstan/reference/stan.html#passing-data-to-stan),
      although possible as described there.
- [x] BS2.2 Pre-processing routines ensure all input data is dimensionally
  commensurate
- [x] BS2.3 Validation and pre-processing of hyperparameters is expected to be
  part of user-provide model specifications, as clearly documented.
- [x] BS2.4--6 Hyperparameter vectors are not submitted to `rstan` like most
  other Bayesian software, and so these standards do not apply.
- [ ] BS2.7 There are some checks that values for parameters are positive where
  expected, but these are only implemented within each chain, not as single
  pre-processing step.
- [x] BS2.8 Lengths of inputs are checked and error appropriately
- [x] BS2.9 Arguments of unexpected classes or types are appropriately pre-converted
- [ ] BS2.10 Parameters of inappropriate type are not automatically rejected;
  rather are submitted to sub-routines, triggering unhelpful errors.
- [x] BS2.11 Seeds can be passed as a parameter 
- [x] BS2.12 Results of previous runs can be used as starting points for
  subsequent runs
- [x] BS2.13 Each chain is always started with a different seed by default
- [x] BS2.14 It is not possible to pass identical seeds to distinct
  computational chains, so standard not applicable
- [x] BS2.15 Advice *not* to use `set.seed()` is explicitly documented (and has
  no effect).
- [x] BS2.16 The parameter controlling starting values is called `init`, so
  appropriately not pluralised.
- [x] BS2.17 There are multiple ways of controlling the verbosity of output
- [x] BS2.18 It is possible to suppress messages and progress indicators, while
  retaining verbosity of warnings and errors.
- [x] BS2.19 It is possible to suppress warnings 
- [ ] BS2.20 No errors are able to be either caught or converted to warnings
- [x] BS3.0 Documentation and error message explicitly state that no missing
  values are permitted
- [x] BS3.1 No missing values are permitted, no pre-processing standards not
  applicable
- [ ] BS3.2 There are no pre-processing routines to diagnose perfect
  collinearity, no are diagnostic messages or warnings issued
- [ ] BS3.3 There are no distinct routines for processing perfectly collinear
  data, rather all data are passed directly to sampling algorithms
- [x] BS4.0 Sampling algorithms are explicitly documented and referenced.
- [ ] BS4.1 There are no explicit comparisons with external samplers
- [x] BS4.2 A method to validate posterior estimates is implemented (via the
  [`sbc()` function](https://mc-stan.org/rstan/reference/sbc.html)).
- [x] BS4.3 No convergence checker as such implemented, but extensive
  convergence statistics are provided, documented, and able to be extracted.
- [x] BS4.4 Computations are able to be stopped on convergence (via appropriate
  post-processing functions such as
  [`optimizing()`](https://mc-stan.org/rstan/reference/stanmodel-method-optimizing.html)).
- [x] BS4.5 Appropriate mechanisms are provided for models which do not
  converge.
- [ ] BS4.6 Convergence statistics are not explicitly tested within the R
  package (even though the more general `stan` code is checked very
  comprehensively).
- [ ] BS4.7 Effects of parameters passed to convergence checkers are not
  tested.
- [x] BS5.0 Return objects include both seeds and starting values (able to be
  extracted via `get_seed()` and `get_inits()` functions).
- [ ] BS5.1 Return objects DO NOT include appropriate metadata on types or
  dimensions of input data
- [x] BS5.2 `rstan` enables direct access to prior specification through the
  `get_stancode()` and `get_stanmod()` functions.
- [x] BS5.3 Convergence statistics or equivalent are returned or able to be extracted.
- [x] BS5.4 Where multiple checkers are enabled, return details of convergence
  checker used 
- [x] BS5.5 Appropriate diagnostic statistics are returned (or able to be accessed) to indicate absence of convergence
- [x] BS6.0 Default `print` method for return objects is implemented
- [x] BS6.1 Default `plot` method for return objects is implemented
- [x] BS6.2 Sequences of posterior samples are able to be plotted, although
  burn-in periods are omitted from plot
- [x] BS6.3 Posterior distributional estimates able to be directed plotted
- [x] BS6.4 `summary` methods are provided for return objects
- [ ] BS6.5 It is not possible to plot both sequences of posterior samples and
  distributional estimates together in single graphic

<!--

## [`mgcv`](https://cran.r-project.org/web/packages/mgcv/index.html)

## [`rjags`](https://cran.r-project.org/web/packages/rjags/index.html)
-->


