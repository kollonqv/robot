*** Settings ***
Documentation     Get booking information from a test API
Library           resources/api_lib.py

*** Test Cases ***
Log All Bookings
    Given Api Is Available
    Then Log Bookings

*** Keywords ***
Log Bookings
    ${bookings}=   Get All Bookings
    Log     ${bookings}

Api Is Available
    ${ret}  Api Is Up
    Should Be Equal As Strings   "${ret}"    "200"