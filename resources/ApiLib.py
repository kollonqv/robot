import requests
import json

class ApiLib:
    
    def __init__(self, api_address="https://restful-booker.herokuapp.com"):
        self._api_address = api_address
        self._header = {"Content-Type": "application/json", "Accept": "application/json"}

    def get_all_bookings(self):
        ret = requests.get(f"{self._api_address}/booking")
        return ret.json()

    def api_is_up(self):
        ret = requests.get(self._api_address)
        return ret.status_code

    def create_booking(self, details):
        ret = requests.post(f"{self._api_address}/booking", json=json.loads(details), headers=self._header)
        return ret.status_code, ret.json()["bookingid"]

    def get_booking(self, id):
        try:
            ret = requests.get(f"{self._api_address}/booking/{id}")
            return ret.json()
        except json.JSONDecodeError:
            print(f"Booking with id {id} not found")
            return
    
    def update_booking(self, id, updated_details):
        self._header.update({"Cookie": "token="+self._authenticate()["token"]})
        ret = requests.put(f"{self._api_address}/booking/{id}", json=json.loads(updated_details), headers=self._header)
        return ret.status_code

    def _authenticate(self):
        ret = requests.post(f"{self._api_address}/auth", json={"username": "admin", "password": "password123"}, headers=self._header)
        return ret.json()