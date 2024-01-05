*** Settings ***
Resource            ../keywords/common.robot
# Resource            category.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down


*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Code-Types page ###
CODE_01 Verify that navigating to the right "Danh mục" page
    Login to admin
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Danh mục" sub menu to "/code-types"
    Then Confirm locating exactly in "Danh mục" page
    Then Heading of separated group should contain "Loại danh mục" inner Text
    Then "Nhóm thủ thuật" should be visible in item line
    Then "Độ khó" should be visible in item line
    Then "Bằng cấp chuyên môn" should be visible in item line
    Then "Số răng" should be visible in item line
    Then Heading of separated group should contain "Nhóm thủ thuật" inner Text
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới" button
    Then Webpage should contains the list data from database
CODE_02 Verify the function changing the number of data show in each list
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click on "second" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "fifth" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "second" selection to change the number of account show in list and check   

CODE_03 Verify that highlight after clicking on it
    Go to "Danh mục" page
    When Select on the "Nhóm thủ thuật" item line
    Then "Nhóm thủ thuật" item line should be highlighted
    When Select on the "Độ khó" item line
    Then "Độ khó" item line should be highlighted
    When Select on the "Bằng cấp chuyên môn" item line
    Then "Bằng cấp chuyên môn" item line should be highlighted
    When Select on the "Số răng" item line  
    Then "Số răng" item line should be highlighted  
CODE_04 Verify the function navigating to other lists of data page
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    Then Check the amount of page list
    ${Last_name}=    Get the last account name
    Create a test data with "Nhóm thủ thuật" type
    When Move to the "next" page
    ${First_name}=    Get the first account name
    Then Should Be Equal    ${First_name}    ${Last_name}
    When Move to the "previous" page
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line 
    When Move to the last page and check
### Verify the creating data function			
CODE_05 Verify "Thêm mới Nhóm thủ thuật" button function
    Go to "Danh mục" page
    ${text}=    Select on the "Nhóm thủ thuật" item line
    Click "Thêm mới" button
    Heading should contains "Thêm mới ${text}" inner Text
    Confirm adding "/code-types/MEDICAL_PROCEDURE_GROUP" page
    Webpage should contains "Tiêu đề" input field
    Webpage should contains "Thứ tự" input field
    Webpage should contains "Mã" input field
    Webpage should contains "Mô tả" input field
CODE_05 Verify "Thêm mới Độ khó" button function
    Go to "Danh mục" page
    ${text}=    Select on the "Độ khó" item line
    Click "Thêm mới" button
    Heading should contains "Thêm mới ${text}" inner Text
    Confirm adding "/code-types/MEDICAL_PROCEDURE_DIFFICULTY" page
    Webpage should contains "Tiêu đề" input field
    Webpage should contains "Thứ tự" input field
    Webpage should contains "Mã" input field
    Webpage should contains "Mô tả" input field
CODE_05 Verify "Thêm mới Bằng cấp chuyên môn" button function
    Go to "Danh mục" page
    ${text}=    Select on the "Bằng cấp chuyên môn" item line
    Click "Thêm mới" button
    Heading should contains "Thêm mới ${text}" inner Text
    Confirm adding "/code-types/MEDICAL_DEGREE" page
    Webpage should contains "Tiêu đề" input field
    Webpage should contains "Thứ tự" input field
    Webpage should contains "Mã" input field
    Webpage should contains "Mô tả" input field
CODE_05 Verify "Thêm mới Số răng" button function
    Go to "Danh mục" page
    ${text}=    Select on the "Số răng" item line
    Click "Thêm mới" button
    Heading should contains "Thêm mới ${text}" inner Text
    Confirm adding "/code-types/NUMBER_OF_TEETH" page
    Webpage should contains "Tiêu đề" input field
    Webpage should contains "Thứ tự" input field
    Webpage should contains "Mã" input field
    Webpage should contains "Mô tả" input field
CODE_06 Create new data with the valid data
    Go to "Danh mục" page
    When Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "word" in "Mã" with "MP__RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    Click on the "Xóa" button in the "_@Tiêu đề@_" table line
CODE_07 Check the update of data list after creating a new data   
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "word" in "Mã" with "MP__RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
### Create new data with blank field
CODE_08 Create a new data with all blank fields
    Go to "Danh mục" page
    When Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
    Then Required message "Xin vui lòng nhập mã" displayed under "Mã" field

CODE_09 Create a new data when leaving "Tiêu đề" field blank
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "word" in "Mã" with "MP__RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
CODE_10 Create a new data when leaving "Mã" field blank
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mã" displayed under "Mã" field
CODE_11 Verify that CAN create a new data when leaving a blank field in "Thứ tự"
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "word" in "Mã" with "MP__RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
CODE_12 Verify that CAN create a new data when leaving a blank field in "Mô tả"
    Go to "Danh mục" page
    Select on the "Nhóm thủ thuật" item line
    When Click "Thêm mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "word" in "Mã" with "MP__RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup

