# Smoke test for the Midazolam-PAGE workshop project.
#
# Walks the full esqlabsR pipeline end-to-end:
#   1. Load the project configuration.
#   2. Load + run all scenarios defined in Scenarios.xlsx.
#   3. Render all plot grids defined in Plots.xlsx against the observed data.
#
# Pass: every scenario runs, every plot renders.
# Use after editing Scenarios.xlsx / Plots.xlsx / Models/Simulations/ to
# confirm the project is still self-consistent.
#
# Usage (from repo root):
#   Rscript workshops/resources/projects/Midazolam-PAGE/tests/test_project.R
#
# Override the project location:
#   Rscript ... [path-to-ProjectConfiguration.xlsx]

suppressPackageStartupMessages({
  library(esqlabsR)
  library(here)
})

# Resolve project file ----------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
project_file <- if (length(args) >= 1) {
  args[1]
} else {
  here(
    "workshops", "resources", "projects", "Midazolam-PAGE",
    "ProjectConfiguration.xlsx"
  )
}

if (!file.exists(project_file)) {
  stop("ProjectConfiguration.xlsx not found at:\n  ", project_file)
}

step <- function(msg) cat("[", format(Sys.time(), "%H:%M:%S"), "] ", msg, "\n", sep = "")

# 1. Load project configuration ------------------------------------------
step("Loading project configuration ...")
project <- createProjectConfiguration(projectConfigurationFile = project_file)
cat("  ModelsFolder:        ", project$paths$ModelsFolder, "\n")
cat("  ConfigurationsFolder:", project$paths$ConfigurationsFolder, "\n")
cat("  DataFolder:          ", project$paths$DataFolder, "\n")

# 2. Load + run all scenarios --------------------------------------------
step("Reading Scenarios.xlsx ...")
scenarios_xlsx <- file.path(project$paths$ConfigurationsFolder, "Scenarios.xlsx")
if (!file.exists(scenarios_xlsx)) {
  stop("Scenarios.xlsx not found at:\n  ", scenarios_xlsx)
}

scenario_names <- readxl::read_excel(scenarios_xlsx, sheet = "Scenarios")$Scenario
scenario_names <- scenario_names[!is.na(scenario_names) & nzchar(scenario_names)]
cat("  Found", length(scenario_names), "scenario(s):\n")
cat(paste0("    - ", scenario_names, collapse = "\n"), "\n")

step("Reading scenario configuration from Excel ...")
scenarioConfig <- readScenarioConfigurationFromExcel(
  scenarioNames        = scenario_names,
  projectConfiguration = project
)

step("Building Scenario objects ...")
scenarios <- createScenarios(scenarioConfig)

step("Running scenarios ...")
scenario_results <- runScenarios(scenarios = scenarios)
cat("  Ran", length(scenario_results), "scenario(s) successfully.\n")

# 3. Render all plot grids -----------------------------------------------
step("Reading Plots.xlsx ...")
plots_xlsx <- file.path(project$paths$ConfigurationsFolder, "Plots.xlsx")
if (!file.exists(plots_xlsx)) {
  stop("Plots.xlsx not found at:\n  ", plots_xlsx)
}

plot_grid_names <- readxl::read_excel(plots_xlsx, sheet = "plotGrids")$name
plot_grid_names <- unique(plot_grid_names[!is.na(plot_grid_names) & nzchar(plot_grid_names)])
cat("  Found", length(plot_grid_names), "plot grid(s):\n")
cat(paste0("    - ", plot_grid_names, collapse = "\n"), "\n")

step("Rendering plots ...")
plots <- createPlotsFromExcel(
  plotGridNames        = plot_grid_names,
  simulatedScenarios   = scenario_results,
  projectConfiguration = project
)
cat("  Rendered", length(plots), "plot grid(s) successfully.\n")

step("✅ All scenarios + plots OK.")

# Optional: drop one quick-look PNG per grid for visual inspection -------
out_dir <- here(
  "workshops", "resources", "projects", "Midazolam-PAGE",
  "Results", "test_renders"
)
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

for (grid_name in names(plots)) {
  out_file <- file.path(out_dir, paste0(grid_name, ".png"))
  ggplot2::ggsave(
    out_file, plot = plots[[grid_name]],
    width = 8, height = 5, dpi = 150
  )
  cat("  Saved:", out_file, "\n")
}
