from webdriver_manager.chrome import ChromeDriverManager

def get_chromedriver_path():
    driver_path = ChromeDriverManager().install()
    print(driver_path)
    return  driver_path