---
title: On Processes for Developing Open Standards
tags: manuscripts
robots: noindex, nofollow
---


# 1 Introduction

Many aspects of human endeavour, notably including academic activities,
have become increasingly “open” through the use of openly published data
and openly available tools. Such open activity has been largely enabled
by computational technology, in particular increases in bandwidth
available to share and access online open resources. One notable example
have been activities conducted in accordance with the so-called “FAIR”
principles for scientific data of Findability, Accessibility,
Interoperability, and Reusablility (Wilkinson et al. 2016). The first
two of those four components (Findability and Accessibility) directly
require some degree of openness to achieve, while the latter two
(Interoperability and Reusablility) are greatly facilitated or enhanced
by openness. FAIR principles may accordingly be viewed as an elucidation
of the importance of openness within the context of scientific data.

These principles extend beyond the domain of scientific data, for
example through to the tools used to develop and guide scientific
process, and in particular to software (Hasselbring et al. 2020).
Openness of software, especially manifest through open-source software,
is particularly important in encouraging and enabling activities
conducted in accordance with all four of the FAIR principles. Using
open-source software in scientific research naturally leads to *sharing*
software, which in turn leads to software being inherently designed for
*interoperability* and *reusablility*. The result is software being
designed to be (more) modular (Zirkelbach, Krause, and Hasselbring
2019). While modularity is a very effective way to enhance
*interoperability* and *reusablility*, it also means that any given
piece of software will have a wider range of dependencies on other
pieces of software not directly under the control of any particular
group of researchers.

Such increasing ranges of dependencies mean that adherence to FAIR
principles both of scientific data and processes increases the need to
ensure that interoperated and reused components are of sufficient
quality or standard. Extending the FAIR principles to scientific process
thus unavoidably requires the development of standards which, in
accordance again with FAIR principles, must themselves be open. While
individual researchers and research organizations can engage with these
principles largely independent of other researchers or organizations,
the ongoing effectiveness of these principles in transforming research
to become more *FAIR* ultimately requires the development,
dissemination, and adoption of open standards, and that can only emerge
from collective rather than individual-level enterprise.

## 1.1 Open Standards

We consider open standards to be those which are and continue to be
guided by public discussions, and to which anybody may contribute
(referred to as open “concerted” standards by Cerri and Fuggetta 2007).
The development of adoption of open standards is in itself an enacting
of FAIR principles, because such standards must reflect, among other
aspects, an intention to enhance *interoperability* and *reusablility*.
Within software contexts, open standards have been most widely
considered in regard to formats for representing and/or exchanging data
(such as standards for “pdf” or “svg” file formats, respectively defined
and maintained by a closed private corporation, and the open Worldwide
Web Consortium). The development of such standards can often greatly
facilitate the development of standard tools (or the standardisation of
existing tools), which can in turn reduce costs, either or initial entry
into, or ongoing maintenance of, processes (Dedrick 2003).

Standards are generally developed by some form of organization[1] with a
vested interest in the perceived benefits of being associated with those
standards, commonly either through recognition, perceived benefit for
their own work, or both. Organizations interested in developing
standards are also generally embedded within broader communities which
may also be involved with, and benefit from, the development and
application of standards. Open standards in particular are by definition
embedded within open community participation. Open “concerted” standards
as defined by Cerri and Fuggetta (2007) are defined by the two primary
attributes of

1.  Being defined and maintained *in concert* by groups of generally
    open or public organizations; and
2.  Being defined and managed by an open, participatory process that is
    not necessarily confined to the organizations which issue the
    standards (from here on, “issuing organizations”).

The present work focusses exclusively on open concerted standards in
this sense, for which community engagement both in processes of initial
conception and ongoing development is particularly important. Open
concerted standards are ones for which general community members beyond
issuing organizations may contribute both to initial definition and
ongoing development of standards. This is in contrast with other types
of standards, and particularly with closed standards which may be
entirely defined and maintained by a closed and select group of
individuals, each of whom may commonly be deemed some kind of domain
expert. While the consultation of such domain experts may also play a
role in the initial definition and ongoing maintenance of open concerted
standards, expert consultation alone will generally not be sufficiently
participatory or community-oriented for standards to adequately reflect
a community *in concert*. This work thus primarily focuses on tools and
techniques uniquely applicable to such open processes, and places
concomitantly relatively little focus on what might be considered more
traditional approaches to standards development such as expert
consultation.

The importance of open standards have been considered in numerous
specialised domains, such as health care (Reynolds and Wyatt 2011),
libraries (Corrado 2005), and governance (Simon 2005).

## 1.2 Restrictions of our Project

-   Much of the empirical research was drawn from material ultimately
    arising from academic activities which are inherently open, and so
    provide sufficient material to define scope and usage of software.
-   Adaptation to other areas with comparably less “raw data” available
    in open form may not be so straightforward.
