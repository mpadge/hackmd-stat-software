#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if (length (args) != 2) 
      stop("Two arguments must be supplied", call.=FALSE)

add_section_nums <- function (x) {
    index1 <- grep ("^\\#\\s", x)
    #if (length (index1) > 0)
    #    stop ("These documents should not have primary sections")
    index2 <- grep ("^\\#\\#\\s", x)
    #if (length (index2) > 1)
    #    stop ("These documents should only have one single secondary section")

    # comments in code chunks will be part of index1, index2, and this whole
    # thing works on the assumption that no code chunk comments will ever have
    # "###" or "####" at the start of lines.

    index3 <- grep ("^\\#\\#\\#\\s", x)
    index4 <- grep ("^\\#\\#\\#\\#\\s", x)

    sec3 <- paste0 (seq_along (index3))

    # need unique in breaks in case final index3 == length(x)
    sec4 <- cut (index4,
                 breaks = unique (c (index3, length (x))),
                 labels = FALSE)
    sec4 <- lapply (split (sec4, f = factor (sec4)), function (i)
                    seq_along (i))
    for (i in seq_along (sec4))
        sec4 [[i]] <- paste0 (names (sec4) [i], ".", sec4 [[i]])
    sec4 <- unlist (sec4)

    for (i in seq_along (sec3)) {
        x [index3 [i]] <- gsub ("^\\#\\#\\#\\s",
                                paste0 ("### ", sec3 [i], " "),
                                x [index3 [i]])
    }

    for (i in seq_along (sec4)) {
        x [index4 [i]] <- gsub ("^\\#\\#\\#\\#\\s",
                                paste0 ("#### ", sec4 [i], " "),
                                x [index4 [i]])
    }

    return (x)
}

write_md <- function (file, title, demo){

    file <- paste0 (tools::file_path_sans_ext (file), ".Rmd")
    rmarkdown::render (file,
                       rmarkdown::md_document(variant='gfm'))
    file <- paste0 (tools::file_path_sans_ext (file), ".md")

    if (title == "standards/bayesian")
        title <- "Bayesian Software"
    else if (title == "standards/eda")
        title <- "Exploratory Data Analysis Software"
    else if (title == "standards/general")
        title <- "General Standards"
    else if (title == "standards/regression")
        title <- "Regression Software"
    else if (title == "standards/time-series")
        title <- "Time Series Software"
    else if (title == "standards/unsupervised")
        title <- "Unsupervised Learning Software"
    else if (title == "standards/ml")
        title <- "Machine Learning Software"
    
    if (tolower (demo) == "true")
        tags <- "tags: statistical-software-demos, statistical-software"
    else
        tags <- "tags: statistical-software"

    x <- readLines (file)

    x <- c ("---",
            paste0 ("title: ", title),
            tags,
            "robots: noindex, nofollow",
            "---",
            "",
            "",
            x)

    x <- add_section_nums (x)

    con <- file (file, "w")
    writeLines (x, con)
    close (con)
}

write_md (paste0 (args [1], ".Rmd"), args [1], args [2])
