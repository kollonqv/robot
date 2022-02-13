*** Settings ***
Documentation     Tests an API for demonstration purposes

Library           Collections
Library           resources/RequireTest.py
Library           resources/ApiLib.py

*** Variables ***
${booking}              {"firstname" : "Jim", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : 
...                     {"checkin" : "2018-01-01", "checkout" : "2019-01-01"}, "additionalneeds" : "Breakfast"}
${booking_updated}      {"firstname" : "Peter", "lastname" : "Pan", "totalprice" : 222, "depositpaid" : false, "bookingdates" : 
...                     {"checkin" : "2018-02-02", "checkout" : "2019-02-02"}, "additionalneeds" : "Lunch"}

*** Test Cases ***
Log All Bookings
    Given Api Is Available
    Then Log Bookings

Create Booking
    Given Api Is Available
    When Booking Is Created
    Then Booking Is Found

Update Booking
    [Setup]    Require Test Case    Create Booking
    Given Api Is Available
    Then Previously Created Booking Can Be Updated

*** Keywords ***
Log Bookings
    ${bookings}   Get All Bookings
    Log     ${bookings}

Api Is Available
    ${return_code}  Api Is Up
    Should Be Equal As Strings   "${return_code}"    "200"        "Api not available"

Booking Is Created
    ${return_code}    ${booking_id}    Create Booking    ${booking}
    Set Test Variable    ${booking_id}
    Should Be Equal As Strings   "${return_code}"    "200"    "Creating booking failed"

Booking Is Found
    ${booking}    Get Booking    ${booking_id}
    Should Not Be Equal    ${booking}    ${None}    "Booking with id ${booking_id} not found"
    Set Suite Variable    ${booking_id}

Previously Created Booking Can Be Updated
    ${return_code}    Update Booking    ${booking_id}    ${booking_updated}
    Should Be Equal As Strings   "${return_code}"    "200"    "Booking ${booking_id} could not be updated"