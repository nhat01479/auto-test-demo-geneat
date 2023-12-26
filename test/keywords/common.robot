*** Settings ***
Library             Browser
Library             FakerLibrary        locale=en_IN
Library             String
Library    DateTime

*** Variables ***
${BROWSER}          chromium
${HEADLESS}         ${False}
${BROWSER_TIMEOUT}  10 seconds
${SHOULD_TIMEOUT}   0.1 seconds

${URL_DEFAULT}      http://dev1.geneat.vn:7802/#/vn                           #http://localhost:4200/vn
${STATE}            Evaluate    json.loads('''{}''')  json

*** Keywords ***
Login to admin
  Wait Until Element Spin
  Enter "email" in "Email" with "admin@gmail.com"
  Enter "password" in "Mật khẩu" with "123123"
  Click "Đăng nhập" button
  User look message "Success" popup

#### Setup e Teardown
Setup
  Set Browser Timeout         ${BROWSER_TIMEOUT}
  New Browser                 ${BROWSER}  headless=${HEADLESS}
  New Page                    ${URL_DEFAULT}
  ${STATE}                    Evaluate  json.loads('''{}''')  json
Tear Down
  Close Browser               ALL

Wait Until Element Is Visible
  [Arguments]               ${locator}  ${message}=${EMPTY}   ${timeout}=${BROWSER_TIMEOUT}
  Wait For Elements State   ${locator}  visible               ${timeout}                    ${message}

Wait Until Page Does Not Contain Element
  [Arguments]               ${locator}  ${message}=${EMPTY}   ${timeout}=${BROWSER_TIMEOUT}
  Wait For Elements State   ${locator}  detached              ${timeout}                    ${message}

Element Should Be Visible
  [Arguments]               ${locator}  ${message}=${EMPTY}   ${timeout}=${SHOULD_TIMEOUT}
  Wait For Elements State   ${locator}  visible               ${timeout}                    ${message}

Element Text Should Be
  [Arguments]               ${locator}  ${expected}           ${message}=${EMPTY}           ${ignore_case}=${EMPTY}
  Get Text                  ${locator}  equal                 ${expected}                   ${message}

Check Text
  [Arguments]               ${text}
  ${containsS}=             Get Regexp Matches                ${text}                      _@(.+)@_                   1
  ${cntS}=                  Get length                        ${containsS}
  IF  ${cntS} > 0
    ${text}=                Set Variable                      ${STATE["${containsS[0]}"]}
  END
  [Return]    ${text}

###  -----  Form  -----  ###
Get Random Text
  [Arguments]               ${type}                           ${text}
  ${symbol}                 Set Variable                      _RANDOM_
  ${new_text}               Set Variable
  ${containsS}=             Get Regexp Matches                ${text}                       _@(.+)@_                   1
  ${cntS}=                  Get length                        ${containsS}
  ${contains}=              Get Regexp Matches                ${text}                       ${symbol}
  ${cnt}=                   Get length                        ${contains}
  IF  ${cntS} > 0
    ${new_text}=            Set Variable                      ${STATE["${containsS[0]}"]}
    ${symbol}=              Set Variable                      _@${containsS[0]}@_
  ELSE IF  ${cnt} > 0 and '${type}' == 'test name'
    ${random}=              FakerLibrary.Sentence             nb_words=3
    ${words}=               Split String                      ${TEST NAME}                  ${SPACE}
    ${new_text}=            Set Variable                      ${words[0]} ${random}
  ELSE IF  ${cnt} > 0 and '${type}' == 'number'
    ${new_text}=            FakerLibrary.Random Int
    ${new_text}=            Convert To String                 ${new_text}
  ELSE IF  ${cnt} > 0 and '${type}' == 'percentage'
    ${new_text}=            FakerLibrary.Random Int           max=100
    ${new_text}=            Convert To String                 ${new_text}
  ELSE IF  ${cnt} > 0 and '${type}' == 'paragraph'
    ${new_text}=            FakerLibrary.Paragraph
  ELSE IF  ${cnt} > 0 and '${type}' == 'email'
    ${new_text}=            FakerLibrary.Email
  ELSE IF  ${cnt} > 0 and '${type}' == 'phone'
    ${new_text}=            FakerLibrary.Random Int           min=2000000000                max=9999999999
    ${new_text}=            Convert To String                 ${new_text}
    ${new_text}=            Catenate                          SEPARATOR=                    0                           ${new_text}
  ELSE IF  ${cnt} > 0 and '${type}' == 'color'
    ${new_text}=            FakerLibrary.Safe Hex Color
  ELSE IF  ${cnt} > 0 and "${type}" == 'password'
    ${new_text}=            FakerLibrary.Password            10                             True                        True                          True                        True
  ELSE IF  ${cnt} > 0 and '${type}' == 'date'
    ${new_text}=            FakerLibrary.Date  	              pattern=%d-%m-%Y
  ELSE IF  ${cnt} > 0 and '${type}' == 'word'
    ${new_text}=            FakerLibrary.Sentence             nb_words=2
  ELSE IF  ${cnt} > 0
    ${new_text}=            FakerLibrary.Sentence
  END
    ${cnt}=                 Get Length                        ${text}
  IF  ${cnt} > 0
    ${text}=                Replace String                    ${text}                       ${symbol}                   ${new_text}
  END
  [Return]    ${text}

