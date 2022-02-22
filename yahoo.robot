*** Settings ***
Documentation       Navigate to Yahoo Shopping and take screenshots of of all the discounts over 70 percent off

Library             SeleniumLibrary
Library             String
Library             Collections
Library             resources/element.py
Variables           resources/locators.py
Variables           resources/text.py
Resource            resources/common_resources.robot

Suite Setup         Run Keywords    Init Browser
...                 AND             Set Screenshot Directory    ${CURDIR}/screenshots
Suite Teardown      Close Browser

*** Test Cases ***
# Does not test anything in itself as there are no assertions.
# However, will fail if elements are not found etc.
Get Screenshots Of Deals In Yahoo Shopping
    Given Yahoo Page Is Open
    When Shopping Is Opened
    Then Select All Deals Over 70 Percent Off
    And Take Screenshot Of The Deals
    And Log Product Information Of The Deals

*** Keywords ***
Yahoo Page Is Open
    Title Should Be    ${YAHOO_TITLE_TEXT}

Shopping Is Opened
    Click Link    ${SHOPPING_LOCATOR}
    Title Should Be    ${SHOPPING_TITLE_TEXT}

Select All Deals Over ${percentage} Percent Off
    Wait Until Page Contains Element    ${COUPONS_LOCATOR}    5
    @{deals}    Create List
    ${discounts}    Get WebElements    ${COUPONS_LOCATOR}
    FOR    ${element}    IN    @{discounts}
        ${txt}    Get Text    ${element}
        ${number_as_string}    Get Regexp Matches    ${txt}    \\d+
        ${number}    Convert To Integer    @{number_as_string}
        IF    ${number} >= ${percentage}
            Append To List    ${deals}    ${element}
        END
    END
    Set Test Variable    ${deals}

Take Screenshot Of The Deals
    FOR    ${deal}    IN    @{deals}
        Log    ${deal}
        ${coupon}    Get Element In Relation To Element With Xpath    ${deal}    ../..
        Capture Element Screenshot    ${coupon}
    END

Log Product Information Of The Deals
    FOR    ${deal}    IN    @{deals}
        Click Element    ${deal}
        Wait Until Page Contains Element    ${PRODUCT_INFORMATION_LOCATOR}    5
        ${productin_formation}    Get Element Attribute    ${PRODUCT_INFORMATION_LOCATOR}    innerText
        Log    ${product information}
        Wait Until Page Contains Element    ${PRODUCT_INFROMATION_CLOSE_BUTTON_LOCATOR}    5
        Click Element    ${PRODUCT_INFROMATION_CLOSE_BUTTON_LOCATOR}
    END
