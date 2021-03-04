*** Settings ***
Documentation     Get booking information from a test API
Library           ApiLib.py

*** Test Cases ***
Log All Bookings
    Log Bookings

*** Keywords ***
Log Bookings
    ${bookings}=   Get All Bookings
    Log     ${bookings}