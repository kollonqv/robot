*** Settings ***
Library    SeleniumLibrary
Library    chromedriversync.py

*** Variables ***
${BROWSER}           Chrome
${URL}               https://ca.yahoo.com/

*** Keywords ***
Init Browser
    ${chromedriver_path}=   Get Chromedriver Path
    Open Browser                url=${URL}    browser=${BROWSER}    executable_path=${chromedriver_path}
    Maximize Browser Window