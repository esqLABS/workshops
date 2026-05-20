# Aciclovir-PAGE — Workshop Project Skeleton

Used in **PAGE 2026 workshop**, blocks 1–3 (morning).

## What goes where

| Folder | Contents | Status |
|---|---|---|
| `Models/` | `Aciclovir.pkml` | reuse from `system.file("extdata", "Aciclovir.pkml", package = "ospsuite")` |
| `Configurations/` | `ProjectConfiguration.xlsx`, `Scenarios.xlsx`, etc. | **TODO — copy from existing TestProject** then customize for 250 / 500 mg PO |
| `Data/` | `ObsDataAciclovir_*.pkml` | reuse from `{ospsuite}` package extdata |

## Prep (T-3 weeks)

- [ ] Copy `TestProject` skeleton from `{esqlabsR}` package as starting point: `esqlabsR::initProject("workshops/resources/projects/Aciclovir-PAGE")`.
- [ ] Replace `Models/Aciclovir.pkml` with the bundled `{ospsuite}` Aciclovir model.
- [ ] Populate `Scenarios.xlsx` with 3 rows: `Aciclovir_PO_250mg`, `Aciclovir_PO_500mg`, `HANDS_ON_PLACEHOLDER`.
- [ ] Drop bundled obs `.pkml` files into `Data/`.
- [ ] Validate end-to-end with `runScenarios` + `createPlotsFromExcel`.

## Workshop usage

The morning blocks (1, 2, 3) primarily use raw `{ospsuite}` calls — **the project structure is shown but not heavily interacted with**. The first deep `{esqlabsR}` interaction is in block 4 with the Midazolam project.

Use this Aciclovir project as a "looks like a real project" backdrop for the morning, and a quick reference when transitioning to Midazolam at 14:00.