-   That said, the empirical research ultimately aimed only to construct
    a “network graph” of inter-relationships between concepts within our
    chosen domain. Any information that could be used to define concepts
    and their inter-relationships could be used to approach this task.
    For example, an analogous network graph could be derived by
    analysing dependency graphs of open-source software.

## 1.3 Motivation

We aim here to document a process by which we developed a suite of open
standards for open-source software, and in doing so to provide a
template able to be adopted and adapted for *reusablility* in other
domains. More generally, we aim to demonstrate an effective way to
approach and hopefully overcome the problem elucidated at the outset
that individually-adopted FAIR principles unavoidably require the
development of collectively-consensual open standards. This
demonstration is intended to serve as a template for how FAIR principles
in other domains can be extended towards the development of sets of
collective, open standards, which further enables and enhances the
ongoing development of FAIR research.

## 1.4 Context

Our area of application was statistical software written in the computer
language R, a language explicitly designed for “statistical computing.”
The present work describes a project to expand an existing system for
peer review of open source software developed by *rOpenSci* to
accommodate explicitly statistical software. The current review system
encompasses several categories of software developed in the R language,
yet excludes statistical software, because the organization felt they
had no members with sufficient expertise in that domain. One of the most
important components of project to expand the scope to include
statistical software was the development of a suite of standards. All
empirical descriptions of the present work thus pertain to the specific
domain of statistical software, yet we attempt throughout to extract
general or generalizable principles behind this specific application,
and to explore how our domain-specific processes might be adapted for
development in other domains.

## 1.5 Additional Stuff

-   “Working in Public” by Nadia Eghbal
-   Examples of FDA + EU standards for pharma workflows including
    software; R Validation Hub
-   Discuss relationship between standards and assessment

# 2 Developing Open Standards

Standards are most effectively developed within a concrete and
definitive structure. While it may be possible to develop standards to
apply to some generic domain without any notion of how that domain may
be internally structured, the task will likely be both easier and more
effective when the internal structure of an overall domain of
applicability is first defined. Arguably the easiest way to define such
internal structure is to divide a domain among a number of
domain-specific categories.

We ultimately consider a hierarchical sub-division of an entire domain
at a first level into categories, and at a second, subsidiary level,
into sub-categories within those categories, such that the standards for
each category are intelligibly separated among specified sub-categories.
The primary task of definition nevertheless remains that of defining
categories, as considered in the following sub-section. Following that
we consider the process of defining standards for each category, which
involves the clarification of sub-categories. The subsequent two
sub-sections then consider processes of revision, iteration, and ongoing
development of resultant standards.

## 2.1 Defining Scope

The first task in developing any standards is defining the scope of what
is to be considered under the standards. Any set of standards can only
be applied within some specific domain. Our domain of application, as
explored at length in the subsequent *Demonstration* section, was
statistical software, but the present section is intended to be as
generally applicable as possible, including to domains other than
software.

Defining specific categories within a domain of application for
standards enables sub-sets of standards to be devised for more
restricted application to those categories only. This will likely
generally be an easier task than devising standards which aim for
universal applicability across an entire domain. Therefore defining
scope is one of the most important steps in developing any set of
standards, with this section exploring general processes by which scope
may be defined in terms of categorical distinctions with a given domain.
As described at the outset, we largely eschew processes which may be
effectively used to define the scope of closed standards such as expert
consultation, and focus here on more open and ultimately more
reproducible and transferable processes.

### Empirical Derivation of Categories

We now describe general processes by which categories can be defined
using empirical input data of (i) a series of potential categorical
labels, and (ii) some measure of inter-relationship between those
labels, such as frequencies or counts of co-occurrence. This sub-section
describes how those kinds of data can be submitted to clustering
algorithms in order to empirically distinguish unique sub-domains with
the data.

These input data must be derived from some kind of corpus containing a
series of objects. These objects can be solely textual, as in our case
below which used conference abstracts, or they might be non-text objects
such as software repositories. Either way, each object must be assigned
one or more categorical labels. In our case, we performed an initial,
superficial perusal of our corpus to intuit what kinds of labels may be
useful in describing the abstracts. We then proceeded to label
individual abstracts, keeping a record of all unique labels developed as
we proceeded through the corpus. These labels were, and will likely
generally be, partly subjective, with a primary initial effect being
that items in the list of labels were modified and revised as we
proceeded through the corpus.

We thus performed the labelling exercise twice: A first time in order to
derive a representative and stable list of potential labels, and a
second time to apply items from the final list of labels to each entity
in our corpus. Our primary input data was then simply a list of items,
one for each abstract, each entry of which contained one or more labels
of sub-categories within our overall field of statistical software.

We then converted these lists into a network representation, with
weights between each pairs of unique labels formed by the aggregate
number of times those two labels co-occurred within any single corpus
entity. While it may be possible to submit such a network representation
to an empirical routine in order to discern clusters of related labels,
the results in our case did not appear particularly useful. We therefore
converted our network into an interactive `html` format which enables us
to examine the resultant network and apply subjective insights into
resultant patterns.

