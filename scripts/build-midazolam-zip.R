#!/usr/bin/env Rscript
# Build the shippable Midazolam-PAGE.zip for workshop attendees.
# Run from the repo root: `Rscript scripts/build-midazolam-zip.R`

here::i_am("scripts/build-midazolam-zip.R")

projects_dir <- here::here("workshops", "resources", "projects")
project_dir  <- file.path(projects_dir, "Midazolam-PAGE")
zip_path     <- file.path(projects_dir, "Midazolam-PAGE.zip")

if (!dir.exists(project_dir)) {
  stop("Midazolam-PAGE/ not found at: ", project_dir)
}
if (file.exists(zip_path)) {
  unlink(zip_path)
}

old_wd <- setwd(projects_dir)
on.exit(setwd(old_wd), add = TRUE)

utils::zip(
  zipfile = "Midazolam-PAGE.zip",
  files   = "Midazolam-PAGE",
  flags   = "-r9X"
)

size_mb <- round(file.info(zip_path)$size / 1024^2, 2)
message(sprintf("Built %s (%.2f MB)", zip_path, size_mb))
