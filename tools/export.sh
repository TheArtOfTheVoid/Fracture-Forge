#!/usr/bin/env bash
if ! command -v godot &>/dev/null; then
  echo "Godot CLI not found. Install Godot 4.x and add it to PATH."
  exit 0
fi

godot --headless --export-release "Windows Desktop" build/Cradle.exe
godot --headless --export-release "Web" build/web/index.html
