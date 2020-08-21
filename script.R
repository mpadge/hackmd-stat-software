write_md <- function (file, title){
    file <- paste0 (tools::file_path_sans_ext (file), ".Rmd")
    rmarkdown::render (file,
                       rmarkdown::md_document(variant='gfm'))
    file <- paste0 (tools::file_path_sans_ext (file), ".md")
    x <- readLines (file)
    x <- c ("---",
            paste0 ("title: ", title),
            "tags: statistical-software-demos, statistical-software",
            "robots: noindex, nofollow",
            "---",
            "",
            "",
            x)
    con <- file (file, "w")
    writeLines (x, con)
    close (con)
}
write_md ("regression-demos.Rmd", "regression-demos")