Get Element Form Item By Name
  [Arguments]               ${name}                           ${xpath}=${EMPTY}
  [Return]                  xpath=//*[contains(@class, "ant-form-item-label")]/label[text()="${name}"]/../../*[contains(@class, "ant-form-item")]${xpath}

Required message "${text}" displayed under "${name}" field
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-form-item-explain-error")]
  Element Text Should Be    ${element}                        ${text}

Enter "${type}" in "${name}" with "${text}"
  ${text}=                  Get Random Text                   ${type}                       ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //input[contains(@class, "ant-input")]
  Clear Text                ${element}
  Fill Text                 ${element}                        ${text}                       True
  ${cnt}=                   Get Length                        ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${name}"]}               ${text}
  END
  [Return]    ${text}
Enter "${type}" in textarea "${name}" with "${text}"
  ${text}=                  Get Random Text                   ${type}                       ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //textarea
  Clear Text                ${element}
  Fill Text                 ${element}                        ${text}
  ${cnt}=                   Get Length                        ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${name}"]}               ${text}
  END

Enter date in "${name}" with "${text}"
  ${text}=                  Get Random Text                   date                          ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-picker-input")]/input
  Click                     ${element}
  Clear Text                ${element}
  Fill Text                 ${element}                        ${text}
  Press Keys                ${element}                        Tab
  Press Keys                ${element}                        Tab
  ${cnt}=                   Get Length                        ${text}
  IF  ${cnt} > 0
      Set Global Variable   \${STATE["${name}"]}               ${text}
  END

Click select "${name}" with "${text}"
  ${text}=                  Get Random Text                   Text                          ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-select-show-arrow")]
  Click                     ${element}
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-select-selection-search-input")]
  Fill Text                                                   ${element}                    ${text}
  Click                     xpath=//*[contains(@class, "ant-select-item-option") and @title="${text}"]
  ${cnt}=                   Get Length                        ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${name}"]}               ${text}
  END

Enter "${type}" in editor "${name}" with "${text}"
  ${text}=                  Get Random Text                   ${type}                       ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ce-paragraph")]
  Clear Text                                                  ${element}
  Fill Text                                                   ${element}                    ${text}

Select file in "${name}" with "${text}"
  ${element}=               Get Element Form Item By Name     ${name}                       //input[@type = "file"]
  Upload File By Selector   ${element}                        test/upload/${text}

Click radio "${name}" in line "${text}"
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-radio-button-wrapper")]/span[contains(text(), "${text}")]
  Click                     ${element}

Click switch "${name}" to be activated
  ${element}=               Get Element Form Item By Name     ${name}                       //button[contains(@class, "ant-switch")]
  Click                     ${element}

Click tree select "${name}" with "${text}"
  ${text}=                  Get Random Text                   Text                          ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //*[contains(@class, "ant-tree-select")]
  Click                     ${element}
  Fill Text                 ${element}//input                 ${text}
  Click                     xpath=//*[contains(@class, "ant-select-tree-node-content-wrapper") and @title="${text}"]

Click assign list "${list}"
  ${words}=                 Split String                      ${list}                       ,${SPACE}
  FOR    ${word}    IN    @{words}
    Click                   xpath=//*[contains(@class, "ant-checkbox-wrapper")]/*[text()="${word}"]
  END
  Click                     xpath=//*[contains(@class, "ant-transfer-operation")]/button[2]

###  -----  Table  -----  ###
Get Element Item By Name
  [Arguments]               ${name}                           ${xpath}=${EMPTY}
  [Return]                  xpath=//*[contains(@class, "item-text") and contains(text(), "${name}")]/ancestor::*[contains(@class, "item")]${xpath}

Click on the "${text}" button in the "${name}" item line
  Wait Until Element Spin
  ${name}=                  Check Text                        ${name}
  ${element}=               Get Element Item By Name          ${name}                       //button[@title = "${text}"]
  Click                     ${element}
  Click Confirm To Action

Get Element Table Item By Name
  [Arguments]               ${name}                           ${xpath}
  [Return]                  xpath=//*[contains(@class, "ant-table-row")]//*[contains(text(), "${name}")]/ancestor::tr${xpath}

###  -----  Tree  -----  ###
Get Element Tree By Name
  [Arguments]               ${name}                           ${xpath}=${EMPTY}
  [Return]                  xpath=//*[contains(@class, "ant-tree-node-content-wrapper") and @title = "${name}"]/*[contains(@class, "group")]${xpath}

Click on the previously created "${name}" tree to delete
  Wait Until Element Spin
  ${name}=                  Check Text                        ${name}
  ${element}=               Get Element Tree By Name          ${name}
  Scroll To Element         ${element}
  Mouse Move Relative To    ${element}                        0
  Click                     ${element}//*[contains(@class, "la-trash")]
  Click Confirm To Action

