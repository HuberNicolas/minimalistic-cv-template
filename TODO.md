# TODO

Open tasks for the template.

## 1. Build

- [x] Compile the original 2023 version with TeX Live 2026 (pdfLaTeX, no errors)
- [x] Build with latexmk (`.latexmkrc`) and in GitHub Actions; attach the PDF to releases
- [ ] Check the first workflow run on GitHub after the push

## 2. Class (v2)

- [x] Pass class options to `article`, load `fontenc`/`fontspec` per engine, add `microtype`
- [x] Replace the fragile `\ifx#5\empty` check with `\ifblank`; leave out the dash for a single date
- [x] Set PDF title and author from `\title` and `\author`
- [ ] Optional: bold small capitals for XeLaTeX/LuaLaTeX (needs a font that has them, e.g. New Computer Modern)
- [ ] Optional: icons for phone, email and website (e.g. `fontawesome5`)

## 3. Release

- [ ] Tag the 2023 state as `v1.0.0` and the update as `v2.0.0`; the workflow attaches the PDF
