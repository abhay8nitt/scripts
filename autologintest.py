import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options


def login(url,username,password):
    options = Options()
    options.add_argument("--headless")
    driver= webdriver.Chrome(options=options)
    driver.get(url)
    #Enter the username in the text box
    usernameText=driver.find_element_by_name("username")
    usernameText.send_keys(username)

    #Enter the password in the text box
    passwordText=driver.find_element_by_name("password")
    passwordText.send_keys(password)

    #Sign in
    buttons=driver.find_elements_by_xpath("//*[contains(text(), 'Sign In')]")
    for aButton in buttons:
        aButton.click()

    time.sleep(10)
    text=driver.title
    print(text)
    if text.find("Search Tab Text") == -1:
        print ("Failed login to:", url)
    else:
        print("Successful login to: ",url)



def test_logins():
    fh = open('urls.txt')
    for line in fh:
        print ("Attempting login to: ",line)
        login(line, "uname","password")
    fh.close()

#Add all the urls in urls.txt and run the python program
#Dependecy - selenium

if __name__ == "__main__":
    test_logins()
