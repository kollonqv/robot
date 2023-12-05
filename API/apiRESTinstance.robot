*** Settings ***
Documentation     Tests an API for demonstration purposes, uses Robot Framework's RESTinstance

Library           Collections
Library           JSONLibrary
Library           REST    https://restful-booker.herokuapp.com
Library           ../resources/RequireTest.py
Library           ../resources/ApiLib.py


Suite Setup    Set Headers    ${headers}
*** Variables ***
${booking}              {"firstname" : "Jim", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : 
...                     {"checkin" : "2018-01-01", "checkout" : "2019-01-01"}, "additionalneeds" : "Breakfast"}
${booking_updated}      {"firstname" : "Peter", "lastname" : "Pan", "totalprice" : 222, "depositpaid" : false, "bookingdates" : 
...                     {"checkin" : "2018-02-02", "checkout" : "2019-02-02"}, "additionalneeds" : "Lunch"}    
${headers}              {"Content-Type": "application/json", "Accept": "application/json"}
${auth}                 {"username": "admin", "password": "password123"}


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

Delete Booking
    [Setup]    Require Test Case    Create Booking
    Given Api Is Available
    When Previously Created Booking Can Be Deleted
    Then Booking Is Not Found    ${booking_id}

*** Keywords ***
Api Is Available
    GET    /
    ${response}  Output
    Log to Console     response code: ${response}[response][status]
    Should Be Equal As Strings    ${response}[response][status]    200

Log Bookings
    GET    /booking
    ${response}    Output
    Set Test Variable    ${bookings}    ${response}[response][body]
    Log To Console    ${bookings}

Booking Is Created
    POST    /booking    ${booking}
    ${response}  Output
    Log To Console    ${response}[response][body]
    Set Test Variable    ${booking_id}    ${response}[response][body][bookingid]
    Log To Console    Created booking with id: ${booking_id}
    Should Be Equal As Strings   ${response}[response][status]    200    "Creating booking failed"

Booking Is Found
    GET    /booking/${booking_id}
    ${response}    Output
    Should Not Be Equal    ${response}[response][body]    Not Found    "Booking with id ${booking_id} not found"
    Set Suite Variable    ${booking_id}

Previously Created Booking Can Be Updated
    Set Auth Header
    PUT    /booking/${booking_id}    ${booking_updated}
    ${response}    Output
    Should Be Equal As Strings   ${response}[response][status]    200    "Booking ${booking_id} could not be updated"

Previously Created Booking Can Be Deleted
    Set Auth Header
    DELETE    /booking/${booking_id}
    ${response}    Output
    Should Be Equal As Strings   ${response}[response][status]    201    "Booking ${booking_id} could not be deleted"

Booking Is Not Found
    [Arguments]    ${id}
    GET    /booking/${id}
    ${response}    Output
    Should Be Equal    ${response}[response][body]    Not Found    "Booking with id ${booking_id} was found"
    Set Suite Variable    ${booking_id}

    
# Helpers
Set Auth Header
    ${token}    Authenticate
    Log To Console    ${token}
    Log To Console    ${token}[token]
    ${auth_header}    Add Token To Header    ${token}
    Set Headers    ${auth_header}

Authenticate
    POST    /auth    ${auth}
    ${response}    Output
    [Return]    ${response}[response][body]

Add Token To Header
    [Arguments]    ${token}
    &{token_dict}    Create Dictionary    Cookie=token=${token}[token]
    ${headers_json}    Convert String to JSON	${headers}
    ${json}    Add Object To Json	${headers_json} 	$	 ${token_dict}
    ${auth_header}    Convert JSON to String    ${json}
    Log To Console    new header with auth: ${auth_header}
    [Return]    ${auth_header}

