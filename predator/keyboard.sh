#!/usr/bin/env bash

# Check if the system-product-name includes "Predator"
if [[ "$(sudo dmidecode -s system-product-name 2>/dev/null)" == *"Predator"* ]]; then
  echo "Predator system detected; applying neon-green/purple static lighting."

  # Zone 1
  "/home/zane/.dotfiles/predator/facer_rgb.py" -m 0 -z 1 -cR 210 -cG 0 -cB 48

  # Zone 2
  "/home/zane/.dotfiles/predator/facer_rgb.py" -m 0 -z 2 -cR 210 -cG 0 -cB 48

  # Zone 3
  "/home/zane/.dotfiles/predator/facer_rgb.py" -m 0 -z 3 -cR 210 -cG 0 -cB 48

  # Zone 4
  "/home/zane/.dotfiles/predator/facer_rgb.py" -m 0 -z 4 -cR 210 -cG 0 -cB 48
fi
