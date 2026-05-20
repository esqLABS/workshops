# Batch-render PAGE 2026 certificates from an attendee list.
#
# Usage: Rscript agendas/PAGE_2026_certificate_batch.R agendas/PAGE_2026_attendees.csv
# CSV must have a column 'name'.

args <- commandArgs(trailingOnly = TRUE)
attendees_csv <- if (length(args) >= 1) args[1] else "agendas/PAGE_2026_attendees.csv"

# Mode 1 (parent): iterate attendees, spawn a child Rscript per attendee.
# Mode 2 (child):  invoked with --render "<name>" "<date>"; renders one PDF.
if (length(args) >= 3 && args[1] == "--render") {
  attendee_name <- args[2]
  event_date    <- args[3]

  template <- "agendas/PAGE_2026_certificate_template.qmd"
  safe     <- gsub("[^A-Za-z0-9]+", "_", attendee_name)
  out_name <- paste0("Certificate_", safe, ".pdf")

  # quarto_render's `output_file` accepts a bare filename only.
  quarto::quarto_render(
    input          = template,
    execute_params = list(attendee_name = attendee_name, date = event_date),
    output_file    = out_name,
    quiet          = TRUE
  )

  # Locate rendered file (Quarto website project writes to _site/).
  candidates <- c(
    file.path("_site", dirname(template), out_name),
    file.path(dirname(template), out_name)
  )
  rendered <- NULL
  for (p in candidates) if (file.exists(p)) { rendered <- p; break }
  if (is.null(rendered)) stop("Rendered PDF not found: ", out_name)

  out_dir <- "agendas/certificates"
  dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
  file.rename(rendered, file.path(out_dir, out_name))
  quit(save = "no", status = 0)
}

# Parent mode -------------------------------------------------------------

if (!file.exists(attendees_csv)) {
  stop("Attendees CSV not found: ", attendees_csv,
       "\nCreate one with a column 'name'.")
}

attendees <- read.csv(attendees_csv, stringsAsFactors = FALSE, fileEncoding = "UTF-8")
stopifnot("name" %in% names(attendees))

event_date  <- "01 June 2026"
this_script <- "agendas/PAGE_2026_certificate_batch.R"
rscript_bin <- file.path(R.home("bin"), "Rscript")

for (n in attendees$name) {
  message("Rendering: ", n)
  status <- system2(
    rscript_bin,
    args = c(shQuote(this_script), "--render", shQuote(n), shQuote(event_date)),
    stdout = "", stderr = ""
  )
  if (status != 0) stop("Subprocess failed for: ", n, " (status ", status, ")")
}

message("\nDone. ", nrow(attendees), " PDFs in agendas/certificates/")
