*** Settings ***
Documentation     Get booking information from a test API
Library           resources/api_lib.py
Library           Collections
Variables         resources/api_lib.py

*** Variables ***
${booking}          {"firstname" : "Jim", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : 
...                 {"checkin" : "2018-01-01", "checkout" : "2019-01-01"}, "additionalneeds" : "Breakfast"}


*** Test Cases ***
Log All Bookings
    Given Api Is Available
    Then Log Bookings

Create Booking
    Given Api Is Available
    When Booking Is Created
    Then Booking Is Found

*** Keywords ***
Log Bookings
    ${bookings}   Get All Bookings
    Log     ${bookings}

Api Is Available
    ${return_code}  Api Is Up
    Should Be Equal As Strings   "${return_code}"    "200"        "Api at ${API_ADDRESS} not available"

Booking Is Created
    ${return_code}    ${booking_id}    Create Booking    ${booking}
    Set Test Variable    ${booking_id}
    Should Be Equal As Strings   "${return_code}"    "200"    "Creating booking failed"

Booking Is Found
    ${booking}    Get Booking    ${booking_id}
    Should Not Be Equal    ${booking}    ${None}    "Booking with id ${booking_id} not found"