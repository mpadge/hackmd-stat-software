# hackmd-stat-software

A mirror repo to hold [`hackmd`](https://hackmd.io) notes for [rOpenSci Statistical Software Project](https://hackmd.io/@stat-software). It's (almost) all `makefile` controlled, with `make copy` used to copy all `.Rmd` files over to the source repository for [`statistical-software-peer-review`](https://github.com/ropenscilabs/statistical-software-peer-review) so these files can remain a definitive source. They're all simply included in that document as `child` documents.

The hierarchy of section titles within the book means that titles of individual standards start at second-header level ("##"), with sub-sections using three and four hashes.

## Inserting New Standards

Inserting new standards into the list which appears on the [official bookdown document](https://ropenscilabs.github.io/statistical-software-review-book/standards.html) generally means changing the enumeration of previous standards, and ensuring all changes are propagated through to all documents which reference those standards. This task has been automated via the script [`increment.R`](https://github.com/mpadge/hackmd-stat-software/blob/master/increment.R) contained within this repository, which makes updating as simple as the following lines. The function only needs a specification of the new standard which is to be inserted. If, for example, we wish to insert a new Machine Learning standard between **ML4.7** and **ML4.8**, then the new standard would be **ML4.8**, because **ML4.7** would remain the same, whereas all former standards from **ML4.8** onwards would need to be increment by one, to become **ML4.9** and so on. The script contains a single function which increment all standards beyond the desired new standard, so that a new standard can then simply be inserted at the nominated location.

``` r
source ("increment.R")
increment_standards ("ML4.8")
```

That command will increment standards in the `standards/*.Rmd` documents, which will no longer have or refer to a standard named **ML4.8**, leaving you free to insert your desired new standard in any of the source documents in the [`standards` directory](https://github.com/mpadge/hackmd-stat-software/tree/master/standards). Please ensure that you do that in the **RMarkdown (`.Rmd`)** and not the markdown (`.md`) versions. Please make a pull request to this repo with your changes.

### Optional Extra: Propagate Changes and Pull Request

You may also propagate any changes made to `.Rmd` documents across to both the markdown (`.md`) sources used for the [`hackmd` documents](https://hackmd.io/@stat-software), as well as the mirrored `.Rmd` sources used in the [official bookdown document](https://ropenscilabs.github.io/statistical-software-review-book/standards.html). That may be done by simply running `make` within the root of this repository, prior to which you'll just need to update the `COPYDEST` variable in the [`makefile`](https://github.com/mpadge/hackmd-stat-software/blob/master/makefile). Once you've done that, please make pull requests both to this repository and the [bookdown source](https://github.com/ropenscilabs/statistical-software-peer-review).

