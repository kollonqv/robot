import requests

API_ADDRESS = "https://restful-booker.herokuapp.com"

def get_all_bookings():
    ret = requests.get(API_ADDRESS + "/booking")
    return ret.json()

def api_is_up():
    ret = requests.get(API_ADDRESS)
    return ret.status_code