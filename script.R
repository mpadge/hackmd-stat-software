#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

if (length (args) != 2)
      stop("Two arguments must be supplied", call. = FALSE)

add_section_nums <- function (x) {
    #index1 <- grep ("^\\#\\s", x)
    #if (length (index1) > 0)
    #    stop ("These documents should not have primary sections")
    #index2 <- grep ("^\\#\\#\\s", x)
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

write_md <- function (file, demo) {

    file <- paste0 (tools::file_path_sans_ext (file), ".Rmd")
    # This should produce ATX-style headers, but doesn't:
    #pa <- rmarkdown::pandoc_options (
    #                                 to = "gfm",
    #                                 args = "--atx-headers")
    #of <- rmarkdown::output_format (knitr = rmarkdown::knitr_options (),
    #                                pandoc = pa)
    #rmarkdown::render (file,
    #                   output_format = of)
    rmarkdown::render (file,
                       rmarkdown::md_document(variant = "gfm"))
    file <- paste0 (tools::file_path_sans_ext (file), ".md")

    title <- strsplit (tools::file_path_sans_ext (file),
                       .Platform$file.sep) [[1]] [2]
    if (title == "eda")
        title <- "Exploratory Data Analysis Software"
    else if (title == "eda-demos")
        title <- "EDA demos"
    else if (title == "unsupervised")
        title <- "Unsupervised Learning Software Standards"
    else if (title == "ml")
        title <- "Machine Learning Software Standards"
    else if (tolower (demo) == "false") {
        words <- strsplit (title, "-") [[1]]
        words <- vapply (words, function (i)
                         paste0 (toupper (substr (i, 1, 1)), substring (i, 2)),
                         character (1), USE.NAMES = FALSE)
        title <- paste0 (paste0 (words, collapse = " "), " Software Standards")
    }

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

write_md (args [1], args [2])