#### Sourcing and Collating Input Data

As primary input data we needed a corpus of texts representative of our
primary domain of statistical software. We initially tried using
published academic texts extracted from online open-access journals, but
found that language used within typical academic papers describing
statistical software was so highly specialised and accordingly stylised
that identifying words were unable to serve as categorical labels
because they were either overly unique (being used in only or or two
manuscripts), or overly generic and used ubiquitously throughout our
entire domain.

## 2.2 Defining Category-Specific Standards

## 2.3 Iterating Standards

## 2.4 Ongoing Development and Versioning

# 3 Demonstration

The following methods

## 3.1 Defining Scope

-   Collect “raw data” by:
    -   Identifying online (or other) resources providing textual
        descriptions of software development and usage within our area
        of application.
    -   Manually filter to only those texts specifically relating to
        software
-   Analyse raw data by:
    -   Initial text analyses to extract key words and concepts
    -   Manually refine these to a working set of key words and concepts
    -   Manually ascribe key words/concepts to each text in the data set
    -   Convert texts to frequencies of association between all pairs of
        key words/concepts
-   Extraction of key words/concepts:
    -   Produce a visual representation of network of key
        words/concepts, with connections visually weighted by relative
        frequencies of association.
    -   Use those relative frequencies of association to statistically
        identify clusters of similar key words/concepts.
    -   Provide each distinct cluster within the visualization with its
        own colour
    -   Use that visualization to identify distinct clusters of key
        words/concepts
-   Mapping key words/concepts onto sub-categories:
    -   For each key word/concept, extract from the text corpus all
        strongly associated words, divided into different parts of
        speech (primarily adjectives, nouns, or verbs).
    -   Use the resultant lists of associated words to formulate an
        initial description of that key word/concept as a potential
        sub-category for which to develop standards.

## 3.2 Formulating Standards

-   Process used / devised to derive actual standards for the
    empirically derived set of candidate categories.

------------------------------------------------------------------------

# 4 References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-cerri_open_2007" class="csl-entry">

Cerri, Davide, and Alfonso Fuggetta. 2007. “Open Standards, Open
Formats, and Open Source.” *Journal of Systems and Software* 80 (11):
1930–37. <https://doi.org/10.1016/j.jss.2007.01.048>.

</div>

<div id="ref-corrado_importance_2005" class="csl-entry">

Corrado, Edward M. 2005. “The Importance of Open Access, Open Source,
and Open Standards for Libraries.” <https://doi.org/10.5062/F42F7KD8>.

</div>

<div id="ref-dedrick_why_2003" class="csl-entry">

Dedrick, J. 2003. “Why Firms Adopt Open Source Platforms: A Grounded
Theory of Innovation and Standards Adoption.” In *Standard Making: A
Critical Research Frontier for Information Systems*, 145:236–57. MSIQ.
<https://www.semanticscholar.org/paper/WHY-FIRMS-ADOPT-OPEN-SOURCE-PLATFORMS>.

</div>

<div id="ref-hasselbring_fair_2020" class="csl-entry">

Hasselbring, Wilhelm, Leslie Carr, Simon Hettrick, Heather Packer, and
Thanassis Tiropanis. 2020. “From FAIR Research Data Toward FAIR and Open
Research Software.” *It - Information Technology* 62 (1): 39–47.
<https://doi.org/10.1515/itit-2019-0040>.

</div>

<div id="ref-reynolds_open_2011" class="csl-entry">

Reynolds, Carl J., and Jeremy C. Wyatt. 2011. “Open Source, Open
Standards, and Health Care Information Systems.” *Journal of Medical
Internet Research* 13 (1): e24. <https://doi.org/10.2196/jmir.1521>.

</div>

<div id="ref-simon_value_2005" class="csl-entry">

Simon, K. D. 2005. “The Value of Open Standards and Open-Source Software
in Government Environments.” *IBM Systems Journal* 44 (2): 227–38.
<https://doi.org/10.1147/sj.442.0227>.

</div>

<div id="ref-wilkinson_fair_2016" class="csl-entry">

Wilkinson, Mark D., Michel Dumontier, IJsbrand Jan Aalbersberg,
Gabrielle Appleton, Myles Axton, Arie Baak, Niklas Blomberg, et al.
2016. “The FAIR Guiding Principles for Scientific Data Management and
Stewardship.” *Scientific Data* 3 (1): 160018.
<https://doi.org/10.1038/sdata.2016.18>.

</div>

<div id="ref-zirkelbach_modularization_2019" class="csl-entry">

Zirkelbach, Christian, Alexander Krause, and Wilhelm Hasselbring. 2019.
“Modularization of Research Software for Collaborative Open Source
Development.” *arXiv:1907.05663 \[cs\]*, July.
<http://arxiv.org/abs/1907.05663>.

</div>

</div>

[1] Notwithstanding the possibility of standards being developed by one
or more individuals who do not necessarily affiliate themselves with any
“organization” as such.