Click on the previously created "${name}" tree to edit
  Wait Until Element Spin
  ${name}=                  Check Text                        ${name}
  ${element}=               Get Element Tree By Name          ${name}
  Click                     ${element}


###  -----  Element  -----  ###
Click "${text}" button
  Click                     xpath=//button[@title="${text}"]
  Click Confirm To Action
  Scroll By                 ${None}

Click "${text}" tab button
  Click                     xpath=//*[contains(@class, "ant-tabs-tab-btn") and contains(text(), "${text}")]

Select on the "${text}" item line
  ${text}=                  Check Text                        ${text}
  Wait Until Element Spin
  ${element}=               Get Element Item By Name          ${text}

  Click                     ${element}


Click "${text}" menu
  Click                     xpath=//li[contains(@class, "menu") and descendant::span[contains(text(), "${text}")]]

Click "${text}" sub menu to "${url}"
  Wait Until Element Spin
  Click                     xpath=//a[contains(@class, "sub-menu") and descendant::span[contains(text(), "${text}")]]
  ${curent_url}=            Get Url
  Should Contain            ${curent_url}                     ${URL_DEFAULT}${url}

User look message "${message}" popup
  ${contains}=              Get Regexp Matches                ${message}                    _@(.+)@_                    1
  ${cnt}=                   Get length                        ${contains}
  IF  ${cnt} > 0
    ${message}=             Replace String                    ${message}                    _@${contains[0]}@_          ${STATE["${contains[0]}"]}
  END
  Wait Until Element Is Visible    id=swal2-html-container
  Element Text Should Be    id=swal2-html-container           ${message}
  ${element}=               Set Variable                      xpath=//*[contains(@class, "swal2-confirm")]
  ${passed}                 Run Keyword And Return Status
                            ...   Element Should Be Visible   ${element}
  IF    '${passed}' == 'True'
        Click               ${element}
  END

Click Confirm To Action
  ${element}                Set Variable                      xpath=//*[contains(@class, "ant-popover")]//*[contains(@class, "ant-btn-primary")]
  ${count}=                 Get Element Count                 ${element}
  IF    ${count} > 0
    Click                   ${element}
    Sleep                   ${SHOULD_TIMEOUT}
  END

Wait Until Element Spin
  Sleep                     ${SHOULD_TIMEOUT}
  ${element}                Set Variable                      xpath=//*[contains(@class, "ant-spin-spinning")]
  ${count}=                 Get Element Count                 ${element}
  IF    ${count} > 0
    Wait Until Page Does Not Contain Element                  ${element}
  END

### --- New --- ###
Click on magnifier icon in search box
  Click                      xpath=//*[contains(@class, "ext-lg las la-search")]

Click on eye icon in "${name}" field 
  ${element}=                Get Element                       //*[contains(@class, "ant-form-item-label")]/label[text()="${name}"]/../../*[contains(@class, "ant-form-item")]//input//ancestor::div[contains(@class, 'relative ng-star-inserted')]     
  Click                      xpath=${element}/i[contains(@class, "la-eye-slash")]  

Click on the left arrow icon 
  ${element}=                Get Element                       //i[contains(@class,'la-arrow-left')]
  Click                      ${element}
  Wait Until Element Spin

Click on "${name}" check box
  ${element}=                Get Element                      //span[contains(text(),"${name}")]//ancestor::label/span[contains(@class,'ant-checkbox')]
  Click                      ${element}

Delete data in "${name}" 
  ${element}                 Get Element Form Item By Name     ${name}                      //input[contains(@class, "ant-input")]
  Clear Text                 ${element}

Enter "${type}" in placeholder "${placeholder}" with "${text}"
  ${text}=                   Get Random Text                   ${type}                       ${text}
  ${element}=                Get Element                       //input[contains(@placeholder, "${placeholder}")]
  Clear Text                 ${element}
  Fill Text                  ${element}                        ${text}
  ${cnt}=                    Get Length                        ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${placeholder}"]}         ${text}
  END

Enter date in placeholder "${name}" with "${date}"
  ${element}=                 Get Element                      //input[contains(@placeholder, "${name}")]
  Clear Text                  ${element}
  ${date}=                    Convert To String                ${date}    
  Fill Text                   ${element}                       ${date}                      True
  Keyboard Key                Press                            Enter
  ${cnt}=                     Get Length                       ${date}
  IF  ${cnt} > 0
    Set Global Variable       \${STATE["${date}"]}              ${date}
  END
  Wait Until Element Spin  

"${name}" should be visible in table line
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  Get Property              //tbody/tr[2]/td[2]/button[1]      innerText                   equal                         ${name}       

"${name}" should not be visible in table line
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  ${count}=                 Count the number account in list
  IF    ${count} > 0
      Get Property          //tbody/tr[2]/td[2]/button[1]      innerText                   inequal                       ${name}       
  ELSE
      Get Text              //tbody/tr[2]                      equal                       No Data
  END

