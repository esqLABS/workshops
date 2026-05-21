# PAGE 2026 — Block 4b hands-on
# Goal: Build a DataCombined + 2 plotConfigurations + 1 plotGrid in ESQapp,
#       then render in R.
# Time: 20 min

library(esqlabsR)
library(here)

PROJECT_DIR <- here("workshops/resources/projects/Midazolam-PAGE")

project <- createProjectConfiguration(
  file.path(PROJECT_DIR, "ProjectConfiguration.xlsx")
)

# 1. In ESQapp, on the Midazolam-PAGE project ----------------------------
#
# Plots > DataCombined: create 'Midazolam_PO_15mg_DC' with these rows:
#
#   Simulated rows (scenario = Midazolam_PO_15mg):
#     - path:  Organism|PeripheralVenousBlood|Midazolam|Plasma (Peripheral Venous Blood)
#       group: PVB     label: Sim PVB
#     - path:  Organism|Fat|Intracellular|Midazolam|Concentration in container
#       group: Fat     label: Sim Fat
#
#   Observed row (linked to PVB group):
#     - dataSet: Backman 1994 placebo (from Data/Midazolam_obs.xlsx)
#       group:   PVB    label: Backman 1994
#
# Plots > plotConfiguration:
#     - Midazolam_PO_15mg_Time   dataCombined=Midazolam_PO_15mg_DC  plotType=individual       yAxisScale=log  xUnit=h
#     - Midazolam_PO_15mg_Res    dataCombined=Midazolam_PO_15mg_DC  plotType=residualsVsTime  xUnit=h
#
# Plots > plotGrids:
#     - Midazolam_PO_15mg   plotIDs=Midazolam_PO_15mg_Time, Midazolam_PO_15mg_Res
#
# Save.

# 2. Pull the ESQapp edits back into R -----------------------------------
restoreProjectConfiguration(file.path(PROJECT_DIR, "ProjectConfiguration.json"))

# 3. Re-run the scenario --------------------------------------------------
cfg <- readScenarioConfigurationFromExcel(
  scenarioNames = "Midazolam_PO_15mg",
  projectConfiguration = project
)
scenarios <- createScenarios(cfg)
results <- runScenarios(scenarios = scenarios)

# 4. Load observed data ---------------------------------------------------
# HINT: observedData <- loadObservedData(
#         projectConfiguration = project,
#         sheets               = c("Backman 1994"))
# YOUR CODE:

# 5. Render the plot grid -------------------------------------------------
# HINT: plots <- createPlotsFromExcel(
#         plotGridNames        = "Midazolam_PO_15mg",
#         simulatedScenarios   = results,
#         observedData         = observedData,
#         projectConfiguration = project)
# YOUR CODE:

# 6. View ----------------------------------------------------------------
# YOUR CODE:
