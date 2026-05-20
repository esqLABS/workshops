#!/usr/bin/env Rscript
# Build the shippable Midazolam-PAGE.zip for workshop attendees.
# Run from anywhere: `Rscript scripts/build-midazolam-zip.R`

# Resolve script location so paths work regardless of cwd
script_path <- (function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
  if (length(file_arg) > 0) return(normalizePath(file_arg, mustWork = TRUE))
  if (!is.null(sys.frames()[[1]]$ofile)) return(normalizePath(sys.frames()[[1]]$ofile))
  normalizePath("scripts/build-midazolam-zip.R")
})()
repo_root    <- dirname(dirname(script_path))
projects_dir <- file.path(repo_root, "workshops", "resources", "projects")
project_dir  <- file.path(projects_dir, "Midazolam-PAGE")
zip_path     <- file.path(projects_dir, "Midazolam-PAGE.zip")

if (!dir.exists(project_dir)) {
  stop("Midazolam-PAGE/ not found at: ", project_dir)
}
if (!requireNamespace("zip", quietly = TRUE)) {
  stop(
    "The {zip} R package is required. Install it with:\n",
    "  install.packages(\"zip\")"
  )
}
if (file.exists(zip_path)) unlink(zip_path)

old_wd <- setwd(projects_dir)
on.exit(setwd(old_wd), add = TRUE)

zip::zip(
  zipfile     = "Midazolam-PAGE.zip",
  files       = "Midazolam-PAGE",
  recurse     = TRUE,
  compression_level = 9
)

if (!file.exists(zip_path)) stop("zip build failed: no archive at ", zip_path)
size_mb <- round(file.info(zip_path)$size / 1024^2, 2)
message(sprintf("Built %s (%.2f MB)", zip_path, size_mb))
