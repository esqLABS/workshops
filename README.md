# ESQlabs R Trainings

## Repository Organization

This repository is organized as a Quarto website project for ESQlabs R training materials.

### Directory Structure

- **`workshops/`** - Contains workshop slides that are meant to be presented live and interactively, with audience 
  - Workshops have their own `_quarto.yml` configuration and extensions
  - Files are organized with prefixes (A1-, A2-, B1-, etc.) to indicate modules
  - Contains a `resources/` subdirectory with workshop-specific assets (images, data files, etc.)

- **`agendas/`** - Contains agenda files for training sessions
  - Example: `X1_BI_agenda.qmd`

- **`resources/`** - Shared static resources for the website
  - Images (logos, favicons)
  - Other assets used across multiple workshops

- **`_extensions/`** - Quarto extensions
  - `esqLABS/` - Custom ESQlabs extensions
  - `quarto-ext/` - Additional Quarto extensions

- **`renv/`** - R environment management
  - Contains the R package library and lockfile for reproducible environments
  - See the section below on managing packages with renv

### Configuration Files

- **`_quarto.yml`** - Main Quarto website configuration
  - Defines site metadata, navigation, and rendering settings
  - Configures the website title, description, and URL

- **`index.qmd`** - Homepage of the website
  - Displays listings for courses and workshops
  - Uses Quarto listing components to automatically generate tables

- **`renv.lock`** - R package dependency lockfile
  - Ensures all contributors use the same package versions
  - Should be committed to version control

### Adding New Content

When adding new training materials:

1. Create a git branch for your changes.
2. Add a `.qmd` file in the appropriate directory (`workshops/`, or `agendas/`).
3. **Metadata**: Ensure your `.qmd` files include proper YAML frontmatter with fields like `ID`, `Module`, `title`, and `author` so they appear correctly in the listings
4. Run `quarto render` to build the website and verify that the new content appears as expected.
5. Submit the branch as pull request for review.


## Environment Management

This project uses `renv` for package management. If new content requires to add additional R packages:

1. **Activate renv** (if not already active):
   ```r
   renv::activate()
   ```

2. **Install the package(s)** using one of these methods:
   ```r
   # Using renv::install() (recommended)
   renv::install("package-name")
   ```

3. **Update the lockfile** to record the new package in `renv.lock`:
   ```r
   renv::snapshot()
   ```

4. **Commit the updated `renv.lock` file** to version control so others can restore the same package versions.

### Restoring Packages

To restore all packages from the lockfile (e.g., after cloning the repository):
```r
renv::restore()
```
