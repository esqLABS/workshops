# Midazolam-PAGE-dev — Instructor-only assets

Sources, prep scripts, and validation tests for the [Midazolam-PAGE](../Midazolam-PAGE/) project. **Not shipped to workshop attendees.**

## Layout

| Path | Contents |
|---|---|
| `_source/Midazolam-Model/` | Snapshot of [Open-Systems-Pharmacology/Midazolam-Model](https://github.com/Open-Systems-Pharmacology/Midazolam-Model) (GPLv2) |
| `_source/Ketoconazole-Midazolam-DDI/` | DDI showcase snapshot (GPLv2) |
| `_source/SOURCES.md` | Per-asset inventory + licensing |
| `_source/extract_observed_data.R` | Pulls observed data into `../Midazolam-PAGE/Data/Midazolam_obs.xlsx` |
| `tests/test_project.R` | End-to-end smoke test — loads ProjectConfiguration, runs every scenario, renders every plot grid |

## Prep checklist

### T-6 weeks — model export

- [ ] Install PK-Sim 12.2.
- [ ] Open `_source/Midazolam-Model/Midazolam-Model.json` in PK-Sim.
- [ ] **Export** the following simulations to `.pkml` into `../Midazolam-PAGE/Models/Simulations/`:
  - `po 7.5 mg (tablet)` → `Midazolam_PO_7.5mg.pkml`
  - `po 15 mg (tablet)` → `Midazolam_PO_15mg.pkml`
  - `iv 2 mg (bolus)` → `Midazolam_IV_2mg.pkml`
- [ ] Validate each runs in <5 s on the workshop VM.

Alternative: if installed `{ospsuite}` supports `loadSimulationFromSnapshot()`, skip manual export and load directly from JSON.

### T-5 weeks — observed data + Excel scaffolding

- [ ] Install workshop deps: `install.packages(c("jsonlite","writexl","readxl","dplyr","tidyr","here"))`.
- [ ] Run `_source/extract_observed_data.R` → produces `../Midazolam-PAGE/Data/Midazolam_obs.xlsx` + `Midazolam_obs_full.xlsx`.
- [ ] Run `esqlabsR::initProject(here("workshops/resources/projects/Midazolam-PAGE"))`.
- [ ] Edit `../Midazolam-PAGE/Configurations/Scenarios.xlsx` — pre-populate:
  - `Midazolam_PO_7.5mg`
  - `Midazolam_IV_2mg`
  - empty placeholder `Midazolam_PO_15mg_HANDS_ON`
- [ ] Edit `Configurations/Applications.xlsx` — dosing protocols matching simulations.
- [ ] Edit `Configurations/Plots.xlsx`:
  - `Midazolam_PO_vs_obs` (pre-defined)
  - empty placeholder for hands-on
- [ ] Document SA parameters for Block 5 in code (not via Excel): `CYP3A4_kcat`, `Lipophilicity`, `GFR_filtration_fraction` (`variationRange = c(0.1, 0.5, 1, 2, 10)`). Run via `sensitivityCalculation()`.

### T-4 weeks — validate end-to-end

- [ ] `Rscript tests/test_project.R` — smoke test: loads ProjectConfiguration, runs every scenario, renders every plot grid, drops PNGs into `../Midazolam-PAGE/Results/test_renders/`.
- [ ] `sensitivityCalculation` + `saveSensitivityCalculation(..., outputDir = "Results/SA_Midazolam")`.
- [ ] `quarto render ../Midazolam-PAGE/Reports/Midazolam-report.qmd` → HTML + PDF.
- [ ] `quarto render -P dose_mg:15` → fresh report regenerates correctly.

### T-1 week — build shippable archive

- [ ] Run `scripts/build-midazolam-zip.R` (or equivalent) → produces `Midazolam-PAGE.zip` next to the project directory.
- [ ] Smoke-test the zip: extract into a temp dir, open in RStudio, run `library(esqlabsR); loadProject(...)` end-to-end.
- [ ] Upload to the workshop distribution channel (GitHub release / Drive / etc.).

## Licensing

Upstream OSP assets are GPLv2. Workshop adaptations preserve attribution. See [`_source/SOURCES.md`](_source/SOURCES.md) for per-dataset references.
