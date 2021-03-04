import requests

API_ADDRESS = "https://restful-booker.herokuapp.com/booking"

def get_all_bookings():
    response = requests.get(API_ADDRESS)
    return response.json()


if __name__ == "__main__":
    print(get_all_bookings().json())