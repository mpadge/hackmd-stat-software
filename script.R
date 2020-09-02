#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

if (length (args) != 2) 
      stop("Two arguments must be supplied", call.=FALSE)

write_md <- function (file, title, demo){

    file <- paste0 (tools::file_path_sans_ext (file), ".Rmd")
    rmarkdown::render (file,
                       rmarkdown::md_document(variant='gfm'))
    file <- paste0 (tools::file_path_sans_ext (file), ".md")

    if (title == "unsupervised")
        title <- "Unsupervised Learning Software"
    else if (title == "regression")
        title <- "Regression Software"
    
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
    con <- file (file, "w")
    writeLines (x, con)
    close (con)
}
#write_md ("time-series-demos.Rmd", "time-series-demos")
write_md (paste0 (args [1], ".Rmd"), args [1], args [2])
