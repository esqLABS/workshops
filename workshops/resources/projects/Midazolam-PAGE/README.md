# Midazolam-PAGE — Workshop Project

Used in **PAGE 2026 workshop**, blocks 4–6 (afternoon).

## Sourced upstream (no manual model-build needed!)

The Midazolam model + 115 observed datasets are sourced from the OSP community:

- 📦 `_source/Midazolam-Model/` — clone of [Open-Systems-Pharmacology/Midazolam-Model](https://github.com/Open-Systems-Pharmacology/Midazolam-Model) (GPLv2)
- 📦 `_source/Ketoconazole-Midazolam-DDI/` — DDI showcase (GPLv2)
- 📋 [`_source/SOURCES.md`](./_source/SOURCES.md) — full asset inventory + licensing
- 🧪 `_source/extract_observed_data.R` — pulls obs into `Data/Midazolam_obs.xlsx`

The PK-Sim model file is `_source/Midazolam-Model/Midazolam-Model.json` — a snapshot containing **37 simulations + 115 observed datasets + 3 parameter identifications**.

## Folder map

| Folder | Contents | Status |
|---|---|---|
| `Models/Simulations/` | `Midazolam_*.pkml` exported from snapshot | **TODO — export from PK-Sim 12.2** (or load JSON via `loadSimulationFromSnapshot`) |
| `Configurations/` | Excel files (Scenarios, Plots, SA, etc.) | **TODO — `initProject` + populate** |
| `Data/` | `Midazolam_obs.xlsx` curated subset | run `_source/extract_observed_data.R` |
| `Results/` | populated at runtime | empty |
| `Reports/` | `Midazolam-report.qmd` | scaffolded ✅ |

## Prep checklist

### T-6 weeks — model export

- [ ] Install PK-Sim 12.2.
- [ ] Open `_source/Midazolam-Model/Midazolam-Model.json` in PK-Sim.
- [ ] **Export** the following simulations to `.pkml` into `Models/Simulations/`:
  - `po 7.5 mg (tablet)` → `Midazolam_PO_7.5mg.pkml`
  - `po 15 mg (tablet)` → `Midazolam_PO_15mg.pkml`
  - `iv 2 mg (bolus)` → `Midazolam_IV_2mg.pkml`
- [ ] Validate each runs in <5 s on the workshop VM.

Alternative: if the installed `{ospsuite}` supports `loadSimulationFromSnapshot()`, skip the manual export and load directly from JSON.

### T-5 weeks — observed data + Excel scaffolding

- [ ] Install workshop deps: `install.packages(c("jsonlite","writexl","readxl","dplyr","tidyr","here"))`.
- [ ] Run `_source/extract_observed_data.R` → produces `Data/Midazolam_obs.xlsx` + `Data/Midazolam_obs_full.xlsx`.
- [ ] Run `esqlabsR::initProject(here("workshops/resources/projects/Midazolam-PAGE"))`.
- [ ] Edit `Configurations/Scenarios.xlsx` — pre-populate:
  - `Midazolam_PO_7.5mg`
  - `Midazolam_IV_2mg`
  - empty placeholder `Midazolam_PO_15mg_HANDS_ON`
- [ ] Edit `Configurations/Applications.xlsx` — dosing protocols matching simulations.
- [ ] Edit `Configurations/Plots.xlsx`:
  - `Midazolam_PO_vs_obs` (pre-defined)
  - empty placeholder for hands-on
- [ ] Document SA parameters for Block 5 in code (not via Excel): `CYP3A4_kcat`, `Lipophilicity`, `GFR_filtration_fraction` (`variationRange = c(0.1, 0.5, 1, 2, 10)`). Run via `sensitivityCalculation()`.

### T-4 weeks — validate end-to-end

- [ ] Run smoke test: `Rscript workshops/resources/projects/Midazolam-PAGE/tests/test_project.R` — loads ProjectConfiguration, runs every scenario in `Scenarios.xlsx`, renders every plot grid in `Plots.xlsx`, drops PNGs into `Results/test_renders/`.
- [ ] `sensitivityCalculation` + `saveSensitivityCalculation(..., outputDir = "Results/SA_Midazolam")`.
- [ ] `quarto render Reports/Midazolam-report.qmd` → HTML + PDF.
- [ ] `quarto render -P dose_mg:15` → fresh report regenerates correctly.

## Workshop usage (day-of)

| Block | What attendees do |
|---|---|
| 4a | Open project in ESQapp → add `Midazolam_PO_15mg_HANDS_ON` scenario, run via `runScenarios` |
| 4b | Open project in ESQapp → define a PO-vs-obs figure, render via `createPlotsFromExcel` |
| 5  | Build SA in R for chosen parameters → run multi-factor SA, generate spider/tornado |
| 6  | Render `Reports/Midazolam-report.qmd` with default + override params |

Solutions live in `Configurations/_solutions/` (created during prep — keep hidden until each block).

## Licensing

Upstream OSP assets are GPLv2. Workshop adaptations preserve attribution. See `_source/SOURCES.md` for per-dataset references.
