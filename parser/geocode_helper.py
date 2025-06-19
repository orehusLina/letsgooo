import requests
import os

def get_coordinates(address):
    key = os.getenv("YANDEX_GEOCODER_API_KEY")
    if not key:
        return None

    url = "https://geocode-maps.yandex.ru/1.x/"
    params = {
        "apikey": key,
        "geocode": address,
        "format": "json"
    }

    response = requests.get(url, params=params)
    if response.status_code == 200:
        try:
            pos = response.json()["response"]["GeoObjectCollection"]["featureMember"][0]["GeoObject"]["Point"]["pos"]
            lon, lat = pos.split()
            return {"lat": float(lat), "lon": float(lon)}
        except Exception as e:
            print(f"Ошибка геокодинга: {e}")
    else:
        print("Ошибка геокодера", response.status_code)
    return None
