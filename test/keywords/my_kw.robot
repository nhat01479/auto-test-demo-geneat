# *** Settings ***
# Library             Browser
# Library             FakerLibrary        locale=en_IN
# Library             String

# *** Variables ***
# ${BROWSER}          chromium
# ${HEADLESS}         ${False}
# ${BROWSER_TIMEOUT}  10 seconds
# ${SHOULD_TIMEOUT}   0.1 seconds

# ${URL_DEFAULT}      http://dev1.geneat.vn:7802/#/vn                           #http://localhost:4200/vn
# ${STATE}            Evaluate    json.loads('''{}''')  json

*** Keywords ***
# Confirm locating exactly in "${text}" page
#   ${actual_text}=       Get Text              //span[@class='font-medium ng-star-inserted']
#   Should Be Equal       ${actual_text}        ${text}                                        strip_spaces=True

