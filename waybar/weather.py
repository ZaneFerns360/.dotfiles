#!/usr/bin/env python3

import requests
import json
import datetime

weather_icons = {
    "sunnyDay": " ",
    "clearNight": "󰖔 ",
    "cloudyFoggyDay": " ",
    "cloudyFoggyNight": " ",
    "rainyDay": " ",
    "rainyNight": " ",
    "snowyIcyDay": " ",
    "snowyIcyNight": " ",
    "severe": "",
    "default": " ",
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
        "relative_humidity_2m",
        "visibility",
    ],
    "daily": [
        "uv_index_max",
        "precipitation_probability_max",
        "wind_speed_10m_max",
    ],
    "timezone": "auto",
    "forecast_days": 1,
}

response = requests.get(url, params=params)
data = response.json()

current_time = datetime.datetime.now()
current_hour = current_time.hour

temperature = (
    data["hourly"]["temperature_2m"][current_hour]
    if current_hour < len(data["hourly"]["temperature_2m"])
    else None
)
precipitation_probability = data["hourly"]["precipitation_probability"][current_hour]
rain = data["hourly"]["rain"][current_hour]
cloud_cover = data["hourly"]["cloud_cover"][current_hour]
humidity = data["hourly"]["relative_humidity_2m"][current_hour]
visibility = data["hourly"]["visibility"][current_hour] / 1000

is_daytime = 6 <= current_hour <= 18

if precipitation_probability > 50:
    status = "Rainy"
    icon = weather_icons["rainyDay"] if is_daytime else weather_icons["rainyNight"]
elif cloud_cover < 20:
    status = "Clear"
    icon = weather_icons["sunnyDay"] if is_daytime else weather_icons["clearNight"]
elif cloud_cover < 60:
    status = "Partly Cloudy"
    icon = (
        weather_icons["cloudyFoggyDay"]
        if is_daytime
        else weather_icons["cloudyFoggyNight"]
    )
else:
    status = "Cloudy"
    icon = (
        weather_icons["cloudyFoggyDay"]
        if is_daytime
        else weather_icons["cloudyFoggyNight"]
    )

prediction = (
    "Expect clear skies with minimal weather disturbances."
    if precipitation_probability < 30 and cloud_cover < 40
    else "Rain or significant weather changes expected later in the day."
    if precipitation_probability > 50
    else "Partly cloudy with moderate weather conditions."
)

tooltip_text = str.format(
    "<tt><span size='large'>{}°C</span></tt>\n"
    "<tt><span color='yellow'>{}</span></tt>\n"
    "<tt><span color='white'>{}</span></tt>\n"
    "<tt><small>Humidity: {}% | Visibility: {:.1f} km</small></tt>\n"
    "<tt><small>Min: {}°C | Max: {}°C</small></tt>\n"
    "<tt><span color='green'>{}</span></tt>\n",
    temperature,
    icon,
    status,
    humidity,
    visibility,
    min(data["hourly"]["temperature_2m"]),
    max(data["hourly"]["temperature_2m"]),
    prediction,
)

out_data = {
    "text": f"{icon}   {temperature}°C" if temperature else "N/A",
    "alt": status,
    "tooltip": tooltip_text,
    "class": status.lower().replace(" ", "_"),
}

print(json.dumps(out_data))
