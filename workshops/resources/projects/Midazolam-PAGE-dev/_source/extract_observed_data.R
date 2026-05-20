# Extract observed data from the OSP Midazolam-Model.json snapshot
# into Excel files compatible with the {esqlabsR} dataImporter.
#
# Source: github.com/Open-Systems-Pharmacology/Midazolam-Model (GPLv2)
# Output:
#   workshops/resources/projects/Midazolam-PAGE/Data/Midazolam_obs_full.xlsx
#   workshops/resources/projects/Midazolam-PAGE/Data/Midazolam_obs.xlsx
#
# Sheet structure mirrors the TestProject_TimeValuesData.xlsx layout
# (loadable via esqlabs_dataImporter_configuration.xml):
#
#   Study Id | Subject Id | Organ | Compartment | Species | Gender |
#   Dose | Molecule | Molecular Weight | Time | Time unit |
#   Measurement | Measurement unit | Error | LLOQ | Route | Group Id
#
# One sheet per study (Study Id).

library(jsonlite)
library(dplyr)
library(writexl)
library(here)

SNAPSHOT <- here(
  "workshops/resources/projects/Midazolam-PAGE/_source/Midazolam-Model/Midazolam-Model.json"
)
OUT_DIR <- here("workshops/resources/projects/Midazolam-PAGE/Data")
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

json <- fromJSON(SNAPSHOT, simplifyVector = FALSE)

# Null-coalesce helper (R 4.4+ has it built-in; safe re-definition)
`%||%` <- function(a, b) if (is.null(a)) b else a

# Helper: pull metadata field from ExtendedProperties
get_prop <- function(obs, name) {
  for (p in obs$ExtendedProperties) {
    if (p$Name == name) return(p$Value)
  }
  NA
}

# Excel sheet names: max 31 chars, no `: \ / ? * [ ]`
sanitize_sheet <- function(s) {
  s <- gsub("[:\\\\/\\?\\*\\[\\]]", "_", s)
  substr(s, 1L, 31L)
}

# Build one data frame per observed dataset, esqlabsR-style schema.
obs_rows <- lapply(json$ObservedData, function(o) {
  times <- unlist(o$BaseGrid$Values)
  vals  <- unlist(o$Columns[[1]]$Values)
  n     <- min(length(times), length(vals))
  if (n == 0L) return(NULL)
  times <- times[seq_len(n)]
  vals  <- vals[seq_len(n)]

  data.frame(
    `Study Id`           = get_prop(o, "Study Id"),
    `Subject Id`         = o$Name,
    Organ                = get_prop(o, "Organ"),
    Compartment          = get_prop(o, "Compartment"),
    Species              = get_prop(o, "Species"),
    Gender               = NA_character_,
    Dose                 = get_prop(o, "Dose"),
    Molecule             = get_prop(o, "Molecule"),
    `Molecular Weight`   = o$Columns[[1]]$DataInfo$MolWeight %||% NA_real_,
    Time                 = times,
    `Time unit`          = o$BaseGrid$Unit %||% NA_character_,
    Measurement          = vals,
    `Measurement unit`   = o$Columns[[1]]$Unit %||% NA_character_,
    Error                = NA_real_,
    LLOQ                 = NA_real_,
    Route                = get_prop(o, "Route"),
    `Group Id`           = get_prop(o, "Grouping") %||% NA_character_,
    check.names          = FALSE,
    stringsAsFactors     = FALSE
  )
})

obs_long <- bind_rows(obs_rows)

cat("Extracted",
    length(unique(obs_long$`Subject Id`)), "datasets across",
    length(unique(obs_long$`Study Id`)),   "studies,",
    nrow(obs_long), "observations.\n\n")

# Group by Study Id → one sheet per study --------------------------------
write_studies_xlsx <- function(df, path) {
  studies <- split(df, df$`Study Id`)
  names(studies) <- vapply(names(studies), sanitize_sheet, character(1))
  write_xlsx(studies, path = path)
  cat("Wrote", length(studies), "sheets ->", path, "\n")
}

# Full export — every study
write_studies_xlsx(
  obs_long,
  path = file.path(OUT_DIR, "Midazolam_obs_full.xlsx")
)

# Workshop-curated subset (matches the studies referenced in workshop materials)
keep <- c(
  "Allonen 1981",
  "Olkkola 1994", "Olkkola 1996",
  "Saari 2006",
  "Link 2008",
  "Backman 1994", "Backman 1996",
  "Bornemann 1986",
  "Heizmann 1983",
  "Darwish 2008",
  "Smith 1981",
  "Kharasch 1997",
  "Hohmann 2015"
)

curated <- obs_long %>%
  filter(`Study Id` %in% keep) %>%
  arrange(`Study Id`, `Subject Id`, Time)

write_studies_xlsx(
  curated,
  path = file.path(OUT_DIR, "Midazolam_obs.xlsx")
)

cat("\nDone. Load in R via:\n")
cat('  loadDataSetsFromExcel(\n')
cat('    xlsFilePath               = "Data/Midazolam_obs.xlsx",\n')
cat('    importerConfigurationOrPath = "Data/esqlabs_dataImporter_configuration.xml"\n')
cat('  )\n')