Data's information in "${field}" should be equal "${value}"
  ${value}=                 Check Text                         ${value}        
  ${element}=               Get Element                        //th[contains(text(),"${field}")]//following-sibling::th[1]
  Get Text                  ${element}                         equal                                                     ${value}

Data's information should contain "${name_field}" field 
  ${name_field}=            Check Text                         ${name_field}
  ${element}=               Get Element                        //th[contains(text(),"${name_field}")]
  ${cnt}=                   Get Element Count                  ${element}
  Should Be True            ${cnt} > 0

Profile's information in "${name}" should be equal "${value}"
  ${value}=                 Check Text                         ${value}
  ${element}		            Get Element		                     //label[contains(text(),"${name}")]//parent::div
  Get Text		              ${element}/strong	                 equal			                ${value}

Profile's information should be contained "${name}" field
  ${name}=                  Check Text                         ${name}
  ${element}                Get Element                        //label[contains(text(),"${name}")]
  ${cnt}=                   Get Element Count                  ${element}
  Should Be True            ${cnt} > 0   

Table line should show empty 
  Wait Until Element Spin
  Get Property              //p[contains(@class, 'ant-empty-description')]                innerText                      equal                     No Data 

The hidden password in "${name}" field should be visibled as "${text}"
  ${text}=                  Check Text                         ${text}            
  ${element}=               Get Element                        //*[contains(@class, "ant-form-item-label")]/label[text()="${name}"]/../../*[contains(@class, "ant-form-item")]//input
  Get Property              ${element}                         type                       ==                             text                     
  Get Text                  ${element}                         equal                      ${text}

Click on "${number}" to change the view list
  Click                     xpath=//a[contains(@aria-label, "page ${number}")] 

Click on the "${text}" button in the "${name}" table line
  Wait Until Element Spin
  ${name}=                    Check Text                        ${name}
  IF    '${text}' == 'Chi tiết'
    ${element1}=              Get Element Table Item By Name    ${name}                      //button[@title = "${text}"]
    ${count}=                 Get Element Count                 ${element1}
    IF    ${count} > 0
      Click                   ${element1}
    ELSE
      ${elementS}=            Get Element Table Item By Name    ${name}                      //p[contains(text(),"${name}")]
      Click                   ${elementS}       
    END
  ELSE
    ${element}=               Get Element Table Item By Name    ${name}                      //button[@title = "${text}"]
    Click                     ${element}
  END
  Click Confirm To Action
  
Click Cancel Action
  ${element}                Set Variable                       xpath=//*[contains(@class, "ant-popover")]//button[1]
  ${count}=                 Get Element Count                  ${element}
  IF    ${count} > 0
    Click                   ${element}
    Sleep                   ${SHOULD_TIMEOUT}
  END

Click "${text}" button with cancel action
  Click                     xpath=//button[@title = "${text}"]
  Click Cancel Action
  Scroll By                 ${None}

Click on the "${text}" button in the "${name}" table line with cancel
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  ${element}=               Get Element Table Item By Name     ${name}                    //button[@title = "${text}"]
  Click                     ${element}
  Click Cancel Action

"${name}" table line should be highlighted
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  Get Property              //button[contains(text(),"${name}")]//ancestor::tr            className                      contains                  bg-blue-100    

Log out account
  Click                      //img[contains(@alt,'Avatar')]
  Wait Until Element Spin
  Click                      //li[contains(text(),'Đăng xuất')]
### Related to images ###
Wait Until Image Visible
  ${elementS}= 		          Get Element 			                 //div[contains(@class,'gslide loaded current')]
  Wait For Elements State                                      ${elementS}                visible                    

Click on the "${name}" image
  ${element}=	              Get Element 			                 //p[contains(text(),'${name}')]//following-sibling::div//img
  Click	                    ${element}
  Wait Until Image Visible

Image should be enlarged 	                 
  ${cnt}=	                  Get Element Count			             //img[contains(@class,'zoomable')]
  Should Be True	          ${cnt} > 0

Click on cross button to close image
  ${element}                Get Element                        //button[contains(@aria-label,'Close')]
  Click                     ${element}      

Move to the "${name}" image
  ${element}               Get Element                         //button[contains(@aria-label,'${name}')]
  Click                    ${element}      
  Wait Until Image Visible

# Use for filter function #
Click filter "${name}" with "${text}"
  ${text}=                  Get Random Text                    Text                       ${text}
  ${element}=               Get Element Form Item By Name      ${name}                    //following-sibling::nz-select[contains(@class, "ant-select-show-arrow")]
  Click                     ${element}
  Click                     xpath=//*[contains(@class, "ant-select-item-option") and @title="${text}"]
  ${cnt}=                   Get Length                         ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${name}"]}                ${text}
  END

Click on cross icon in select "${name}" 
  ${element}=               Get Element Form Item By Name      ${name}                    //following-sibling::nz-select[contains(@class, "ant-select-show-arrow")]
  Click                     ${element}
  Click                     xpath=//span[contains(@class, "anticon-close-circle")]/*[1]

