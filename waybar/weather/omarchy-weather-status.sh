#!/bin/bash
# Use this command to find the file: nvim $(which omarchy-weather-status)
# omarchy:summary=Returns a formatted weather status string with temperature and wind speed.

weather=$(curl -fsS --max-time 4 "https://wttr.in/Onesti?format=%l|%t|%w" 2>/dev/null | tr -d '\n')
# Change the city above
if [[ -z $weather ]]; then
  echo "Weather unavailable"
  exit 1
fi

IFS='|' read -r place temperature wind <<< "$weather"
place=${place%%,*}
place=${place^}
temperature=${temperature#+}

echo "$(omarchy-weather-icon)    $place  ·  Temp $temperature  ·  Wind $wind"
