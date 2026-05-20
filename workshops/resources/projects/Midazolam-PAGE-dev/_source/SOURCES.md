# Sourced assets — Midazolam-PAGE workshop project

All material in `_source/` is cloned from the **Open Systems Pharmacology** organization on GitHub. Distributed under **GPLv2**.

## What was cloned

### `Midazolam-Model/` — primary source

- Repo: <https://github.com/Open-Systems-Pharmacology/Midazolam-Model>
- License: GPLv2
- Description: Whole-body PBPK model of midazolam as CYP3A4 DDI victim drug. Validated against 100+ published clinical PK profiles.

Contents:
- `Midazolam-Model.json` (1.3 MB) — PK-Sim 12.2 snapshot with:
  - **37 simulations** (IV + PO across many doses)
  - **115 observed datasets** with full time/concentration arrays + study metadata
  - **3 parameter identifications** (Hohmann iv+po, Tablet 7.5 mg, Korean Yu 2004)
  - 1 compound, 2 individuals, 8 expression profiles
- `Evaluation/` — qualification report + plan + workflow.R (Reporting Engine workflow)
- `README.md` — model overview + literature references

### `Ketoconazole-Midazolam-DDI/` — DDI showcase

- Repo: <https://github.com/Open-Systems-Pharmacology/Ketoconazole-Midazolam-DDI>
- License: GPLv2
- Description: Ketoconazole–midazolam DDI model (CYP3A4 mechanism-based inhibition). Used in workshop block 5 SA story.

Contents:
- `Ketoconazole-Midazolam-DDI.json` (745 KB) — DDI model snapshot
- `Ketoconazole-Midazolam-DDI.pksim5` — **REMOVED** to keep repo small (55 MB binary). Re-clone full repo if needed.
- `README.md`

## Available simulations (Midazolam-Model.json)

37 in total. Highlights for workshop hands-on:

| Workshop block | Use this simulation |
|---|---|
| Block 4 base scenario | `po 7.5 mg (tablet)` |
| Block 4 hands-on (15 mg) | `po 15 mg (tablet)` |
| Block 4 IV reference | `iv 2 mg (bolus)` |
| Block 5 SA target | `po 7.5 mg (tablet)` |
| Block 6 Quarto report | `po 7.5 mg (tablet)` (default param) + `po 15 mg (tablet)` (override) |
| C1 demo (param ID) | `PI Tablet 7.5 mg` (already configured) |

Full list:

```
iv 0.001 mg (5 min)              po 0.003 mg (solution)
iv 0.05 mg/kg (2 min)            po 0.01 mg (solution)
iv 0.05 mg/kg (30 min)           po 0.075 mg (solution)
iv 0.05 mg/kg (bolus)            po 0.075 mg/kg (syrup)
iv 0.075 mg/kg (1 min)           po 1 mg (solution)
iv 0.15 mg/kg (bolus)            po 10 mg (solution)
iv 1 mg (5 min)                  po 10 mg (tablet)
iv 1 mg (bolus)                  po 15 mg (tablet)
iv 2 mg (2 min)                  po 15 mg (tablet) - with 1 h before high-fat breakfast
iv 2 mg (bolus)                  po 15 mg (tablet) - with 1h after high-fat breakfast
iv 5 mg (30 sec)                 po 15 mg (tablet) - with high-fat breakfast
iv 5 mg (bolus)                  po 2 mg (solution)
                                 po 2.5 mg (solution)
                                 po 20 mg (tablet)
                                 po 3.5 mg (solution)
                                 po 4 mg (solution)
                                 po 40 mg (tablet)
                                 po 5 mg (solution)
                                 po 6 mg (solution)
                                 po 7.5 mg (solution)
                                 po 7.5 mg (tablet)
                                 po 8 mg (solution)
                                 Mikus 2017
```

## How to use these assets

### Option A — open the snapshot in PK-Sim 12.2 (recommended)

1. Install PK-Sim 12.2.
2. **File → Open** → `_source/Midazolam-Model/Midazolam-Model.json`.
3. Right-click any simulation → **Export simulation** → `.pkml`.
4. Drop the exported `.pkml` into `Models/Simulations/` of this project.
5. Reference the `.pkml` from `Configurations/Scenarios.xlsx`.

### Option B — load JSON snapshot directly via `{ospsuite}`

Recent `{ospsuite}` versions can load OSPS snapshots if PK-Sim is installed locally:

```r
library(ospsuite)
# Requires PKSim package which calls the local PK-Sim engine
sim <- loadSimulationFromSnapshot(
  "_source/Midazolam-Model/Midazolam-Model.json",
  simulationName = "po 7.5 mg (tablet)"
)
```

Verify the function exists in your installed `{ospsuite}` version: `?loadSimulationFromSnapshot`. If not, fall back to Option A.

### Extracting observed data

Run `extract_observed_data.R` in this folder. It reads `Midazolam-Model.json` and writes:

- `Data/Midazolam_obs_full.xlsx` — all 115 datasets (long format) + summary sheet
- `Data/Midazolam_obs.xlsx` — workshop-curated subset (7.5 mg / 15 mg PO + IV 2 mg)

These Excel files plug directly into the `{esqlabsR}` project's `Data/` folder and are referenced from `Plots.xlsx`.

## Licensing + attribution

- All assets in `_source/`: **GPLv2** (Open Systems Pharmacology Suite).
- When publishing or redistributing derived work (slides, reports, modified models), preserve attribution to the OSPS community and link back to the source repos.
- Each observed dataset carries its own literature reference in `ExtendedProperties → Reference`. Cite the original publication when using a dataset in figures.
