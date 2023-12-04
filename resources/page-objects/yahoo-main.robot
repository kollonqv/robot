*** Settings ***
Library    SeleniumLibrary
Resource    ../common_resources.robot

*** Variables ***
# Locators
${mail link}    id:ybar-navigation-item-mail

# Text Values

# Other Variables
${yahoo title text}    Yahoo | Mail, Weather, Search, News, Finance, Sports, Shopping, Entertainment, Video


*** Keywords ***
Yahoo Page Is Open
    Title Should Be    ${yahoo title text}

Clicking ${link}
    Click Element    ${link}