### Create new data with invalid data
CODE_13 Create a new data with the existence of "Mã"
  Create a test data with "Nhóm thủ thuật" type
  When Select on the "Nhóm thủ thuật" item line
  When Click "Thêm mới" button
  When Enter "test name" in "Tiêu đề" with "_RANDOM_"
  When Enter "number" in "Thứ tự" with "_RANDOM_"
  When Enter "word" in "Mã" with "_@Mã@_"
  When Click "Lưu lại" button
  Then User look message "Code đã tồn tại" popup

### Verify the go back function of buttons in Creating data page		
CODE_14 Verify the "Đóng lại" button
  Go to "Danh mục" page
  When Select on the "Nhóm thủ thuật" item line
  When Click "Thêm mới" button
  When Click "Đóng lại" button 
  Then Confirm locating exactly in "Danh mục" page
  Then Heading of separated group should contain "Loại danh mục" inner Text
  Then "Nhóm thủ thuật" should be visible in item line
  Then "Độ khó" should be visible in item line
  Then "Bằng cấp chuyên môn" should be visible in item line
  Then "Số răng" should be visible in item line
  Then Heading of separated group should contain "Nhóm thủ thuật" inner Text
  Then "Nhóm thủ thuật" item line should be highlighted
  Then Webpage should contains the search function
  Then Webpage should contain "Thêm mới" button
  Then Webpage should contains the list data from database
     
CODE_15 Verify the left arrow icon ("Trở lại" button)
  Go to "Danh mục" page
  When Select on the "Nhóm thủ thuật" item line
  When Click "Thêm mới" button
  When Click on the left arrow icon
  Then Confirm locating exactly in "Danh mục" page
  Then Heading of separated group should contain "Loại danh mục" inner Text
  Then "Nhóm thủ thuật" should be visible in item line
  Then "Độ khó" should be visible in item line
  Then "Bằng cấp chuyên môn" should be visible in item line
  Then "Số răng" should be visible in item line
  Then Heading of separated group should contain "Nhóm thủ thuật" inner Text
  Then "Nhóm thủ thuật" item line should be highlighted
  Then Webpage should contains the search function
  Then Webpage should contain "Thêm mới" button
  Then Webpage should contains the list data from database
CODE_16 Verify the "Trở lại" (left arrow icon) button
  Go to "Danh mục" page
  When Select on the "Nhóm thủ thuật" item line
  When Click "Thêm mới" button
  When Click "Trở lại" button
  Then Confirm locating exactly in "Danh mục" page
  Then Heading of separated group should contain "Loại danh mục" inner Text
  Then "Nhóm thủ thuật" should be visible in item line
  Then "Độ khó" should be visible in item line
  Then "Bằng cấp chuyên môn" should be visible in item line
  Then "Số răng" should be visible in item line
  Then Heading of separated group should contain "Nhóm thủ thuật" inner Text
  Then "Nhóm thủ thuật" item line should be highlighted
  Then Webpage should contains the search function
  Then Webpage should contain "Thêm mới" button
  Then Webpage should contains the list data from database
### Verify the funtion of changing data information	
CODE_17 Verify the changing "Tiêu đề" field
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line

CODE_18 Verify the changing "Thứ tự" field
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
# CODE_19 Verify the changing "Mã" field
#     Create a test data with "Nhóm thủ thuật" type
#     When Select on the "Nhóm thủ thuật" item line
#     When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
#     When Enter "word" in "Mã" with "_RANDOM_"
#     When Click "Lưu lại" button
#     Then User look message "Success" popup
#     When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
CODE_20 Verify the changing "Mô tả" field
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
# CODE_21 Verify the changing with the existed "Mã"	
#     ${title_1}=    Create a test data with "Nhóm thủ thuật" type
#     ${title_2}=    Create a test data with "Nhóm thủ thuật" type
#     When Select on the "Nhóm thủ thuật" item line
#     When Click on the "Sửa" button in the "${title_1}" table line
#     When Enter "word" in "Mã" with "_@Mã@_"
#     When Click "Lưu lại" button
#     Then User look message "Success" popup
#     When Click on the "Xóa" button in the "${title_2}" table line
#     When Click on the "Xóa" button in the "${title_1}" table line

