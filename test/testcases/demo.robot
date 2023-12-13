*** Settings ***
Resource            ../keywords/common.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down
 

*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Category page ###
DA_01 Verify that navigating to the right "Data" page
    [Tags]    mainpage    ui    smoketest
        Login to admin
        When Click "QUẢN LÝ DANH MỤC" menu
        When Click "Quản lý dữ liệu" sub menu to "/data"
        Confirm locating exactly in "Quản lý dữ liệu" page
        Heading of separated group should contain "Tất cả dữ liệu" inner Text
        Webpage should contains the search function
        Webpage should contain "Thêm mới dữ liệu" button
        Webpage should contains the list data from database
DA_03 Verify the function changing the number of data show in each list
    [Tags]    mainpage    ui    smoketest
        Go to "Quản lý dữ liệu" page
        When Click on "second" selection to change the number of account show in list and check
        When Click on "third" selection to change the number of account show in list and check
        When Click on "fourth" selection to change the number of account show in list and check
        When Click on "fifth" selection to change the number of account show in list and check

DA_05 Verify the function navigating to other lists of account page
    [Tags]    mainpage    ui    smoketest
    Go to "Quản lý dữ liệu" page
    Then Check the amount of page list
    ${Last_name}=    Get the last account name
    Create new data with the valid data
    When Move to the "next" page
    ${First_name}=    Get the first account name
    Then Should Be Equal    ${First_name}    ${Last_name}
    When Move to the "previous" page
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    Then Move to the last page and check
DA_22 Check the update of data list after creating a new account
    [Tags]    create    smoketest
    Create new data with the valid data
    Then "_@Tiêu đề@_" should be visible in table line
    Then Click on the "Xóa" button in the "_@Tiêu đề@_" table line

*** Keywords ***

Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Quản lý dữ liệu'
        Click "Quản lý dữ liệu" sub menu to "/data"
    END
Go to page create data "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Thêm mới dữ liệu" button

Create new data with the valid data
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Quản lý dữ liệu" page
    IF    '${condition}' == 'True'
        Click "Thêm mới dữ liệu" button
    ELSE
        Go to page create data "Quản lý dữ liệu" with "/data"
    END
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Click select "Chuyên mục" with "HSBC"
    Enter "number" in "Thứ tự" with "_RANDOM_"   
    Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    Click "Lưu lại" button
    User look message "Success" popup
    RETURN    ${name}

Heading of separated group should contain "${text}" inner Text
  ${actual_text}            Get Text                  //*[contains(@class,'sm:h-14')]//span[contains(@class, 'ng-star-inserted')]                          
  Should Be Equal           ${text}                   ${actual_text}
