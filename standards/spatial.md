---
title: Spatial Software Standards
tags: statistical-software
robots: noindex, nofollow
---


<!-- Edit the .Rmd not the .md file -->
<!-- TODO
- revisit regression standards and use a a guide for how to write/adapt actual
  algorithmic standards for spatial software.
- permutation-type statistics which need random seeds
- clustering
- spatial as a context for representating data which is then passed through to
  algorithms which themselves might be subject to additional standards.
- Kernel density estimates: What are default values for parameters? How are
  they justified? How can they be controlled?
-->

## Spatial Software

Standards for spatial software begin with a consideration and
standardisation of domains of applicability. Following that we proceed
to standards according to which spatial software is presumed to perform
one or more of the following steps:

1.  Accept and validate input data
2.  Apply one or more analytic algorithms
3.  Return the result of that algorithmic application
4.  Offer additional functionality such as printing or summarising
    return results
5.  Testing

Each standard for spatial software is prefixed with “**SP**”.

### 1 Spatial Domains

Many developers of spatial software in R, including many of those those
featured on the CRAN Task view on [“Analysis of Spatial
Data”](https://cran.r-project.org/web/views/Spatial.html), have been
primarily focussed on geographic data; that is, data quantifying
positions, structures, and relationships on the Earth and other planets.
Spatial analyses are nevertheless both broader and more general than
geography alone. In particular, spatial software may be *geometric* –
that is, concerned with positions, structures, and relationships in
space in any general or specific sense, not necessarily confined to
geographic systems alone.

It is important to distinguish these two domains because many algorithms
and procedures devised in one of these two domains are not necessarily
(directly) applicable in the other, most commonly because geometric
algorithms presume space to be rectilinear or Cartesian, while
geographic algorithms (generally) presume it be have a specific
curvilinear form (commonly spherical or elliptical). Algorithms designed
for Cartesian space may not be directly applicable in curvilinear space,
and vice-versa.

Moreover, spatial software and algorithms might be intended to apply in
spaces of arbitrary dimensionality. The phrase “Cartesian” refers to any
space of arbitrary dimensionality in which all dimensions are orthogonal
and described by straight lines; dimensions in a curvilinear space or
arbitrary dimensionality are described by curved lines. A planar
geometry is a two-dimensional Cartesian space; a spherical geometry is a
two- (or maybe three-)dimensional curvilinear space.

One of the earliest and still most widely used R spatial packages,
[`spatstat`](https://cran.r-project.org/web/packages/spatstat/) (first
released 2002), describes itself as, “\[f\]ocused mainly on
two-dimensional point patterns, including multitype/marked points, in
any spatial region.” Routines from this package are thus generally
applicable to two-dimensional Cartesian data only, even through the
final phrase might be interpreted to indicate a comprehensive
generality. `spatstat` routines may not necessarily give accurate
results when applied in curvilinear space.

These considerations motivate the first standard for spatial software:

-   **SP1.0** *Spatial software should explicitly indicate its domain of
    applicability, and in particular distinguish whether the software
    may be applied in Cartesian/rectilinear/geometric domains,
    curvilinear/geographic domains, or both.*

We encourage the use of clear and unambiguous phrases such as “planar”,
“spherical”, “Cartesian”, “rectilinear” or “curvilinear”, along with
clear indications of dimensionality such as “two-” or
“three-dimensional.” Concepts of dimensionality should be interpreted to
refer explicitly to the dimensionality of independent spatial
coordinates. Elevation is a third spatial dimension, and time may also
be considered an additional dimension. Beyond those two, other
attributes measured at spatial locations do not represent additional
dimensions.

-   **SP1.1** *Spatial software should explicitly indicate its
    dimensional domain of applicability, in particular through
    identifying whether it is applicable to two or three dimensions
    only, or whether there are any other restrictions on
    dimensionality.*

These considerations of domains of applicability permeate much of the
ensuring standards, which distinguish “geometric software” from
“geographic software”, where these phrases are to be interpreted as
shorthand references to software intended for use in the respective
domains.

### 2 Input data structures and validation

Input validation is an important software task, and an important part of
our standards. While there are many ways to approach validation, the
class systems of R offer a particularly convenient and effective means.
For Spatial Software in particular, a range of class systems have been
developed, for which we refer to the CRAN Task view on [“Analysis of
Spatial Data”](https://cran.r-project.org/web/views/Spatial.html).
Software which uses and relies on defined classes can often validate
input through affirming appropriate class(es). Software which does not
use or rely on class systems will generally need specific routines to
validate input data structures.

As for our standards for [Time-Series
Software](https://ropenscilabs.github.io/statistical-software-review-book/standards.html#time-series-software),
these standards for Spatial Software also suggest that software should
use explicit class systems designed and intended for spatial data. New
packages may implement new class systems for spatial data, and these may
even be as simple as appending a class attribute to a matrix of
coordinates. The primary motivation of the following standard is
nevertheless to encourage and enhance inter-operability with the rich
system of classes for spatial data in R.

-   **SP2.0** *Spatial software should only accept input data of one or
    more classes explicitly developed to represent such data.*
    -   **SP2.0a** *Where new classes are implemented, conversion to
        other common classes for spatial data in R should be
        documented.*
    -   **SP2.0b** *Class systems should ensure that functions error
        appropriately, rather than merely warning, in response to data
        from inappropriate spatial domains.*

**Spatial Workflows, Packages, and Classes**

Spatial software encompasses an enormous diversity, yet workflows
implemented by spatial software often share much in common. In
particular, coordinate reference systems used to precisely relate pairs
of coordinates to precise locations in a curvilinear space, and in
particular to the Earth’s ellipsoid, need to be able to be compared and
transformed regardless of the specificities of individual software. This
ubiquitous need has fostered the development of the [`PROJ`
library](https://proj.org/) for representing and transforming spatial
coordinates. Several other libraries have been built on top or or
alongside that, notably including the [`GDAL` (“Geospatial Data
Abstraction Library”)](https://gdal.org) and [`GEOS` (“Geometry Engine,
Open Source”)](https://trac.osgeo.org/geos/) libraries. These libraries
are used by, and integrated within, most geographical spatial software
commonly used today, and will likely continue to be used.

While not a standard in itself, it is expected that spatial software
should not, absent very convincing and explicit justification, attempt
to reconstruct aspects of these generic libraries. Given that, the
following standards aim to ensure that spatial software remains as
compatible as possible with workflows established by preceding packages
which have aimed to expose and integrate as much of the functionality of
these generic libraries as possible. The use of specific class systems
for spatial data, and the workflows encapsulated in associated packages,
ensures maximal ongoing compatibility with these libraries and with
spatial workflows in general.

Notable class systems and associated packages in R include
[`sp`](https://cran.r-project.org/package=sp),
[`sf`](https://cran.r-project.org/package=sf), and
[`raster`](https://rspatial.org/raster/), and more recent extensions
such as [`stars`](https://cran.r-project.org/package=stars),
[`terra`](https://rspatial.org/terra), and
[`s2`](https://r-spatial.github.io/s2/). With regard to these packages,
the following single standard applies, because the maintainer of sp has
made it clear that new software [should build upon sf, not
sp](https://github.com/r-spatial/discuss/issues/48#issuecomment-798543339).

-   **SP2.1** *Spatial Software should not use the [`sp`
    package](https://cran.r-project.org/package=sp), rather should use
    [`sf`](https://cran.r-project.org/package=sf).*

More generally,

-   **SP2.2** *Geographical Spatial Software should ensure maximal
    compatibility with established packages and workflows, minimally
    through:*
    -   **SP2.2a** *Clear and extensive documentation demonstrating how
        routines from that software may be embedded within, or otherwise
        adapted to, workflows which rely on these established packages;
        and*
    -   **SP2.2b** *Tests which clearly demonstrate that routines from
        that software may be successfully translated into forms and
        workflows which rely on these established packages.*

This standard is further refined in a number of subsequent standards
concerning documentation and testing.

-   **SP2.3** *Software which accepts spatial input data in any standard
    format established in other R packages (such as any of the formats
    able to be read by [`GDAL`](https://gdal.org), and therefore by the
    [`sf` package](https://cran.r-project.org/package=sf)) should
    include example and test code which load those data in spatial
    formats, rather than R-specific binary formats such as `.Rds`.*

See the `sf` vignette on [“*Reading, Writing and Converting Simple
Features*”](https://cran.r-project.org/web/packages/sf/vignettes/sf2.html)
for useful examples.

**Coordinate Reference Systems**

As described above, one of the primary reasons for the development of
classes in Spatial Software is to represent the coordinate reference
systems in which data are represented, and to ensure compatibility with
the [`PROJ` system](https://proj.org/) and other generic spatial
libraries. The [`PROJ`](https://proj.org/) standards and associated
software library have been recently (2020) updated (to version number 7)
with “breaking changes” that are not backwards-compatible with previous
versions, and in particular with the long-standing version 4. The
details and implications of these changes within the context of spatial
software in R can be examined in [this blog
entry](https://www.r-spatial.org//r/2020/03/17/wkt.html) on
[`r-spatial.org`](https://r-spatial.org), and in [this
vignette](https://cran.r-project.org/web/packages/rgdal/vignettes/PROJ6_GDAL3.html)
for the [`rgdal`
package](https://cran.r-project.org/web/packages/rgdal/). The “breaking”
nature of these updates partly reflects analogous “breaking changes”
associated with updates in the [“Well-Known Text”
(WKT)](http://docs.opengeospatial.org/is/12-063r5/12-063r5.html) system
for representing coordinate reference systems.

The following standard applies to software which directly or indirectly
relies on geographic data which uses or relies upon coordinate reference
systems.

-   **SP2.4** *Geographical Spatial Software should be compliant with
    version 6 or larger of* [`PROJ`](https://proj.org/), *and with*
    `WKT2` *representations. The primary implication, described in
    detail in the articles linked to above, is that:*
    -   **SP2.4a** *Software should not permit coordinate reference
        systems to be defined on the basis of so-called “PROJ4-strings”
        alone.*

**General Input Structures**

New spatial software may nevertheless eschew these prior packages and
classes in favour of implementing new classes. Whether or not prior
classes are used or expected, geographic software should accord as much
as possible with the principles of these prior systems by according with
the following standards:

-   **SP2.5** *Class systems for input data must contain meta data on
    associated coordinate reference systems.*
    -   **SP2.5a** *Software which implements new classes to input
        spatial data (or the spatial components of more general data)
        should provide an ability to convert such input objects into
        alternative spatial classes such as those listed above.*
-   **SP2.6** *Spatial Software should explicitly document the types and
    classes of input data able to be passed to each function.*
-   **SP2.7** *Spatial Software should implement validation routines to
    confirm that inputs are of acceptable classes (or represented in
    otherwise appropriate ways for software which does not use class
    systems).*
-   **SP2.8** *Spatial Software should implement a single pre-processing
    routine to validate input data, and to appropriately transform it to
    a single uniform type to be passed to all subsequent data-processing
    functions.*
-   **SP2.9** *The pre-processing function described above should
    maintain those metadata attributes of input data which are relevant
    or important to core algorithms or return values.*

### 3 Algorithms

The following standards will be conditionally applicable to some but not
all spatial software. Procedures for standards deemed not applicable to
a particular piece of software are described in the [`srr`
package](https://github.com/ropenscilabs/srr).

-   **SP3.0** *Spatial software which considers spatial neighbours
    should enable user control over neighbourhood forms and sizes. In
    particular:*
    -   **SP3.0a** *Neighbours (able to be expressed) on regular grids
        should be able to be considered in both rectangular only, or
        rectangular and diagonal (respectively “rook” and “queen” by
        analogy to chess).*
    -   **SP3.0b** *Neighbourhoods in irregular spaces should be
        minimally able to be controlled via an integer number of
        neighbours, an area (or equivalent distance defining an area) in
        which to include neighbours, or otherwise equivalent
        user-controlled value.*
-   **SP3.1** *Spatial software which considers spatial neighbours
    should wherever possible enable neighbour contributions to be
    weighted by distance (or other continuous weighting variable), and
    not rely exclusively on a uniform-weight rectangular cut-off.*
-   **SP3.2** *Spatial software which relies on sampling from input data
    (even if only of spatial coordinates) should enable sampling
    procedures to be based on local spatial densities of those input
    data.*

An example of software which would *not* adhere to **SP3.2** would be
where input data were a simple matrix of spatial coordinates, and
sampling were implemented using the [`sample()`
function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html)
to randomly select elements of those input data (like
`sample(nrow(xy), n)`). In the context of an example based on the
[`sample()`
function](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html),
adhering to the standard would require including an additional `prob`
vector where each point was weighted by the local density of surrounding
points. Doing so would lead to higher probabilities of samples being
taken from central clusters of higher densities than from outlying
extreme points. Note that the standard merely suggests that software
should *enable* such density-based samples to be taken, not that it
must, or even necessarily should by default.

Algorithms for spatial software are often related to other categories of
statistical software, and it is anticipated that spatial software will
commonly also be subject to standards from these other categories.
Nevertheless, because spatial analyses frequently face unique
challenges, some of these category-specific standards also have
extension standards when applied to spatial software. The following
standards will be applicable for any spatial software which also fits
any of the other listed categories of statistical software.

**Regression Software**

-   **SP3.3** *Spatial regression software should explicitly quantify
    and distinguish autocovariant or autoregressive processes from those
    covariant or regressive processes not directly related to spatial
    structure alone.*

**Unsupervised Learning Software**

The following standard applies to any spatial unsupervised learning
software which uses clustering algorithms.

-   **SP3.4** *Where possible, spatial clustering software should avoid
    using standard non-spatial clustering algorithms in which spatial
    proximity is merely represented by an additional weighting factor in
    favour of explicitly spatial algorithms.*

**Machine Learning Software**

One common application in which machine learning algorithms are applied
to spatial software is in analyses of raster images. The first of the
following standards applies because the individual cells or pixels of
these raster images represent fixed spatial coordinates. (This standard
also renders **ML2.1** inapplicable).

-   **SP3.5** *Spatial machine learning software should ensure that
    broadcasting procedures for reconciling inputs of different
    dimensions are **not** applied*.

A definition of broadcasting is given at the end of the introduction to
corresponding [Machine Learning
Standards](file:///data/mega/code/repos/ropensci-stats/statistical-software-review-book/docs/standards.html#machine-learning-software),
just above *Input Data Specification*.

-   **SP3.6** *Spatial machine learning software should ensure that test
    and training data are generated using sampling procedures
    appropriate to the domain or intended use of that software.*
    -   **SP3.6a** *The effects of generating test and training data
        using inappropriate sampling procedures should be documented
        and/or tested.*

We note that there are no comparable *General Standard* for [*Machine
Learning Software*](#ml-standards), but that such distinction is
particularly important for spatial machine learning software because it
is frequently inappropriate to distinguish test and training data by
taking samples from the same spatial region. One common method employed
to generate distinct test and training data is spatial partitioning
\[@muenchow\_chapter\_nodate;@brenning\_spatial\_2012;@schratz\_hyperparameter\_2019;@valavi\_blockcv\_2019\].
There may nevertheless be cases in which such sampling from a common
spatial region is appropriate, for example for software intended to
analyse or model temporally-structured spatial data for which a more
appropriate distinction might be temporal rather than spatial. Adherence
to this standard merely requires that the distinction between test and
training data be explicitly considered and documented (and possibly
tested as well).

### 4 Return Results

For (functions within) Spatial Software which return spatial data:

-   **SP4.0** *Return values should either:*
    -   **SP4.0a** *Be in same class as input data, or*
    -   **SP4.0b** *Be in a unique, preferably class-defined, format.*
-   **SP4.1** *Any aspects of input data which are included in output
    data (either directly, or in some transformed form) and which
    contain units should ensure those same units are maintained in
    return values.*
-   **SP4.2** *The type and class of all return values should be
    explicitly documented.*

### 5 Visualization

Spatial Software which returns objects in a custom class structure
explicitly designed to represent or include spatial data should:

-   **SP5.0** *Implement default `plot` methods for any implemented
    class system.*
-   **SP5.1** *Implement appropriate placement of variables along x- and
    y-axes.*
-   **SP5.2** *Ensure that axis labels include appropriate units.*

An example of **SP5.1** might be ensuring that longitude is placed on
the x-axis, latitude on the y, although standard orientations may depend
on coordinate reference systems and other aspects of data and software
design. The preceding three standards will generally not apply to
software which returns objects in a custom class structure yet which is
not inherently spatial.

Spatial Software which returns objects with geographical coordinates
should:

-   **SP5.3** *Offer an ability to generate interactive (generally
    `html`-based) visualisations of results.*

### 6 Testing

The following standards apply to all Spatial Software which is intended
or able to be applied to data represented in curvilinear systems,
notably including all geographical data. The only Spatial Software to
which the following standards do not (necessarily) apply would be
software explicitly intended to be applied exclusively to Cartesian
spatial data, and which ensured appropriate rejection of curvilinear
data according to **SP2.0b**.

**Round-Trip Tests**

-   **SP6.0** *Software which implements routines for transforming
    coordinates of input data should include tests which demonstrate
    ability to recover the original coordinates.*

This standard is applicable to any software which implements any
routines for coordinate transformations, even if those routines are
implemented via [`PROJ`](https://proj.org). Conversely, software which
has no routines for coordinate transformations need not adhere to
**SP6.0**, even if that software relies on `PROJ` for other purposes.

-   **SP6.1** *All functions which can be applied to both Cartesian and
    curvilinear data should be tested through application to both.*
    -   **SP6.1a** *Functions which may yield inaccurate results when
        applied to data in one or the other forms (such as the preceding
        examples of centroids and buffers from ellipsoidal data) should
        test that results from inappropriate application of those
        functions are indeed less accurate.*
    -   **SP6.1b** *Functions which yield accurate results regardless of
        whether input data are rectilinear or curvilinear should
        demonstrate equivalent accuracy in both cases, and should also
        demonstrate how equivalent results may be obtained through first
        explicitly transforming input data.*

**Extreme Geographical Coordinates**

-   **SP6.2** *Geographical Software should include tests with extreme
    geographical coordinates, minimally including extension to polar
    extremes of +/-90 degrees.*

While such tests should generally confirm that software generates
reliable results to such extreme coordinates, software which is unable
to generate reliable results to such inputs should nevertheless include
tests to indicate both approximate bounds of reliability, and the
expected characteristics of unreliable results.

The remaining standards for testing Spatial Software extend directly
from the preceding Algorithmic Standards (**SP3**), with the same
sub-section headings used here.

-   **SP6.3** *Spatial Software which considers spatial neighbours
    should explicitly test all possible ways of defining them, and
    should explicitly compare quantitative effects of different ways of
    defining neighbours.*
-   **SP6.4** *Spatial Software which considers spatial neighbours
    should explicitly test effects of different schemes to weight
    neighbours by spatial proximity.*

**Unsupervised Learning Software**

-   **SP6.5** *Spatial Unsupervised Learning Software which uses
    clustering algorithms should implement tests which explicitly
    compare results with equivalent results obtained with a non-spatial
    clustering algorithm.*

**Machine Learning Software**

-   **SP6.6** \*Spatial Machine Learning Software should implement tests
    which explicitly demonstrate the detrimental consequences of
    sampling test and training data from the same spatial region, rather
    than from spatially distinct regions.
