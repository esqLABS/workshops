---
title: PAGE 2026 — Pre-workshop email
audience: Workshop registrants
send_date: "2026-05-25 (T-1 week)"
sender: pavel.balazki@esqlabs.com
cc_recipients: wilbert.dewitte@esqlabs.com
---

# Subject

PAGE 2026 Workshop — your VM access, prep, and what to bring (June 1, Dubrovnik)

# Body

Hi {{ first_name }},

Looking forward to seeing you at the **R Workflows for advanced PB-QSP Modeling** workshop next Monday in Dubrovnik. A few things to get you ready.

## 🖥 Your Azure VM (no local installs needed)

You will run the entire workshop on a pre-configured Windows VM with R, RStudio, `{ospsuite}`, `{esqlabsR}`, ESQapp, PK-Sim and MoBi already installed.

- **VM URL:** `{{ vm_url }}`
- **Username:** `{{ vm_user }}`
- **Password:** `{{ vm_password }}` _(please change on first login)_
- **Smoke test (please do this before the workshop):**
  1. Log in via the link above (Chrome / Edge recommended)
  2. Double-click "**Workshop Materials**" on the desktop
  3. RStudio opens with the project loaded
  4. In the console, run:
     ```r
     library(ospsuite)
     library(esqlabsR)
     sim <- loadSimulation(system.file("extdata", "Aciclovir.pkml",
                                        package = "ospsuite"))
     sim
     ```
  5. If you see a simulation summary printed → you're ready.

If anything fails, **email me a screenshot by Friday May 29** so we can fix it before the workshop starts.

## 🧪 Skill self-check (60 seconds)

Tick the ones that apply:

- [ ] I can install R packages from CRAN
- [ ] I have written R scripts (more than copy-paste)
- [ ] I know what `<-` does
- [ ] I have used `dplyr` (`filter`, `mutate`) or another data-frame library
- [ ] I have used `ggplot2` to make a plot
- [ ] I have used Quarto or R Markdown

If you ticked **3 or fewer**, please skim a short R refresher beforehand:

- [Hands-On Programming with R, ch. 1–3](https://rstudio-education.github.io/hopr/)
- [R for Data Science, ch. 1–4](https://r4ds.hadley.nz/)

We will not teach R basics in the workshop, but we will spend 10–15 minutes at the start re-orienting RStudio if needed. Wilbert will sit with you during hands-on if you need a hand.

## 📋 What we'll cover

- Morning: `{ospsuite}` foundations — load, parameterize, run, plot a PK-Sim model
- Afternoon: `{esqlabsR}` — Excel-driven scenario design, advanced sensitivity, Quarto reports
- Two compounds: **Aciclovir** (AM) and **Midazolam–CYP3A** (PM)
- Format: ~60% live demo, ~40% hands-on

## 📦 What you'll get

- Public GitHub repo with all slides, exercises, project templates: <https://github.com/esqLABS/r-packages-training>
- Printed 2-page cheatsheet (`{ospsuite}` + `{esqlabsR}` essentials)
- Certificate of completion (PDF emailed after the workshop)

## 🧳 What to bring

- Your laptop (any OS — VM runs in the browser)
- Stable internet (the venue offers Wi-Fi but a personal hotspot is a good backup)
- Curiosity + questions — Wilbert and I will roam the room throughout

## 📍 Logistics

- **Location:** Valamar Lacroma Hotel, Dubrovnik — room TBC at registration
- **Time:** 09:00 – 17:00 (lunch 12:15 – 13:15 included; coffee breaks at 10:30 and 15:30)
- **Dress code:** business casual, but Dubrovnik is warm — wear what you'd wear to a poster session

## ✋ Pre-workshop questions

If you have a specific PBPK/M&S use case you'd like us to cover, **reply to this email** by **Friday May 29**. We'll try to weave it in.

See you in Dubrovnik!

Pavel & Wilbert

---

Pavel Balazki
Senior Scientist, ESQlabs
pavel.balazki@esqlabs.com

Wilbert de Witte, PhD
Senior Scientist, ESQlabs
wilbert.dewitte@esqlabs.com
