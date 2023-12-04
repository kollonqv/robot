*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Locators
${mail title}    //*[@class="challenge-heading"]
${sign in button}    //*[@class="fuji-button-link fuji-button-inverted signin"]

# Text Values
${mail title text}    Sign in to Yahoo Mail

*** Keywords ***
Mail Sign In Has Correct Text
    Wait Until Page Contains Element    ${mail title}
    ${text}    Get Text    ${mail title}
    Should Be Equal As Strings    ${text}    ${mail title text}