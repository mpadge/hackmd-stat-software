#' Insert a new standard number, and update all old numbers throughout all other
#' documents.
#'
#' @param s Single character specifying standard to be inserted. All standards
#' following the specified number will be incremented.
#'
#' @note Standards are named as follows, where "X.X" denotes two one- or
#' two-digit numbers:
#' \itemize{
#' \item GX.X General
#' \item BSX.X Bayesian
#' \item REX.X Regression
#' \item ULX.X Unsupervised Learning
#' \item EAX.X Exploratory Data Analysis (EDA)
#' \item TSX.X Time Series
#' \item MLX.X Machine Learning
#' }
#'
#' @example
#' \dontrun{
#' increment_standards ("G4.1")
#' }
#' @export
increment_standards <- function (s) {
    prfx <- toupper (gsub ("[0-9]+\\.[0-9]+([a-z]?)", "", s))
    prfxs <- c ("G", "BS", "RE", "UL", "EA", "TS", "ML")
    prfx <- match.arg (prfx, prfxs)

    standards <- list.files (file.path ("standards"),
                             full.names = TRUE,
                             pattern = "\\.Rmd$")

    for (i in standards)
        increment1 (i, s, prfx)
}

increment1 <- function (standard, s, prfx) {
    x0 <- readLines (standard)

    # get all numbers to be affected by increment
    st_start <- paste0 ("^\\-\\s+\\*\\*", prfx)
    index1 <- grep (st_start, x0)
    numbers <- gsub ("\\*\\*.*$", "", gsub (st_start, "", x0 [index1]))
    nbig <- as.integer (gsub ("\\..*$", "", numbers))
    nsmall <- as.integer (gsub ("^[0-9]+\\.", "", numbers))

    nbig_new <- as.integer (gsub ("^[A-Z]+|\\..*$", "", s))
    nsmall_new <- as.integer (gsub (".*\\.", "", s))

    index2 <- which (nbig == nbig_new & nsmall >= nsmall_new)
    old_standards <- paste0 ("**", prfx,
                             nbig [index2], ".", nsmall [index2])
    new_standards <- paste0 ("**", prfx,
                             nbig [index2], ".", nsmall [index2] + 1)

    old_standards <- rev (old_standards)
    new_standards <- rev (new_standards)

    x <- x0
    for (i in seq_along (old_standards))
        x <- gsub (old_standards [i], new_standards [i], x, fixed = TRUE)

    if (!identical (x0, x)) {
        writeLines (x, con = standard)
        cli::cli_alert_success (paste0 ("Incremented ", standard))
    }
}

standard_name <- function (prfx) {
    prfxs <- c ("G", "BS", "RE", "UL", "EA", "TS", "ML")
    standards <- c ("general", "bayesian", "regression", "unsupervised",
                    "eda", "time-series", "ml")
    return (standards [match (prfx, prfxs)])
}
