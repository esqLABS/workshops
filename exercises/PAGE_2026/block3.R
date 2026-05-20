# PAGE 2026 — Block 3 hands-on
# Goal: Local sensitivity analysis on Aciclovir
# Time: 15 min

library(ospsuite)

sim_path <- system.file("extdata", "Aciclovir.pkml", package = "ospsuite")
sim <- loadSimulation(sim_path)


# 1. Run a local SA on Lipophilicity + GFR fraction -----------------------
# HINT:
#   gfrPath <- "Neighborhoods|Kidney_pls_Kidney_ur|Aciclovir|Glomerular Filtration-GFR-Aciclovir|GFR fraction"
#
#   sa <- SensitivityAnalysis$new(
#     simulation     = sim,
#     parameterPaths = c("Aciclovir|Lipophilicity", gfrPath)
#   )
#   sa$variationRange <- 0.1   # ±10 %
#
#   saResult <- runSensitivityAnalysis(sa)

# YOUR CODE:


# 2. Identify the top driver of AUC_inf ----------------------------------
# HINT: SensitivityAnalysisResults exposes
#   saResult$allPKParameterSensitivitiesFor(
#     pkParameterName           = "AUC_inf",
#     outputPath                = "Organism|PeripheralVenousBlood|Aciclovir|Plasma (Peripheral Venous Blood)",
#     totalSensitivityThreshold = 1   # 0.9 (default) hides minor params; 1 shows all
#   )
#
# For a single value:
#   saResult$pkParameterSensitivityValueFor(
#     pkParameterName = "AUC_inf",
#     parameterName   = "Aciclovir-Lipophilicity",
#     outputPath      = "...|Plasma (Peripheral Venous Blood)"
#   )

# YOUR CODE:


# 3. Repeat with variationRange = 0.5 — does the ranking change? ---------
# HINT: rebuild the SA (or mutate sa$variationRange <- 0.5), rerun, compare.

# YOUR CODE:
