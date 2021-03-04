*** Settings ***
Documentation     Navigate to Yahoo and log product information
Library           SeleniumLibrary
Library           String
Library           Collections

Test Teardown    Close Browser

*** Variables ***
${BROWSER}           Chrome
${URL}               https://www.yahoo.com/
${YAHOO TITLE}       Yahoo
${SHOPPING TITLE}    Yahoo Shopping - We'll track the prices for you!


*** Test Cases ***
Check Yahoo
    Given Browser To Yahoo Page Is Opened
    When Shopping Is Opened
    Then Select All Deals Over Thirty Percent Off
    And Log The List Of Deals
    And Log The Product Information Of One Item 


*** Keywords ***
Browser To Yahoo Page Is Opened
    Open Browser                ${URL}    ${BROWSER}
    Maximize Browser Window
    Click Button                agree
    Title Should Be             ${YAHOO TITLE} 

Shopping Is Opened

    Click Link          xpath=//*[@id="ybar-navigation"]/div/ul/li[8]/a
    Title Should Be     ${SHOPPING TITLE}

Select All Deals Over Thirty Percent Off
    Sleep    5
    @{deals}=    Create List
    ${elements}   Get WebElements    xpath://p[contains(@class,"promotionTag ellipsis")]
    FOR     ${el}    IN    @{elements}
        ${txt}=    Get Text    ${el}
        ${number as string}=     Get Regexp Matches  ${txt}   \\d+
        ${number}=  Convert To Integer  @{number as string}
        Run Keyword If    ${number} >= 30 
        ...    Append To List   ${deals}    ${el}
    END
    Set Test Variable    ${deals}

Log The List Of Deals
    Log     ${deals}

Log The Product Information Of One Item 
    Click Element    ${deals}[0]
    Sleep   5
    ${product information}=   Get Element Attribute	    xpath://div[contains(@class, "CouponItem__Description")]    innerText
    Log         ${product information}