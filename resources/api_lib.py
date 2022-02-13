from queue import Empty
import requests
import json

API_ADDRESS = "https://restful-booker.herokuapp.com"

def get_all_bookings():
    ret = requests.get(f"{API_ADDRESS}/booking")
    return ret.json()

def api_is_up():
    ret = requests.get(API_ADDRESS)
    return ret.status_code

def create_booking(details):
    ret = requests.post(f"{API_ADDRESS}/booking", json=json.loads(details), headers={'Content-Type': 'application/json'})
    return ret.status_code, ret.json()["bookingid"]

def get_booking(id):
    try:
        ret = requests.get(f"{API_ADDRESS}/booking/{id}")
        return ret.json()
    except json.JSONDecodeError:
        print(f"Booking with id {id} not found")
        return