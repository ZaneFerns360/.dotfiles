#!/usr/bin/env python3

import requests
import json
import datetime

weather_icons = {
    "sunnyDay": "滛",
    "clearNight": "望",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "",
    "default": "",
}

latitude = 19.0667
longitude = 72.8333
url = "https://api.open-meteo.com/v1/forecast"
params = {
    "latitude": latitude,
    "longitude": longitude,
    "hourly": [
        "temperature_2m",
        "precipitation_probability",
        "precipitation",
        "rain",
        "cloud_cover",
        "cloud_cover_low",
        "cloud_cover_mid",
        "cloud_cover_high",
    ],
    "daily": [
        "uv_index_max",
        "uv_index_clear_sky_max",
        "precipitation_probability_max",
        "wind_speed_10m_max",
        "shortwave_radiation_sum",
    ],
    "timezone": "auto",
    "forecast_days": 1,
}

response = requests.get(url, params=params)
data = response.json()

# Get current hour in UTC
current_hour = datetime.datetime.now().hour

# Map hourly temperature to current time
temperature = (
    data["hourly"]["temperature_2m"][current_hour]
    if current_hour < len(data["hourly"]["temperature_2m"])
    else None
)
precipitation_probability = data["hourly"]["precipitation_probability"][current_hour]
rain = data["hourly"]["rain"][current_hour]
cloud_cover = data["hourly"]["cloud_cover"][current_hour]

# Determine weather status and icon
if precipitation_probability > 50:
    status = "Rainy"
    icon = weather_icons["rainyDay"]
else:
    if cloud_cover < 20:
        status = "Sunny"
        icon = weather_icons["sunnyDay"]
    else:
        status = "Cloudy"
        icon = weather_icons["cloudyFoggyDay"]

# Prepare tooltip text
temp_feel_text = f"Feels like: {temperature}°C"
temp_min_max = f"Min: {min(data['hourly']['temperature_2m'])}°C Max: {max(data['hourly']['temperature_2m'])}°C"
wind_text = f"Wind: {data['daily']['wind_speed_10m_max'][0]} km/h"
humidity_text = "Humidity: N/A"  # Placeholder
visbility_text = "Visibility: N/A"  # Placeholder
air_quality_index = "N/A"  # Placeholder
prediction = "No significant weather changes expected."

# Create tooltip text
tooltip_text = str.format(
    "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
    f'<span size="xx-large">{temperature}°C</span>',
    f"<big>{icon}</big>",
    f"<big>{status}</big>",
    f"<small>{temp_feel_text}</small>",
    f"<big>{temp_min_max}</big>",
    f"{wind_text}\t{humidity_text}",
    f"{visbility_text}\tAQI {air_quality_index}",
    f"<i>{prediction}</i>",
)

# Print Waybar module data
out_data = {
    "text": f"{icon}   {temperature}°C" if temperature else "N/A",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status.lower().replace(" ", "_"),
}
print(json.dumps(out_data))
