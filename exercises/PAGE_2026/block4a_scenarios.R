# PAGE 2026 — Block 4a hands-on
# Goal: Build a new Midazolam scenario from scratch in ESQapp, then run it.
# Time: 30 min

library(esqlabsR)
library(here)

PROJECT_DIR <- here("workshops/resources/projects/Midazolam-PAGE")

project <- createProjectConfiguration(
  file.path(PROJECT_DIR, "ProjectConfiguration.xlsx")
)

# 1. Build the scenario in ESQapp -----------------------------------------
#    Open the Midazolam-PAGE project in ESQapp and create a new scenario:
#
#      • Model file:               Midazolam_PO_7.5mg.pkml
#      • Administration protocol:  new protocol, dose = 15 mg (rest like 7.5 mg)
#      • Individual:               new individual — e.g. female, Black American
#                                  (pick the matching population)
#      • Simulation time:          0–2 h  at 60 pts/h
#                                  2–24 h at 10 pts/h
#      • Outputs:                  Concentration of Midazolam in fat -> intracellular
#
#    Save. Choose a scenario name, e.g. "Midazolam_PO_15mg".

SCENARIO <- "Midazolam_PO_15mg"

# 2. Reload scenario configuration from the updated Excel -----------------
# HINT:
#   cfg <- readScenarioConfigurationFromExcel(
#            scenarioNames        = SCENARIO,
#            projectConfiguration = project)
#   scenarios <- createScenarios(cfg)

# YOUR CODE:

# 3. Run the scenario -----------------------------------------------------
# HINT: results <- runScenarios(scenarios = scenarios)

# YOUR CODE:

# 4. Verify the result ----------------------------------------------------
# HINT: outputVals <- results[[SCENARIO]]$outputValues

# YOUR CODE:
