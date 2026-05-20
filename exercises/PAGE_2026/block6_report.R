# PAGE 2026 — Block 6 hands-on
# Goal: Render the Midazolam Quarto report with default and overridden params
# Time: 10 min

library(quarto)
library(here)

REPORT <- here("workshops/resources/projects/Midazolam-PAGE/Reports/Midazolam-report.qmd")

# 1. Default render (HTML) -----------------------------------------------
quarto_render(REPORT)

# 2. Override the dose to 15 mg ------------------------------------------
quarto_render(
  REPORT,
  execute_params = list(
    scenario = "Midazolam_PO_15mg",
    dose_mg  = 15,
    route    = "PO"
  )
)

# 3. Compare the two outputs ---------------------------------------------
#    Open both HTMLs side by side. Note that figures + PK tables regenerated.

# 4. BONUS: PDF render
# quarto_render(REPORT, output_format = "pdf")
