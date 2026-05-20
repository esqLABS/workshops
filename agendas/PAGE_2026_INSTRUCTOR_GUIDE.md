---
title: "PAGE 2026 — Instructor Guide"
audience: Pavel + Wilbert
purpose: how to prep, render, and run the workshop deck on the day
---

# Deck topology

```
agendas/PAGE_2026.qmd          ← THE deck. Self-contained, ~90 slides.
                                  Render once → present from here all day.

workshops/A1-…-A13.qmd         ← Full reference modules. Hosted on the website.
workshops/B1-…-B5.qmd            Not shown live — attendees use post-workshop.
workshops/C1-Parameter-Identification.qmd

exercises/PAGE_2026/block*.R   ← Hands-on scripts. Attendees open in RStudio.
agendas/PAGE_2026_cheatsheet.qmd       ← Printed 2-page handout
agendas/PAGE_2026_certificate_*        ← Generated after the workshop
agendas/PAGE_2026_pre-workshop-email.md ← Sent T-1 week
```

# Render the deck

```bash
quarto render agendas/PAGE_2026.qmd
```

Output: `_site/agendas/PAGE_2026.html` (self-contained HTML — one file).

For live editing during prep:

```bash
quarto preview agendas/PAGE_2026.qmd
```

Auto-reloads on save.

# Day-of setup (≤ 09:00)

1. Boot laptop. Plug projector. **Extend** displays (not mirror).
2. Open `_site/agendas/PAGE_2026.html` in Chrome / Edge.
3. Press `F` — fullscreen on the projector display.
4. Press `S` — speaker-notes window opens. Drag to your laptop screen.
5. Open RStudio on laptop screen (project: `r-packages-training`).
6. Open `exercises/PAGE_2026/block1.R` in RStudio — ready for first hands-on.
7. Smoke test: advance 3 slides forward + back. Speaker notes follow.
8. Offline backup: USB stick has `_site/agendas/PAGE_2026.html` + `_site/agendas/PAGE_2026_files/` (in case venue Wi-Fi flakes).

# Reveal.js shortcuts (browser, deck focused)

| Key | Action |
|---|---|
| `→` / `Space` / `N` | Next slide |
| `←` / `P` | Previous slide |
| `S` | Speaker-notes window |
| `F` | Fullscreen toggle |
| `Esc` / `O` | Overview (grid; click to jump) |
| `B` | Black screen (mute attention) |
| `?` | Show all shortcuts |

# Block-by-block flow

| Block | What's on the deck | What you do |
|---|---|---|
| 0 — Welcome (09:00) | Title, agenda, prereqs, R skill show-of-hands | Count hands; decide whether to run 20-min R refresher (mean ≥ 3 → skip) |
| 1 — ospsuite foundations | Code-heavy slides; ends on hands-on task slide | At hands-on slide → Alt+Tab to RStudio, open `block1.R`, live-code first 2 steps, set 15-min timer |
| 2 — Parameterize · Run · Plot | Same pattern; longer 30-min hands-on | `block2.R`. Wilbert walks the room |
| 3 — PK · SA · Pop demo | A12/A13 are DEMO ONLY — speed through, no hands-on for populations | `block3.R` for the 15-min SA hands-on |
| 4 — esqlabsR project | Switch to Midazolam. Demo ESQapp in parallel window if helpful | `block4a_scenarios.R` + `block4b_plots.R` |
| 5 — Advanced SA + Param ID | Hands-on for SA, PI is DEMO ONLY | `block5_sensitivity.R`; PI demo via prebuilt scenario in `_source/Midazolam-Model.json` |
| Close (16:30–17:00) | Recap + final feedback poll + farewell | No script — direct on deck |

# At hands-on slides

1. Read the task aloud (10 seconds).
2. `Alt+Tab` → RStudio. Live-code the first 2 steps (~3 min).
3. `Alt+Tab` → back to deck. State the time budget: "15 minutes".
4. Start a visible timer (e.g. open Google "timer 15 min" in another browser tab, or use a kitchen-timer app on screen).
5. Walk the room with Wilbert. Help individuals. Listen for the same question coming up 2+ times — pause everyone and answer once.
6. T-2 min warning: "two minutes left, wrap up".
7. T-0: solicit one volunteer to share their result. Advance deck.

# At transition slides

Block-start slides have a dark coloured background (blue / green / orange). Pause:

- Recap what was done in the previous block (one sentence).
- Set up the next block ("now we are going to …").
- Confirm everyone is on the same starting point.

# Speaker notes

Some slides have `::: {.notes}` blocks. Visible only in speaker-notes window (press `S`). Use them as prompts for the live talk. Examples:

- After Aciclovir load slide: "remind R6 reference semantics — `sim$clone()` is broken on `.NET`-backed objects; reload to get an independent copy".
- Block 4 transition: "switch compound — explain why Midazolam".
- After final poll: "thank Wilbert, point to repo, hand out certs".

# When things go wrong

| Problem | Fix |
|---|---|
| Browser hangs / deck freezes | Close tab, re-open `_site/agendas/PAGE_2026.html`. Press `f` to fullscreen. Press number+enter to jump to slide. |
| Projector loses signal | Unplug HDMI, replug. Win+P to re-extend. |
| RStudio crashes mid-hands-on | Tell attendees to wait, restart RStudio, reload project. Wilbert keeps pace. |
| Hands-on stalls | If 30% of room can't run code, pause everyone, do it on screen, restart timer with 5 fewer minutes. |
| Wi-Fi dies | Quarto deck is self-contained HTML — works offline. Hands-on scripts hit only the Azure VM (internet-dependent). Have a local backup VM image or offline `.pkml` + R installed locally on at least 3 attendee machines. |

# After the workshop

1. Email follow-up:
   - "Thanks for coming" + 1-paragraph recap.
   - Link to repo `https://github.com/esqLABS/r-packages-training`.
   - Link to website `https://r-training.esqlabs.com`.
   - Direct module links for deeper study.
   - Certificate PDF as attachment.
2. Run `Rscript agendas/PAGE_2026_certificate_batch.R agendas/PAGE_2026_attendees.csv` → 15 PDFs in `agendas/certificates/`. Attach to email.
3. Capture flipchart photos (final feedback poll). Write a 1-page post-workshop note for next year.
4. Update plan memory `page_2026_workshop.md` with lessons learned for PAGE 2027.

# Quick-render commands

```bash
# Live editing
quarto preview agendas/PAGE_2026.qmd

# Full deck
quarto render agendas/PAGE_2026.qmd

# Cheatsheet PDF
quarto render agendas/PAGE_2026_cheatsheet.qmd

# Whole site (everything)
quarto render
```

# File locations cheat-sheet

| What | Path |
|---|---|
| Workshop deck source | `agendas/PAGE_2026.qmd` |
| Rendered deck | `_site/agendas/PAGE_2026.html` |
| Cheatsheet source | `agendas/PAGE_2026_cheatsheet.qmd` |
| Rendered cheatsheet PDF | `_site/agendas/PAGE_2026_cheatsheet.pdf` |
| Hands-on scripts | `exercises/PAGE_2026/block*.R` |
| Midazolam project (PM) | `workshops/resources/projects/Midazolam-PAGE/` |
| Sourced OSP models + obs | `workshops/resources/projects/Midazolam-PAGE/_source/` |
| Certificate template | `agendas/PAGE_2026_certificate_template.qmd` |
| Certificate batch script | `agendas/PAGE_2026_certificate_batch.R` |
| Pre-workshop email | `agendas/PAGE_2026_pre-workshop-email.md` |
