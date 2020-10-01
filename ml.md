---
title: Machine Learning Software
tags: statistical-software
robots: noindex, nofollow
---


<!-- Edit the .Rmd not the .md file -->

Machine Learning
----------------

For an overview of Machine Learning (ML) Software in R, see the [CRAN
Task View](https://cran.r-project.org/web/views/MachineLearning.html).
ML software commonly relies on or implements some of the following
procedures for which it useful to provide brief definitions at the
outset.

-   ***Broadcasting***, which is, “repeating the dimensions of one
    object to match the dimensions of another.”

That definition comes from a vignette for the [`rray`
package](https://github.com/r-lib/rray) named
[*Broadcasting*](https://rray.r-lib.org/articles/broadcasting.html).
This concept runs counter to aspects of standards in other categories,
which often suggest that functions should error when passed input
objects which do not have commensurate dimensions. Broadcasting is a
pre-processing step which enables objects with incommensurate dimensions
to be dimensionally reconciled.

<details>
<summary>
Click for a demonstration of broadcasting
</summary>
<p>

The following demonstration is taken directly from the [`rray`
package](https://github.com/r-lib/rray) (which is not currently on
CRAN).

    library (rray)
    a <- array(c(1, 2), dim = c(2, 1))
    b <- array(c(3, 4), dim = c(1, 2))
    # rbind (a, b) # error!
    rray_bind (a, b, .axis = 1)

    ##      [,1] [,2]
    ## [1,]    1    1
    ## [2,]    2    2
    ## [3,]    3    4

    rray_bind (a, b, .axis = 2)

    ##      [,1] [,2] [,3]
    ## [1,]    1    3    4
    ## [2,]    2    3    4

Broadcasting is commonly employed in ML software because it enables ML
operations to be implemented on objects with incommensurate dimensions.
One example is image analysis, in which training data may all be
dimensionally commensurate, yet test images may have different
dimensions. Broadcasting allows data to be submitted to ML routines
regardless of potentially incommensurate dimensions.

</p>
</details>

<br>

-   ***Learning Rate*** which (generally) determines the step size used
    to search for local optima as a fraction of the local gradient.

This parameter is particularly important for training ML algorithms like
neural networks, the results of which can be very sensitive to
variations in learning rates. A useful overview of the importance of
learning rates, and a useful approach to automatically determining
appropriate values, is given in [this blog
post](https://sgugger.github.io/how-do-you-find-a-good-learning-rate.html).

Before proceeding with the standards, the following sub-section
describes a typical ML workflow as envisions by these standards. This
workflow provides a useful context for the standards which follow,
particularly because typical ML workflows are often quite distinct from
workflows for statistical software in other categories.

**Workflows for Machine Learning Software**

We attempt here the difficult task of specifying a typical standard
workflow for inherently diverse ML software. This workflow pertains to
large sets of input data, only a portion of which will typically be able
to be stored in local memory. Adaptation of this kind of workflow to
situations in which all training data can be loaded into memory will
often mean one or more of the following stages do not apply. This thus
ought to be considered an “extensive” workflow, with shorter versions
possible dependent upon envisioned areas of application.

Just as typical workflows are potentially very diverse, so are outputs
of ML software, which depend on areas of application and intended
purpose of software. The following refers to the “desired output” of ML
software, a phrase which is intentionally left non-specific, but which
may connote some measure of matching to categorical labels, or measures
of distance between sets of training and validation data. Such “desired
outputs” are presumed to be quantified in terms of a “loss” or “cost”
function (hereafter, simply “loss function”) quantifying a distance
between a model estimate (resulting from applying the model to one or
more components of a training data set) and a pre-defined “valid”
output.

1.  Obtain local copy of input data, often in a series of
    sub-directories labelled something like `./train`, `./test`, and
    potentially additional folders such as `./validate` or other options
    used, for example, to determine accuracy of models applied to
    training data yet prior to testing.
2.  Define transformations of input data, including but not restricted
    to, broadcasting dimensions and standardising data ranges (typically
    to defined values of mean and standard deviation).
3.  Define what kind of model will be applied to map the input data on
    to the specified output (commonly either categorical labels, or a
    set of validation data). ML software often allows the use of
    pre-trained models, in which this this step includes downloading or
    otherwise obtaining a pre-trained model, along with specification of
    which aspects of those models are to be modified through application
    to the training and validation data.
4.  Define parameters controlling how algorithm will progress towards
    optimal solution, commonly including but not limited to:
    1.  The type of algorithm used to explore the search space (for
        example some kind of gradient descent algorithm).
    2.  The kind of loss function will be used to quantify distance
        between model estimates and desired output.
5.  Apply the specified model to the training data to generate a series
    of estimates from the specified loss function. This stage may also
    include
    1.  Specifying parameters such as stopping or exit criteria, and
        parameters controlling batch processing of input data.

    Moreover, this stage may involve retaining some of the following
    additional data:
    1.  Potential “pre-processing” stages such as initial estimates of
        optimal learning rates (see above).
    2.  Details of summaries of actual paths taken through the search
        space towards convergence on local or global minimum.
6.  Measure the performance of the trained model when applied to the
    test data set, generally requiring the specification of a metric of
    model performance or accuracy.

The following standards follow these steps. As described above, these
steps may not be applicable to all ML software, and so all of the
following standards should be considered to be conditioned on “where
applicable.”

### 1 Input Data Structures and Validation

The following standards apply to ML software which admits direct input
of pre-loaded data objects.

-   **ML1.0** Training and test data sets for ML software should be able
    to be input as a single, generally tabular, data object, with the
    two kinds of data distinguished either by
    -   A specified variable containing, for example, `TRUE`/`FALSE` or
        `0`/`1` values, or which uses some other system such as missing
        (`NA`) values to denote test data).
    -   An additional parameter designating case or row numbers or
        labels of test data.

The following standards apply to ML software for which input data are
expected to exist as multiple files, either locally stored, or
accessible via remote connection.

-   **ML1.1** Training and test data sets, along with other necessary
    components such as validation data sets, should be stored in their
    own distinctly labelled sub-directories.
    -   **ML1.1a** Absent clear justification for alternative design
        decisions, these sub-directories should be expected to be
        labelled “test” and “train”
    -   **ML1.1b** Software should use case-insensitive partial matching
        of these names, such that, for example, sub-directories named
        “Testing” and “Training” will be unambiguously identified.
-   **ML1.2** ML software should implement a single function which
    summarises contents of test and training (and other) data sets,
    minimally including counts of numbers of files, and potentially
    extending to tables or summaries of file types, sizes, and other
    information.

#### 1.1 Missing Values

Missing data are handled different by different ML software, and it is
also difficult to suggest generally applicable standards for
pre-processing missing values in ML software. The following standards
attempt to cover a practical range of typical approaches and
applications.

-   **ML1.3** ML software which does not admit missing values, and which
    expects no missing values, should implement explicit pre-processing
    routines to identify whether data has any missing values, and should
    generally error appropriately and informatively when passed data
    with missing values. In addition, ML software which does not admit
    missing values should:
    -   **ML1.3a** Explain why missing values are not admitted.
    -   **ML1.3b** Provide explicit examples (in function documentation,
        vignettes, or both) for how missing values may be imputed,
        rather than simply discarded.
-   **ML1.4** ML software which admits missing values should clearly
    document how such values are processed.
    -   **ML1.4a** Where missing values are imputed, software should
        offer multiple user-defined ways to input missing data.
    -   **ML1.4b** Where missing values are imputed, the precise
        imputation steps should also be explicitly documented, either in
        tests (see **ML7.1** below), function documentation, or
        vignettes.

### 2 Transformation and Pre-processing of Input Data

Standards for most other categories of statistical software suggest that
pre-processing routines should ensure that input data sets are
commensurate, for example, through having equal numbers of cases or
rows. In contrast, ML software is commonly intended to accept input data
which can not be guaranteed to be dimensionally commensurate, such as
software intended to process rectangular image files which may be of
different sizes.

-   **ML2.0** ML software which uses broadcasting to reconcile
    dimensionally incommensurate input data should offer an ability to
    at least optionally record transformations applied to each input
    file.

Beyond broadcasting and dimensional transformations, the following
standards apply to the pre-processing stages of ML software.

-   **ML2.1** A dedicated function should enable pre-processing steps to
    be defined and parametrized.
    -   **ML2.1a** That function should return an object which can be
        directly submitted to a specified model (see section 3, below).
    -   **ML2.1b** Absent explicit justification otherwise, that return
        object should have a defined class minimally intended to
        implement a default `print` method which summarizes the input
        data set (as per **ML1.2** above) and associated transformations
        (see the following standard).
-   **ML2.2** ML software which requires or relies upon numeric
    transformations of input data (such as change in mean values or
    variances) should allow explicit specification of target values,
    rather than rely on default generic values (such as transformations
    to z-scores).
    -   **ML2.2a** Those values should be recorded in the object return
        by the function described in the preceding standard.
    -   **ML2.2b** Where the parameters have default values, reasons for
        those particular defaults should be explicitly described.
    -   **ML2.2c** Any extended documentation (such as vignettes) which
        demonstrates the use of explicit values for numeric
        transformations should explicitly describe why particular values
        are used.

### 3 Model Specification

A “model” in the context of ML software is understood to be a means of
specifying a mapping between input and output data, generally applied to
training and validation data. Model specification is the step of
specifying *how* such a mapping is to be constructed. The specification
of *what* the values of such a model actually are occurs through
training the model, and is described in the following sub-section.

-   **ML3.0** Model specification should be implemented as a distinct
    stage prior to actual model fitting or training. In particular,
    -   **ML3.0a** A dedicated function should enable models to be
        specified without actually fitting or training them.
    -   **ML3.0b** That function should return an object which can be
        directly trained as described in the following sub-section.
    -   **ML3.0** That return object should have a defined class
        minimally intended to implement a default `print` method which
        summarises the model specification.
-   **ML3.1** ML software should allow the use of both untrained models,
    specified through model parameters only, as well as pre-trained
    models.
-   **ML3.2** ML software should enable different models to be applied
    to the object specifying data inputs and transformations (see
    sub-sections 1–2, above) without needing to re-define those
    preceding steps.
-   **ML3.3** Where ML software implements its own distinct classes of
    model objects (in the sense intended here), the properties and
    behaviours of those specific objects should be explicitly compared
    with objects produced by other ML software. In particular, where
    possible,
    -   **ML3.3** ML software should provide extended documentation (as
        vignettes or equivalent) comparing model objects with those from
        other ML software, noting both unique abilities and restrictions
        of any implemented classes.
-   **ML3.4** Where training rates are used, ML software should provide
    explicit documentation both in all functions which use training
    rates, and in extended form such as vignettes, of the important of
    and/or sensitivity to, different values of training rates. In
    particular,
    -   **ML3.4a** Unless explicitly justified otherwise, ML software
        should offer abilities to automatically determine appropriate or
        optimal training rates, either as distinct pre-processing
        stages, or as implicit stages of model training.
    -   **ML3.4b** ML software which provide default values for training
        rates should clearly document anticipated restrictions of
        validity of those default values; for example through clear
        suggestions that user-determined and -specified values may
        generally be necessary or preferable.

### 4 Algorithms

-   **ML4.0** Parameters controlling optimization algorithms should
    minimally include:
    -   **ML4.0a** Specification of the type of algorithm used to
        explore the search space.
    -   **ML4.0b** The kind of loss function used to assess distance
        between model estimates and desired output.
-   **ML4.1** Unless explicitly justified otherwise (for example because
    ML software under consideration is an implementation of one specific
    algorithm), ML software should:
    -   **ML4.1a** Implement or otherwise permit usage of multiple ways
        of exploring search space
    -   **ML4.1b** Implement or otherwise permit usage of multiple loss
        functions.

The specification of optimization algorithms may be implemented as a
part of model specification (in the prior section), or as a distinct
step in its own right. Either way, the following standard applies:

-   **ML4.2** ML software should permit specification of optimization
    algorithms in the sense covered by the preceding two standards prior
    to, and definitely not as part of, specification of model training
    as considered in the subsequent sub-section.

That is, the object passed to a model training exercise should contain
full specification of the optimization algorithm.

#### 4.1 CPU and GPU processing

ML software often involves manipulation of large numbers of rectangular
arrays for which graphics processing units (GPUs) are often more
efficient than central processing units (CPUs). ML software thus
commonly offers options to train models using either CPUs or GPUs. While
these standards do not currently suggest any particular design choice in
this regard, we do note the following:

-   **ML4.3** For ML software in which algorithms are coded in C++,
    user-controlled use of either CPUs or GPUs (on NVIDIA processors at
    least) should be implemented through direct use of
    [`libcudacxx`](https://github.com/NVIDIA/libcudacxx).

This library can be “switched on” through activating a single C++ header
file to switch from CPU to GPU.

### 5 Model Training

-   **ML5.0** ML software should generally implement a unified
    single-function interface to model training, able to receive as
    input a model specified according to all preceding standards. In
    particular, models with categorically different specifications, such
    as different model architectures or optimization algorithms, should
    be able to be submitted to the same model training function.
-   **ML5.1** ML software should retain explicit information on paths
    taken as an optimizer advances towards minimal loss. Such
    information should minimally include:
    -   **ML5.1a** Specification of all model-internal parameters, or
        equivalent hashed representation.
    -   **ML5.1b** The value of the loss function at each point
    -   **ML5.1c** Information used to advance to next point, for
        example quantification of local gradient.
-   **ML5.2** The subsequent extraction of information retained
    according to the preceding standard should be explicitly documented.

#### 5.1 Batch Processing

The following standards apply to ML software which implements batch
processing, commonly to train models on data sets too large to be loaded
in their entirety into memory.

-   **ML5.3** All parameters controlling batch processing and associated
    terminology should be explicitly documented, and it should not, for
    example, be presumed that users will understand the definition of
    “epoch” as implemented in any particular ML software.

According to that standard, it would for example be inappropriate to
have a parameter, `nepochs`, described as
`"Number of epochs used in model training"`. Rather, the definition and
particular implementation of “epoch” must be explicitly defined.

-   **ML5.4** Explicit guidance should be provided on selection of
    appropriate values for parameter controlling batch processing, for
    example, on trade-offs between batch sizes and numbers of epochs
    (with both terms explicitly defined in accordance with the preceding
    standard).
-   **ML5.5** ML software may optionally include a function to estimate
    likely time to train a specified model, through estimating initial
    timings from a small sample of the full batch.
-   **ML5.6** ML software should by default provide explicit information
    on the progress of batch jobs (even where those jobs may be
    implemented in parallel on GPUs). That information may be optionally
    suppressed through additional parameters.

#### 5.2 Re-sampling

ML software does not always rely on pre-specified and categorical
distinctions between training and test data. For example, models may be
fit to what is effectively one single data set in which specified cases
or rows are used as training data, and the remainder as test data.
Re-sampling generally refers to the practice of re-defining categorical
distinctions between training and test data. One training run
accordingly connotes training a model on one particular set of training
data and then applying that model to the specified set of test data.
Re-sampling starts that process anew, through constructing an
alternative categorical partition between test and training data.

Even where test and training data are distinguished by more than a
simple data-internal category (such as a labelling column), for example,
by being stored in distinctly-named sub-directories, re-sampling may be
implemented by effectively shuffling data between training and test
sub-directories.

-   **ML5.7.X** ML software should provide an ability to combine results
    from multiple re-sampling iterations sets) using a single parameter
    specifying numbers of iterations.
-   **ML5.8** Absent any additional specification, re-sampling
    algorithms should by default partition data according to proportions
    of original test and training data.
    -   **ML5.8a** Re-sampling routines of ML software should
        nevertheless offer an ability to explicitly control or override
        such default proportions of test and training data.

### 6 Model Output and Performance

-   **ML6.0** For ML software able to perform classification tasks, the
    return object should provide direct access to a classification
    (“confusion”) matrix.
-   **ML6.1** For ML software able to perform classification tasks, the
    return object should provide direct access to classification
    probabilities.

### 7 Testing

-   **ML7.0** Tests should demonstrate effects of different numeric
    scaling of input data (see **ML2.2**).
-   **ML7.1** For software which imputes missing data, tests should
    compare internal imputation with explicit code which directly
    implements imputation steps (even where such imputation is a
    single-step implemented via some external package). These tests
    serve as an explicit reference for how imputation is performed.
-   **ML7.2** Where model objects are implemented as distinct classes,
    tests should explicitly compare the functionality of these classes
    with functionality of equivalent classes for ML model objects from
    other packages.
    -   **ML7.2a** These tests should explicitly identify restrictions
        on the functionality of model objects in comparison with those
        of other packages.
    -   **ML7.2b** These tests should explicity identify functional
        advantages and unique abilities of the model objects in
        comparison with those of other packages.
-   **ML7.3** ML software should explicit document the effects of
    different training rates, and in particular should demonstrate
    divergence from optima with inappropriate training rates.
-   **ML7.4** ML software which implement independent training “epochs”
    should demonstrate in tests the effects of lesser versus greater
    numbers of epochs.
-   **ML7.5** ML software should explicitly test different optimization
    algorithms, even where software is intended to implement one
    specific algorithm.
-   **ML7.6** ML software should explicitly test different loss
    functions, even where software is intended to implement one specific
    measure of loss.
-   **ML7.7** Tests should explicitly compare all possible combinations
    in categorical differences in model architecture, such as different
    model architectures with same optimization algorithms, same model
    architectures with different optimization algorithms, and
    differences in both.
    -   **ML7.7a** Such combinations will generally be formed from
        multiple categorical factors, for which explicit use of
        functions such as
        [`expand.grid()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/expand.grid.html)
        is recommended.

The following example illustrates:

    architechture <- c ("archA", "archB")
    optimizers <- c ("optA", "optB", "optC")
    cost_fns <- c ("costA", "costB", "costC")
    expand.grid (architechture, optimizers, cost_fns)

    ##     Var1 Var2  Var3
    ## 1  archA optA costA
    ## 2  archB optA costA
    ## 3  archA optB costA
    ## 4  archB optB costA
    ## 5  archA optC costA
    ## 6  archB optC costA
    ## 7  archA optA costB
    ## 8  archB optA costB
    ## 9  archA optB costB
    ## 10 archB optB costB
    ## 11 archA optC costB
    ## 12 archB optC costB
    ## 13 archA optA costC
    ## 14 archB optA costC
    ## 15 archA optB costC
    ## 16 archB optB costC
    ## 17 archA optC costC
    ## 18 archB optC costC

All possible combinations of these categorical parameters could then be
tested by iterating over the rows of that output.

-   **ML7.8** The successful extraction of information on paths taken by
    optimizers (see **ML5.1**, above), should be tested, including
    testing the general properties, but not necessarily actual values
    of, such data.
