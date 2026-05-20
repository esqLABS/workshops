# Midazolam-PAGE — Workshop Project

PBPK project used in **PAGE 2026 workshop**, blocks 4–6 (afternoon).

## Folder map

| Folder | Contents |
|---|---|
| `Models/Simulations/` | `Midazolam_*.pkml` simulation files |
| `Configurations/` | Excel files (Scenarios, Plots, SA, etc.) |
| `Data/` | Observed datasets — `Midazolam_obs.xlsx` |
| `Results/` | Populated at runtime |
| `Reports/` | `Midazolam-report.qmd` — Quarto reporting demo |

## Workshop usage

| Block | What you do |
|---|---|
| 4a | Open project in ESQapp → add `Midazolam_PO_15mg_HANDS_ON` scenario, run via `runScenarios` |
| 4b | Open project in ESQapp → define a PO-vs-obs figure, render via `createPlotsFromExcel` |
| 5  | Build a sensitivity analysis in R for chosen parameters → run multi-factor SA, generate spider/tornado |
| 6  | Render `Reports/Midazolam-report.qmd` with default + override params |

## Sourced upstream

The Midazolam model + observed datasets are sourced from the OSP community:

- [Open-Systems-Pharmacology/Midazolam-Model](https://github.com/Open-Systems-Pharmacology/Midazolam-Model) (GPLv2)
- Ketoconazole-Midazolam DDI showcase (GPLv2)

Full per-asset inventory and licensing live in the instructor-side dev folder (not shipped).

## Licensing

Upstream OSP assets are GPLv2. Workshop adaptations preserve attribution.
