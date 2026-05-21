# PAGE 2026 — Block 5b hands-on (optional / fast finishers)
# Goal: Parameter identification on the Midazolam-PAGE esqlabsR project.
#       Reuse existing scenarios + observed data; fit shared Lipophilicity
#       and CYP3A4_kcat to PO 7.5 mg + IV 2 mg plasma curves.
# Time: ~15 min
#
# Source module: workshops/C1-Parameter-Identification.qmd

library(esqlabsR)
library(ospsuite)
library(ospsuite.parameteridentification)
library(here)

PROJECT_DIR <- here("workshops/resources/projects/Midazolam-PAGE")

# 1. Project + scenarios (same as Block 4 / 5) ---------------------------
project <- createProjectConfiguration(
  file.path(PROJECT_DIR, "ProjectConfiguration.xlsx")
)

cfg <- readScenarioConfigurationFromExcel(
  scenarioNames = c("Midazolam_PO_7.5mg", "Midazolam_IV_2mg"),
  projectConfiguration = project
)
scenarios <- createScenarios(cfg)

sim_PO <- scenarios$Midazolam_PO_7.5mg$simulation
sim_IV <- scenarios$Midazolam_IV_2mg$simulation

# 2. Observed data — same loader used in Block 4b ------------------------
# Sheets must exist in Data/Midazolam_obs.xlsx.
obsData <- loadObservedData(
  projectConfiguration = project,
  sheets = c("Olkkola 1994", "Link 2008")
)

# 3. PI parameters -------------------------------------------------------
# Lipophilicity — shared across both scenarios (one optimised value)
piParameterLipo <- PIParameters$new(
  parameters = list(
    getParameter("Midazolam|Lipophilicity", container = sim_PO),
    getParameter("Midazolam|Lipophilicity", container = sim_IV)
  )
)
piParameterLipo$minValue <- -2
piParameterLipo$maxValue <- 6

# CYP3A4 kcat — shared (metabolism doesn't depend on route)
piParameterKcat <- PIParameters$new(
  parameters = list(
    getParameter("Midazolam-CYP3A4-Optimized|kcat", container = sim_PO),
    getParameter("Midazolam-CYP3A4-Optimized|kcat", container = sim_IV)
  )
)
piParameterKcat$minValue <- 0.1
piParameterKcat$maxValue <- 100

# 4. Output mappings — sim quantity ↔ observed dataset -------------------
plasmaPath <- "Organism|PeripheralVenousBlood|Midazolam|Plasma (Peripheral Venous Blood)"

outputMapping_PO <- PIOutputMapping$new(
  quantity = getQuantity(plasmaPath, container = sim_PO)
)
outputMapping_PO$addObservedDataSets(
  obsData$`Olkkola 1994_Midazolam_Olkkola 1994 - po Control (Perpetrator Placebo) - Midazolam - PO - 7.5 mg - Plasma - agg. (n=9)_Human__Peripheral Venous Blood_Plasma_7.5 mg_PO_po Control (Perpetrator Placebo)`
)
outputMapping_PO$scaling <- "log"

outputMapping_IV <- PIOutputMapping$new(
  quantity = getQuantity(plasmaPath, container = sim_IV)
)
# Pick the Link 2008 IV entry from obsData (key follows the importer naming pattern)
linkKey <- grep("^Link 2008", names(obsData), value = TRUE)[1]
outputMapping_IV$addObservedDataSets(obsData[[linkKey]])
outputMapping_IV$scaling <- "log"

# 5. Build + run PI task -------------------------------------------------
piConfiguration <- PIConfiguration$new()

piTask <- ParameterIdentification$new(
  simulations = list(sim_PO, sim_IV),
  parameters = list(piParameterLipo, piParameterKcat),
  outputMappings = list(outputMapping_PO, outputMapping_IV),
  configuration = piConfiguration
)

# Starting fit (before optimisation)
piTask$plotResults()

piResults <- piTask$run()
print(piResults)

# 6. Inspect estimates + CIs --------------------------------------------
piResults$toDataFrame()[, c(
  "name",
  "estimate",
  "lowerCI",
  "upperCI",
  "cv",
  "ciType"
)]

# Optimised fit vs observed
piTask$plotResults()

# 7. Try-it-yourself -----------------------------------------------------
# A. Switch to global optimiser (DEoptim):
#      piConfiguration$algorithm        <- "DEoptim"
#      deOpts                <- AlgorithmOptions_DEoptim
#      deOpts$itermax        <- 20
#      deOpts$NP             <- 15
#      deOpts$storepopfrom   <- 21
#      piConfiguration$algorithmOptions <- deOpts
#      piTask$run()
#
# B. Per-parameter OFV profile — local identifiability check:
#      piTask$calculateOFVProfiles(totalEvaluations = 20)
#
# C. Joint grid search — detect multimodality + warm-start:
#      piTask$gridSearch(totalEvaluations = 50, setStartValue = TRUE)
