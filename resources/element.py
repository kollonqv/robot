from selenium.webdriver.remote.webelement import WebElement

def get_element_in_relation_to_element_with_xpath(element: WebElement, xpath):
    return element.find_element_by_xpath(xpath)