# Check the existence of function
Webpage should contains the search function
  ${element}=               Get Element                        //*[contains(@class,'flex-col')]//label[contains(text(),"Tìm kiếm")]
  ${count}=                 Get Element Count                  ${element}
  Should Be True            ${count} >= 1

Webpage should contains the "${name}" filter function
  ${element}=               Get Element                        //*[contains(@class,'flex-col')]//label[contains(text(),"${name}")]
  ${count}=                 Get Element Count                 ${element}
  Should Be True            ${count} >= 1

Heading should contains "${text}" inner Text
    ${elms}=            Get Elements         //h2
    ${elms_length}=     Get Length           ${elms}
    Log To Console    ${elms_length}
    # ${actual_text}=    Get Text    ${elms}[0]
    FOR    ${element}    IN    @{elms}
            ${actual_text}=    Get Text    ${element}
            # Log To Console    ${actual_text}
            Run Keyword If    '${actual_text.strip()}' == '${text}'    Exit For Loop
    END
  # Get Text                  //h2                               equal                      ${text}    

Webpage should contains the list account from database
  ${element}=               Get Element                        //div[contains(@class,'datatable-wrapper')]    
  ${count}=                 Get Element Count                  ${element}
  IF    ${count} > 0
    Set Global Variable     \${STATE["${count}"]}               ${count}
  END    
Confirm adding "${url}" page
  ${current_url}=           Get Url 
  Should Contain            ${current_url}                     ${URL_DEFAULT}${url}/add  

### Relate to number of list page ###
Count the number account in list
  Wait Until Element Spin
  ${element}=                Set Variable                      xpath=//tbody//tr[contains(@class, 'ant-table-row')]
  ${count}=                  Get Element Count                 ${element}
  IF    ${count} > 0
    ${count}=                Convert To Integer                ${count}
    ${countS}                Evaluate                          ${count} + 1
    Set Global Variable      ${LastNum}                        ${countS}
  END
  [Return]                   ${count}
      
Get number account list in last page
  ${element}=                Get Element                       //span[contains(@class, 'ml-3')]
  ${text}=                   Get Text                          ${element}        
  ${pageNum}=                Count the number account in list
  ${total}=                  Get Regexp Matches                ${text}                     của (.+) mục                1 
  ${total}=                  Convert To Integer                ${total[0]}
  ${NumberAcc}=              Evaluate                          ${total} % ${pageNum}  
  ${cnt}=                    Get Length                        ${text}
  IF  ${NumberAcc} > 0
    ${NumberAccount}=        Set Variable                      ${NumberAcc}
  ELSE IF    ${NumberAcc} == 0
    ${NumberAccount}=        Set Variable                      ${pageNum}
  END
  [Return]                   ${NumberAccount}  

Get the number of total account
  ${element}=                Get Element                       //span[contains(@class, 'ml-3')]
  ${text}=                   Get Text                          ${element}
  ${total}=                  Get Regexp Matches                ${text}                     của (.+) mục                1 
  ${total}=                  Convert To Integer                ${total[0]}
  ${cnt}=                    Get Length                        ${text}
  IF  ${cnt} > 0
    ${TotalAccount}=         Set Variable                      ${total}
  END
  [Return]                   ${TotalAccount}