### Verify the go back function of buttons in change information's page
CODE_22 Check the "Đóng lại" button in edit infomation page
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Danh mục" page
    Then Heading of separated group should contain "Loại danh mục" inner Text
    Then "Nhóm thủ thuật" should be visible in item line
    Then "Độ khó" should be visible in item line
    Then "Bằng cấp chuyên môn" should be visible in item line
    Then "Số răng" should be visible in item line
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới" button
    Then Webpage should contains the list data from database
    Then "Nhóm thủ thuật" item line should be highlighted
    Then "_@Tiêu đề@_" table line should be highlighted    
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
CODE_23 Check the left arrow icon ("Trở lại" button) in edit infomation page
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click on the left arrow icon
    Then Confirm locating exactly in "Danh mục" page
    Then Heading of separated group should contain "Loại danh mục" inner Text
    Then "Nhóm thủ thuật" should be visible in item line
    Then "Độ khó" should be visible in item line
    Then "Bằng cấp chuyên môn" should be visible in item line
    Then "Số răng" should be visible in item line
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới" button
    Then Webpage should contains the list data from database
    Then "Nhóm thủ thuật" item line should be highlighted
    Then "_@Tiêu đề@_" table line should be highlighted    
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line

CODE_24 Check the "Trở lại" (left arrow icon) button in edit infomation page
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click "Trở lại" button
    Then Confirm locating exactly in "Danh mục" page
    Then Heading of separated group should contain "Loại danh mục" inner Text
    Then "Nhóm thủ thuật" should be visible in item line
    Then "Độ khó" should be visible in item line
    Then "Bằng cấp chuyên môn" should be visible in item line
    Then "Số răng" should be visible in item line
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới" button
    Then Webpage should contains the list data from database
    Then "Nhóm thủ thuật" item line should be highlighted
    Then "_@Tiêu đề@_" table line should be highlighted    
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
### Verify the User Interface of detail information's page	
CODE_25 Verify that navigating to the right "edit data" page	
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    When Click "Trở lại" button
    Then Heading of separated group should contain "Loại danh mục" inner Text
    Then "Nhóm thủ thuật" should be visible in item line
    Then "Độ khó" should be visible in item line
    Then "Bằng cấp chuyên môn" should be visible in item line
    Then "Số răng" should be visible in item line
    Then Heading of separated group should contain "Nhóm thủ thuật" inner Text
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới" button
    Then Webpage should contains the list data from database
    Then "Nhóm thủ thuật" item line should be highlighted
    Then "_@Tiêu đề@_" table line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
CODE_26 Check data information after creation
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    Then Data's information in "Tiêu đề" should be equal "_@Tiêu đề@_"
    Then Data's information in "Thứ tự" should be equal "_@Thứ tự@_"
    Then Data's information in "Mã" should be equal "_@Mã@_"
    Then Data's information in "Mô tả" should be equal "_@Mô tả@_"
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line

### Verify the delete data type function
CODE_ Verify the delete data function
    Create a test data with "Số răng" type
    # When Select on the "Nhóm thủ thuật" item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    Then User look message "Đã xóa thành công" popup
    Then "_@Tiêu đề@_" should not be visible in item line

CODE_ Verify the cancel action button when delete data
    Create a test data with "Nhóm thủ thuật" type
    When Select on the "Nhóm thủ thuật" item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line with cancel
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    Then User look message "Đã xóa thành công" popup

*** Keywords ***

Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Danh mục'
        Click "Danh mục" sub menu to "/code-types"
    END
Go to page create data "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "Danh mục" sub menu to "/code-types"
    IF    '${url}' == '/MEDICAL_PROCEDURE_GROUP'
        Select on the "Nhóm thủ thuật" item line
    ELSE IF    '${url}' == '/MEDICAL_PROCEDURE_DIFFICULTY'
        Select on the "Độ khó" item line
    ELSE IF    '${url}' == '/MEDICAL_DEGRE'
        Select on the "Bằng cấp chuyên môn" item line
    ELSE IF    '${url}' == '/NUMBER_OF_TEETH'
        Select on the "Số răng" item line
    END
    Click "Thêm mới" button

Create a test data with "${type}" type  
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Danh mục" page
    IF    '${condition}' == 'True'
        Select on the "${type}" item line
        Click "Thêm mới" button
    ELSE
        IF    '${type}' == 'Nhóm thủ thuật'
            Go to page create data "Danh mục" with "/MEDICAL_PROCEDURE_GROUP"
        END
        IF    '${type}' == 'Độ khó'
            Go to page create data "Danh mục" with "/MEDICAL_PROCEDURE_DIFFICULTY"
        END
        IF    '${type}' == 'Bằng cấp chuyên môn'
            Go to page create data "Danh mục" with "/MEDICAL_DEGRE"
        END
        IF    '${type}' == 'Số răng'
            Go to page create data "Danh mục" with "/NUMBER_OF_TEETH"
        END
    END
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Enter "number" in "Thứ tự" with "_RANDOM_"
    Enter "word" in "Mã" with "_RANDOM_"
    Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    Click "Lưu lại" button
    User look message "Success" popup
    RETURN    ${name}


Go to page create code-types "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Thêm mới" button
