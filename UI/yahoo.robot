*** Settings ***
Documentation       Check that the main links from Yahoo navigate to the correct place

Library             SeleniumLibrary    timeout=5   implicit_wait=3   run_on_failure=Capture Page Screenshot
Library             String
Library             Collections
Resource            ../resources/common_resources.robot
Resource            ../resources/page-objects/yahoo-main.robot
Resource            ../resources/page-objects/yahoo-mail.robot

Suite Setup         Run Keywords    Init Browser
...                 AND             Set Screenshot Directory    ${CURDIR}/screenshots
Suite Teardown      Close Browser

Test Teardown       Capture Page Screenshot

*** Test Cases ***
Mail Link Navigation Works
    Given Yahoo Page Is Open
    When Navigating to Mail Sign In Page
    Then Mail Sign In Has Correct Text

*** Keywords ***
Navigating to Mail Sign In Page
    Clicking ${mail link}
    Click Element    ${sign in button}