Get the last page number
  ${element}=                Get Element                       //span[contains(@class, 'ml-3')]
  ${text}=                   Get Text                          ${element}        
  ${pageNum}=                Count the number account in list
  ${totalP}=                 Get Regexp Matches                ${text}                     của (.+) mục                1 
  ${totalP}=                 Convert To Integer                ${totalP[0]}
  # ${lastPN}=                 Evaluate                          (${totalP}//${pageNum})+1
  ${lastPN}=                 Evaluate                          ${totalP} % ${pageNum}
  IF         ${lastPN} > 0
       ${lastPN}             Evaluate                      (${totalP}//${pageNum})+1
  ELSE IF    ${lastPN} == 0
       ${lastPN}             Evaluate                      (${totalP}//${pageNum})
  END
  ${cnt}=                    Get Length                        ${text}
  IF  ${cnt} > 0
    ${lastPageNumber}=       Set Variable                      ${lastPN}
    ${lastPageNumber}=       Convert To String                 ${lastPageNumber} 
  END
  [Return]                   ${lastPageNumber}
    
Number account of page
  ${element}=                Get Element                       //span[contains(@class, 'ml-3')]
  ${text}=                   Get Text                          ${element}        
  ${pageNum}=                Get Regexp Matches                ${text}                     -(.+) của                   1
  ${pageNum}=                Set Variable                      ${pageNum[0]}
  ${cnt}=                    Get Length                        ${text}
  IF  ${cnt} > 0
    ${pageNumber}=           Set Variable                      ${pageNum}
  END 
  [Return]                   ${pageNumber}

Check the amount of page list
  ${countA}=                 Count the number account in list
  ${totalA}=                 Get the number of total account
  IF    ${countA} == ${totalA}
    ${amountPage}=           Set Variable                      1
    Log To Console           'This list contains only one page'
  ELSE IF    ${countA} < ${totalA}
    ${amountPage}=           Evaluate                          (${totalA}//${countA})+1        
    ${amountPage}=           Set Variable                      ${amountPage}
  END
  [Return]                   ${amountPage}



### --- List of account navigation --- ###
Move to the "${target}" page
  ${count}=                   Get Length                       ${target}
  IF    '${target}' == 'previous'
      Click                   xpath=//*[contains(@class, "las la-angle-left text-xs ng-star-inserted")]
  ELSE IF    '${target}' == 'next'
      Click                   xpath=//*[contains(@class, "las la-angle-right text-xs ng-star-inserted")]
  ELSE
      ${number}=              Convert To Integer    ${target}
      Click                   xpath=//a[contains(@aria-label, "page ${number}")]
  END
  Wait Until Element Spin

Move to the last page and check
  Wait Until Element Spin
  ${countS}=                  Get number account list in last page
  ${number}=                  Get the last page number
  IF    ${countS} == 0
        ${number}=            Convert To Integer               ${number}
        ${number}             Set Variable                    ${number - 1}
        ${number}=            Convert To String               ${number}
  END
  Move to the "${number}" page
  Wait Until Element Spin
  ${elementS}=                Set Variable                     xpath=//tbody//tr[contains(@class, 'ant-table-row')]
  ${count}=                   Get Element Count                ${elementS}
  ${count}=                   Convert To Integer               ${count}
  Should Be Equal             ${count}                         ${countS}         

# Click on "${ordinal}" selection to change the number of account show in list and check
#   ${cnt}=                       Get Length                      ${ordinal}        
#   IF        ${cnt} > 3 and '${ordinal}' == 'first'
#     ${select}=                  Set Variable                    1
#   ELSE IF   ${cnt} > 3 and '${ordinal}' == 'second'
#     ${select}=                  Set Variable                    2  
#   ELSE IF   ${cnt} > 3 and '${ordinal}' == 'third'
#     ${select}=                  Set Variable                    3  
#   ELSE IF   ${cnt} > 3 and '${ordinal}' == 'fourth'
#     ${select}=                  Set Variable                    4
#   ELSE IF   ${cnt} > 3 and '${ordinal}' == 'fifth'
#     ${select}=                  Set Variable                    5
#   ELSE
#     ${select}=                  Convert To Integer              ${ordinal}
#   END
#   ${amountPage}=                Check the amount of page list
#   ${text_current}=              Get Text                        //*[contains(@class, 'ant-select-selection-item')]
#   ${current}=                   Get Regexp Matches              ${text_current}                          (.+) / page                    1
#   ${current_number}=            Set Variable                    ${current[0]}
#   ${current_number}             Convert To Integer              ${current_number}
#   Click                         xpath=//*[contains(@class, 'ant-select-selection-item')]
#   ${text_select}=               Get Text                        //nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]      
#   ${select_string}=             Get Regexp Matches              ${text_select}                           (.+) / page                    1
#   ${select_number}=             Set Variable                    ${select_string[0]}
#   ${select_number}=             Convert To Integer              ${select_number}    
#   IF                            ${amountPage} >= 2
#     IF                          ${current_number} < ${select_number}
#       Move to the "next" page
#       ${name}=                  Get the first account name
#       ${ordinal_before}=        Evaluate                        ${current_number} + 2
#       Click                     xpath=//*[contains(@class, 'ant-select-selection-item')]
#       Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
#       Get Text                  //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]        equal                       ${name}
#     ELSE IF                     ${current_number} > ${select_number}
#       ${ordinal_before}=        Evaluate                        ${select_number} + 2
#       ${name}=                  Get Text                        //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]
#       Click                     xpath=//*[contains(@class, 'ant-select-selection-item')]
#       Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
#       Move to the "next" page
#       ${nameS}=                 Get the first account name
#       Should Be Equal           ${nameS}                         ${name}
#       Move to the "previous" page
#     ELSE IF                     ${current_number} = ${select_number}
#       Click                     xpath=//*[contains(@class, 'ant-select-selection-item')]
#       Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]        
#     END    
#   ELSE IF                       ${amountPage} < 2 
#     IF                          ${current_number} <= ${select_number}
#       Click                     xpath=//*[contains(@class, 'ant-select-selection-item')]
#       Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
#     ELSE IF                     ${current_number} > ${select_number}
#       ${account_number}=        Count the number account in list
#       IF       ${account_number} > ${select_number}
#         ${ordinal_before}=      Evaluate                         ${select_number} + 2
#         ${name}=                Get Text                         //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]
#         Click                   xpath=//*[contains(@class, 'ant-select-selection-item')]
#         Click                   xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
#         Move to the "next" page
#         ${nameS}=               Get the first account name
#         Should Be Equal         ${nameS}                         ${name}
#         Move to the "previous" page
#       ELSE IF    ${account_number} <= ${select_number}
#         Click                   xpath=//*[contains(@class, 'ant-select-selection-item')]
#         Click                   xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]   
#       END    
#     END
#   END
#   Wait Until Element Spin

### --- Get the account name --- ###
Get the last account name
  ${pageN}=                   Count the number account in list
  ${number}=                  Evaluate                         ${pageN}+1
  ${element}=                 Get Element                      //tbody//tr[${number}]//button[contains(@title,"Chi tiết")]
  ${LAname}=                  Get Text                         ${element}
  ${cnt}=                     Get Length                       ${LAname}
  IF   ${cnt} > 0
    Set Global Variable       ${LAname}                        ${LAname} 
  END
  [Return]                    ${LAname}

Get the first account name
  ${element}=                 Get Element                      //tbody//tr[2]//button[contains(@title,"Chi tiết")]
  ${Fname}=                   Get Text                         ${element}
  ${cnt}=                     Get Length                       ${Fname}
  IF   ${cnt} > 0
    ${Fname}=                 Set Variable                     ${Fname}
  END
  [Return]                    ${Fname}

# My keyword -----------------------------------------------------------------------------------

# Confirm locating exactly in "${text}" page
#   ${actual_text}=       Get Text               //span[@class='font-medium ng-star-inserted']
#   Should Contain        ${actual_text}         ${text}

Confirm locating exactly in "${name}" page
  Wait Until Element Spin
  ${cnt}=                 Get Element Count                      //header//span[contains(text(),"${name}")]
  Should Be True    ${cnt} > 0
Webpage should contains "${text}" input field
  ${element}=               Get Element                        //*[contains(@class,'ant-form-item')]//label[contains(text(),"${text}")]
  ${count}=                 Get Element Count                 ${element}
  Should Be True            ${count} >= 1

Webpage should contain "${title}" button
  ${actual_title}=       Get Text               //button[@title='${title}']
  # Should Be Equal        ${actual_title}        ${title}                    strip_spaces=True

Get data in the last row
  # ${element}=                Set Variable                        xpath=//tr[contains(@class, 'ant-table-row')]
  ${count}=                  Count the number account in list
  ${name}=                   Get Text                            //tbody//tr[contains(@class, 'ant-table-row')][${count}]//td//button[contains(@title,"Chi tiết")]
  [RETURN]                   ${name}
Get data in the first row
  # ${element}=                Set Variable                       xpath=//tr[contains(@class, 'ant-table-row')]
  ${count}=                  Count the number account in list
  ${name}=                   Get Text                          //tbody//tr[contains(@class, 'ant-table-row')][1]//td//button[contains(@title,"Chi tiết")]
  [RETURN]                   ${name}

Countttttt
    
  ${element}=               Set Variable                      xpath=//tbody//tr[contains(@class, 'ant-table-row')]
  ${count}=                 Get Element Count                 ${element}
  ${x}=                     Count the number account in list
  ${text}=                  Get Text                          //tbody//tr[contains(@class, 'ant-table-row')][1]//td//button[contains(@title,"Chi tiết")]

  Log To Console    'Hello: ${text} - ${count} - ${x}'

# ---------------------------

Webpage should contain "${text}" field
    ${element}=               Get Element                        //div[contains(@class,'h-14')]//span[contains(text(),"${text}")]

List category should contain "${text}" button  
  ${actual_text}=       Get Text        //button[contains(@class, 'item')]//span[contains(text(),"${text}")]
  # Should Be Equal        ${text}        ${actual_text}                    strip_spaces=True

Webpage should contains the list service from database
  ${element}=               Get Element                        //div[contains(@class,'datatable-wrapper')]    
  ${count}=                 Get Element Count                  ${element}
  IF    ${count} > 0
    Set Global Variable     \${STATE["${count}"]}               ${count}
  END 


Webpage should contains the list data from database
  ${element}=               Get Element                        //div[contains(@class,'datatable-wrapper')]    
  ${count}=                 Get Element Count                  ${element}
  IF    ${count} > 0
    Set Global Variable     \${STATE["${count}"]}               ${count}
  END 

Webpage should contains the list category from database
  ${element}=               Get Element                        //div[contains(@class,'h-[calc(100vh-170px)]')]    
  ${count}=                 Get Element Count                  ${element}
  IF    ${count} > 0
    Set Global Variable     \${STATE["${count}"]}               ${count}
  END 


"${name}" item line should be highlighted
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  Get Property              //span[contains(text(),"${name}")]//ancestor::button            className                      contains                  bg-blue-100    

"${name}" should be visible in item line
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  ${text}                   Get Text                           //span[contains(text(),"${name}")]//ancestor::button             
  Should Contain            ${text}                            ${name}    

"${name}" should not be visible in item line
  Wait Until Element Spin
  ${name}=                  Check Text                         ${name}
  ${elements}=              Get Elements                       //button[contains(@class,"item")]//span[contains(@class,'item-text')]  
  ${count}=                 Get Length                         ${elements}
  IF    ${count} > 0
      ${text}               Get Text                           ${elements}[0]  
      Should Not Contain    ${text}                            ${name} 
  ELSE
        Get Text            //div[contains(@class,"h-14")]//span    equal    No Data    
  END  
Webpage should contain left arrow icon
    ${element}=               Get Element                        //i[contains(@class,'la-arrow-left')]  
     ${count}=                Get Element Count                  ${element}
    IF    ${count} > 0
      Set Global Variable     \${STATE["${count}"]}               ${count}
    END 

# Click on the "${text}" button in the "${name}" item line with cancel
#   Wait Until Element Spin
#   ${name}=                  Check Text                         ${name}
#   ${element}=               Get Element Table Item By Name     ${name}                    //button[@title = "${text}"]
#   Click                     ${element}
#   Click Cancel Action

Click on the "${text}" button in the "${name}" item line with cancel
  Wait Until Element Spin
  ${name}=                  Check Text                        ${name}
  ${element}=               Get Element Item By Name          ${name}                       //button[@title = "${text}"]
  Click                     ${element}
  Click Cancel Action


Click on "${ordinal}" selection to change the number of account show in list and check
  ${cnt}=                       Get Length                      ${ordinal}        
  IF        ${cnt} > 3 and '${ordinal}' == 'first'
    ${select}=                  Set Variable                    1
  ELSE IF   ${cnt} > 3 and '${ordinal}' == 'second'
    ${select}=                  Set Variable                    2  
  ELSE IF   ${cnt} > 3 and '${ordinal}' == 'third'
    ${select}=                  Set Variable                    3  
  ELSE IF   ${cnt} > 3 and '${ordinal}' == 'fourth'
    ${select}=                  Set Variable                    4
  ELSE IF   ${cnt} > 3 and '${ordinal}' == 'fifth'
    ${select}=                  Set Variable                    5
  ELSE
    ${select}=                  Convert To Integer              ${ordinal}
  END
  ${amountPage}=                Check the amount of page list

  ${elms}=    Get Elements    //*[contains(@class, 'ant-select-selection-item')]
  ${text_current}=    Set Variable    ${EMPTY}
  ${elmm}=    Set Variable    ${EMPTY}
  FOR    ${element}    IN    @{elms}
      ${text_current}=    Get Text    ${element}
      ${elmm}=    Set Variable    ${element}

      Run Keyword If  'page' in '${text_current}'    Exit For Loop   
  END
  # ${text_current}=              Get Text                        //*[contains(@class, 'ant-select-selection-item')]
  ${current}=                   Get Regexp Matches              ${text_current}                          (.+) / page                    1
  ${current_number}=            Set Variable                    ${current[0]}
  ${current_number}             Convert To Integer              ${current_number}
  Click                         ${elmm}
  ${text_select}=               Get Text                        //nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]      
  ${select_string}=             Get Regexp Matches              ${text_select}                           (.+) / page                    1
  ${select_number}=             Set Variable                    ${select_string[0]}
  ${select_number}=             Convert To Integer              ${select_number}    
  IF                            ${amountPage} >= 2
    IF                          ${current_number} < ${select_number}
      Move to the "next" page
      ${name}=                  Get the first account name
      ${ordinal_before}=        Evaluate                        ${current_number} + 2
      Click                      ${elmm}
      Wait Until Element Spin
      Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
      Wait Until Element Spin
      Get Text                  //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]        equal                       ${name}
    ELSE IF                     ${current_number} > ${select_number}
      ${ordinal_before}=        Evaluate                        ${select_number} + 2
      ${name}=                  Get Text                        //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]
      Click                      ${elmm}
      Wait Until Element Spin
      Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
      Wait Until Element Spin
      Move to the "next" page
      ${nameS}=                 Get the first account name
      Should Be Equal           ${nameS}                         ${name}
      Move to the "previous" page
    ELSE IF                     ${current_number} = ${select_number}
      Click                      ${elmm}
      Wait Until Element Spin
      Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]        
    END    
  ELSE IF                       ${amountPage} < 2 
    IF                          ${current_number} <= ${select_number}
      Click                      ${elmm}
      Click                     xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
    ELSE IF                     ${current_number} > ${select_number}
      ${account_number}=        Count the number account in list
      IF       ${account_number} > ${select_number}
        ${ordinal_before}=      Evaluate                         ${select_number} + 2
        ${name}=                Get Text                         //tbody//tr[${ordinal_before}]//button[contains(@title,"Chi tiết")]
        Click                    ${elmm}
        Click                   xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]
        Move to the "next" page
        ${nameS}=               Get the first account name
        Should Be Equal         ${nameS}                         ${name}
        Move to the "previous" page
      ELSE IF    ${account_number} <= ${select_number}
        Click                    ${elmm}
        Click                   xpath=//nz-option-item[${select}]/div[contains(@class,'ant-select-item-option-content')]   
      END    
    END
  END
  Wait Until Element Spin

Enter "${type}" in "${name}" of "${tab}" tab with "${text}"
  ${text}=                  Get Random Text                   ${type}                       ${text}
  ${element}=               Get Element Form Item By Name     ${name}                       //input[contains(@class, "ant-input")]
  Clear Text                ${element}
  Fill Text                 ${element}                        ${text}                       True
  ${cnt}=                   Get Length                        ${text}
  IF  ${cnt} > 0
    Set Global Variable     \${STATE["${name}"]}               ${text}
  END
  [Return]    ${text}