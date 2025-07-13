@echo off
:: Run this from the root of a blank Git repo

echo [+] Creating folders...
mkdir .github
mkdir .github\workflows

echo [+] Creating .gitignore...
(
  echo # Godot 4 cache & temp
  echo .import/
  echo .godot/
  echo godot.export/
  echo
  echo # OS junk
  echo Thumbs.db
  echo .DS_Store
  echo
  echo # Editor temp files
  echo *.tmp
  echo *.temp
) > .gitignore

echo [+] Creating README.md...
(
  echo # Cradle-to-Crucible
  echo Minimal Godot 4 voxel project scaffold.
  echo.
  echo ## How to run
  echo 1. Open with Godot 4.x
  echo 2. Press F5 to run
) > README.md

echo [+] Creating GitHub Actions workflow...
(
  echo name: Godot CI
  echo.
  echo on:
  echo ^  push:
  echo ^    branches: [main]
  echo.
  echo jobs:
  echo ^  sanity-check:
  echo ^    runs-on: ubuntu-latest
  echo ^    steps:
  echo ^    - uses: actions/checkout@v4
  echo ^    - uses: chickensoft-games/setup-godot@v1
  echo ^      with:
  echo ^        version: 4.2.2
  echo ^        include-mono: false
  echo ^    - run: godot --headless --quit || true
) > .github\workflows\godot-ci.yml

echo [+] Done! Now open Godot, create a new project HERE, and commit the result.
pause