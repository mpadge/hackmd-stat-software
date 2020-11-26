#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

if (length (args) != 1)
      stop("Only one argument may be supplied", call. = FALSE)

add_section_nums <- function (x) {

    index1 <- grep ("^=+$", x) - 1
    index2 <- grep ("^-+$", x) - 1
    index2 <- index2 [- (1:2)] # rm yaml header dashes
    index2 <- index2 [which (x [index2] != "")] # remove simple separator lines

    index <- sort (c (index1, index2))
    numbers <- rep (NA_character_, length (index))
    numbers [which (index %in% index1)] <- seq_along (index1)
    numbers <- data.frame (n1 = zoo::na.locf (numbers),
                           index = index)

    numbers <- lapply (split (numbers, f = factor (numbers$n1)),
                       function (i) {
                           i$n2 <- paste0 (".", seq (nrow (i)) - 1)
                           i$n2 [1] <- paste0 ("")
                           return (i)   })
    numbers <- unname (apply (do.call (rbind, numbers),
                              1,
                              function (i)
                                  paste0 (i [1], i [3])))

    numbers1 <- numbers [which (index %in% index1)]
    x [index1] <- paste0 ("# ", numbers1, " ", x [index1])
    numbers2 <- numbers [which (index %in% index2)]
    x [index2] <- paste0 ("## ", numbers2, " ", x [index2])

    x <- x [- (index + 1)]

    return (x)
}

write_md <- function (file) {

    # Get the first 3 lines of the header to propagate to the .md:
    x <- readLines (file)
    index <- grep ("^-+$", x) [1:2]
    hdr <- x [c (index [1] + 0:3, index [2])]

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

    x <- c (hdr, "", "", readLines (file))

    x <- add_section_nums (x)

    con <- file (file, "w")
    writeLines (x, con)
    close (con)
}

#file <- "standards.Rmd"
write_md (args [1])
