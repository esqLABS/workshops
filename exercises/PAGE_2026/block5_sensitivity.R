# PAGE 2026 — Block 5 hands-on
# Goal: Multi-factor SA on Midazolam, generate spider + tornado plots.
# Time: 20 min

library(esqlabsR)
library(here)

PROJECT_DIR <- here("workshops/resources/projects/Midazolam-PAGE")

project <- createProjectConfiguration(
  file.path(PROJECT_DIR, "ProjectConfiguration.xlsx")
)

# 1. Build scenario + grab the underlying simulation ---------------------
cfg <- readScenarioConfigurationFromExcel(
  scenarioNames = "Midazolam_PO_7.5mg",
  projectConfiguration = project
)
scenarios <- createScenarios(cfg)
simulation <- scenarios$Midazolam_PO_7.5mg$simulation

# 2. Define output + parameter paths -------------------------------------
outputPaths <- c(
  Plasma = "Organism|PeripheralVenousBlood|Midazolam|Plasma (Peripheral Venous Blood)"
)

# HINT: ospsuite::getAllParameterPathsIn(simulation) lists every parameter path
parameterPaths <- c(
  Lipophilicity = "Midazolam|Lipophilicity",
  CYP3A4_kcat = "Midazolam-CYP3A4-Optimized|kcat",
  GFR_fraction = "Neighborhoods|Kidney_pls_Kidney_ur|Midazolam|Glomerular Filtration-Optimized-Midazolam|GFR fraction"
)

# 3. Run sensitivity calculation -----------------------------------------
# HINT: analysis <- sensitivityCalculation(
#         simulation     = simulation,
#         outputPaths    = outputPaths,
#         parameterPaths = parameterPaths,
#         variationRange = c(0.1, 0.5, 1, 2, 10),
#         pkParameters   = c("C_max", "AUC_inf"))
# YOUR CODE:

# 4. Inspect the data ----------------------------------------------------
# YOUR CODE: head(analysis$pkData)

# 5. Spider + tornado plots ----------------------------------------------
# HINT: sensitivitySpiderPlot(analysis); sensitivityTornadoPlot(analysis)
# YOUR CODE:

# 6. Persist results ----------------------------------------------------
# HINT: saveSensitivityCalculation(analysis, outputDir = file.path(project$outputFolder, "SA_Midazolam"))
# YOUR CODE:
