# PAGE 2026 — Block 2 hands-on
# Goal: Compare default Aciclovir vs. a "no GFR" variant.
#       Run both, build a DataCombined, plot time profile vs observed data.
# Time: 30 min

library(ospsuite)
options(ospsuite.plots.watermarkEnabled = FALSE)

# 1. Load Aciclovir twice -------------------------------------------------
sim_path <- system.file("extdata", "Aciclovir.pkml", package = "ospsuite")

sim <- loadSimulation(sim_path)
sim_noGFR <- loadSimulation(sim_path)


# 2. Knock out GFR in sim_noGFR -------------------------------------------
# Path of the GFR fraction parameter for Aciclovir:
gfrPath <- "Neighborhoods|Kidney_pls_Kidney_ur|Aciclovir|Glomerular Filtration-GFR-Aciclovir|GFR fraction"

# HINT: setParameterValuesByPath(gfrPath, 0, sim_noGFR)

# YOUR CODE:

# 3. Run both simulations -------------------------------------------------
# HINT: results <- runSimulations(list(sim, sim_noGFR))
#       Returned list is keyed by sim$id

# YOUR CODE:

# 4. Build DataCombined with both sims + observed data -------------------
# HINT:
# plasmaPath <- "Organism|PeripheralVenousBlood|Aciclovir|Plasma (Peripheral Venous Blood)"
# obs <- loadDataSetFromPKML(system.file("extdata", "ObsDataAciclovir_1.pkml",
#                                        package = "ospsuite"))
# dc <- DataCombined$new()
# dc$addSimulationResults(results[[sim$id]],       quantitiesOrPaths = plasmaPath,
#                         names = "Default",       groups = "Aciclovir")
# dc$addSimulationResults(results[[sim_noGFR$id]], quantitiesOrPaths = plasmaPath,
#                         names = "GFR = 0",       groups = "Aciclovir")
# dc$addDataSets(obs, names = "Observed", groups = "Aciclovir")

# YOUR CODE:

# 5. Plot the time profile on log y ---------------------------------------
# HINT: plotTimeProfile(dc, yScale = "log")

# YOUR CODE:

# Bonus: residuals vs time -----------------------------------------------
# HINT: plotResidualsVsCovariate(dc, xAxis = "time")

# YOUR CODE:
