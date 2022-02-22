*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}           Chrome
${URL}               https://www.yahoo.com/

*** Keywords ***
Init Browser
    ${list} =     Create List    --disable-dev-shm-usage    --disable-gpu    --disable-software-rasterizer    --headless
    ${args} =     Create Dictionary    args=${list}
    ${desired caps} =     Create Dictionary     chromeOptions=${args}
    Open Browser                ${URL}    ${BROWSER}    desired_capabilities=${desired caps}
    Maximize Browser Window
    Click Button                agree