# hackmd-stat-software

A mirror repo to hold [`hackmd`](https://hackmd.io) notes for [rOpenSci Statistical Software Project](https://hackmd.io/@stat-software). It's (almost) all `makefile` controlled, with `make copy` used to copy all `.Rmd` files over to the source repository for [`statistical-software-peer-review`](https://github.com/ropenscilabs/statistical-software-peer-review) so these files can remain a definitive source. They're all simply included in that document as `child` documents.

The hierarchy of section titles within the book means that titles of individual standards start at second-header level ("##"), with sub-sections using three and four hashes.

## Inserting New Standards

Inserting new standards into the list which appears on the [official bookdown document](https://ropenscilabs.github.io/statistical-software-review-book/standards.html) generally means changing the enumeration of previous standards, and ensuring all changes are propagated through to all documents which reference those standards. This task has been automated via the script [`increment.R`](https://github.com/mpadge/hackmd-stat-software/blob/master/increment.R) contained within this repository, which makes updating as simple as the following lines. The function only needs a specification of the new standard which is to be inserted. If, for example, we wish to insert a new Machine Learning standard between **ML4.7** and **ML4.8**, then the new standard would be **ML4.8**, because **ML4.7** would remain the same, whereas all former standards from **ML4.8** onwards would need to be increment by one, to become **ML4.9** and so on.

This script is intended to be run in a local clone of this current repository, and will update bot the standards contained here, which are directly linked with the 
[`hackmd` documents](https://hackmd.io/@stat-software), and the standards which appear within the 
[official bookdown
document](https://ropenscilabs.github.io/statistical-software-review-book/standards.html). The script needs only one piece of additional information specifying a path to your local version of the [repository for the bookdown source](https://github.com/ropenscilabs/statistical-software-peer-review).

``` r
Sys.setenv ("rss_bookdown_dir" = "<local>/<path>/<to>/statistical-software-peer-review")
source ("increment.R")
increment_standards ("ML4.8")
```

Having run that command, there will no longer be a standard named **ML4.8**, leaving you free to insert your desired new standard.

