from selenium.webdriver.remote.webelement import WebElement

# Takes in an element and the relational xpath to that element as paramters. 
# Returns the element in relation to the element according to the second parameter xpath
# i.e. returns grand parent of element with ../.. as a second argument
def get_element_in_relation_to_element_with_xpath(element: WebElement, xpath):
    return element.find_element_by_xpath(xpath)