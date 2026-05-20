# Remove stale .quarto/quarto-session-temp* directories before rendering.
# Quarto leaves these behind when a render is killed / interrupted; on the
# next render its glob walker hits a missing inode and errors with
#   "NotFound: The system cannot find the file specified. (os error 2)"
#
# Wired as a project pre-render hook in _quarto.yml.

dot_quarto <- ".quarto"
if (dir.exists(dot_quarto)) {
  stale <- list.files(
    dot_quarto,
    pattern    = "^quarto-session-temp",
    full.names = TRUE,
    include.dirs = TRUE
  )
  for (d in stale) {
    unlink(d, recursive = TRUE, force = TRUE)
    message("Removed stale: ", d)
  }
}
