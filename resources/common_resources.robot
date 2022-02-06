*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}           Chrome
${URL}               https://www.yahoo.com/

*** Keywords ***
Init Browser
    Open Browser                ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Button                agree