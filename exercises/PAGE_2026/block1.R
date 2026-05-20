# PAGE 2026 — Block 1 hands-on
# Goal: Explore the Aciclovir model — load, inspect, navigate, query parameters.
# No mutations. No saving. Just look.
# Time: 15 min

library(ospsuite)

# 1. Load the bundled Aciclovir model -------------------------------------
sim_path <- system.file("extdata", "Aciclovir.pkml", package = "ospsuite")
sim <- loadSimulation(sim_path)
print(sim)

# 2. Build the simulation tree --------------------------------------------
# HINT: tree <- getSimulationTree(sim)
# Then tab-complete from `tree$` in RStudio.

# YOUR CODE:

# 3. Navigate the tree to the Liver volume parameter ----------------------
# HINT: tree$Organism$Liver$Volume   (try tab-completion to find the path)

# YOUR CODE:

# 4. Read the Liver volume with getParameter() ----------------------------
# HINT: p <- getParameter("Organism|Liver|Volume", sim)
# Then inspect:  p$value ; p$unit ; p$dimension

# YOUR CODE:

# 5. List every "Volume" parameter in the model ---------------------------
# HINT: getAllParametersMatching("**|Volume", sim)
# `**` matches any number of intermediate containers.

# YOUR CODE:

# Bonus: inspect the simulation configuration -----------------------------
# HINT:
#   sim$solver           # tolerances
#   sim$outputSelections # what is being recorded
#   sim$outputSchema     # simulation time + resolution

# YOUR CODE:
