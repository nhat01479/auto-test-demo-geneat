*** Settings ***
Resource            ../keywords/common.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down
 

*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Category page ###
CA_01 Verify that navigating to the right "Category Data" page
    [Tags]    mainpage    ui    smoketest
    Login to admin
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Quản lý dữ liệu" sub menu to "/data"
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Heading of separated group should contain "Chuyên mục" inner Text
    Then Webpage should contain "Tạo mới" button
    Then Webpage should contains the list category from database
CA_02 Verify that highlight category line after clicking on it
    [Tags]    mainpage    ui    smoketest
    Go to "Quản lý dữ liệu" page
    When Click "Tạo mới" button
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    When Select on the "${STATE["Tên loại"]}" item line
    Then "${STATE["Tên loại"]}" item line should be highlighted
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

### Verify the creating data type function			
CA_03 Verify "Tạo mới" button function
    [Tags]    create      smoketest
    Go to "Quản lý dữ liệu" page
    When Click "Tạo mới" button
    Then Heading should contains "Thêm mới chuyên mục" inner Text
    Then Confirm adding account "/data/type" page 
    Then Heading should contains "Thông tin" inner Text
    # Then Heading of separated group should contain "Thông tin" inner Text
    Then Webpage should contains "Tên loại" input field
    Then Webpage should contains "Mã" input field 
    Then Webpage should contain "Lưu lại" button
    Then Webpage should contain "Đóng lại" button
    Then Webpage should contain left arrow icon

CA_04 Create new data type with the valid data
    [Tags]    create      smoketest
    Go to page create category "Quản lý dữ liệu" with "/data"         
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

CA_05 Check the update of data list after creating a new categories
    [Tags]    create      smoketest    
    Go to page create category "Quản lý dữ liệu" with "/data"         
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    Then "_@Tên loại@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

### Create new data with blank field

CA_06 Create a new data with all blank fields
    [Tags]    create      blankfield    
    Go to page create category "Quản lý dữ liệu" with "/data"         
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tên loại" displayed under "Tên loại" field
    Then Required message "Xin vui lòng nhập mã" displayed under "Mã" field
CA_07 Create a new data when leaving "Tên loại" field blank
    [Tags]    create      blankfield    
    Go to page create category "Quản lý dữ liệu" with "/data"         
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tên loại" displayed under "Tên loại" field

CA_08 Create a new data when leaving "Mã" field blank
    [Tags]    create      blankfield    
    Go to page create category "Quản lý dữ liệu" with "/data"         
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mã" displayed under "Mã" field

### Create new data with invalid data
CA_09 Create a new data with the existence of "Tên loại"
    [Tags]    create    invalidData
    Create a category
    When Click "Tạo mới" button
    When Enter "test name" in "Tên loại" with "_@Tên loại@_"
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Tên danh mục đã tồn tại" popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

CA_10 Create a new data with the invalid "Mã"
    [Tags]    create    invalidData
    ${name}=     Create a category
    When Click "Tạo mới" button
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Enter "number" in "Mã" with "_@Mã@_"
    When Click "Lưu lại" button
    Then User look message "Code đã tồn tại" popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "${name}" item line
### Verify the go back function of buttons in Creating page
CA_11 Check the "Đóng lại" button
    [Tags]    create    button
    Go to page create category "Quản lý dữ liệu" with "/data"
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

CA_12 Check the left arrow icon ("Trở lại" button)
    [Tags]    create    button
    Go to page create category "Quản lý dữ liệu" with "/data"
    When Click on the left arrow icon
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

CA_13 Check the (left arrow icon) "Trở lại" button
    [Tags]    create    button
    Go to page create category "Quản lý dữ liệu" with "/data"
    When Click "Trở lại" button
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

### Verify the funtion of changing data information
CA_14 Verify the changing "Tên loại" field
    [Tags]    changeInfo
    Create a category
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    When Enter "test name" in "Tên loại" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    Then "_@Tên loại@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
CA_15 Verify the changing "Mã" field
    [Tags]                                                                        ChangeInfo 
    Create a category
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    When Enter "number" in "Mã" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    # Then Data's information in "Mã" should be equal "_@Mã@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
CA_16 Verify the changing with the existed "Tên loại"
    [Tags]    changeInfo
    ${category}=       Create a category
    Create a category
    When Click on the "Sửa" button in the "${category}" item line
    When Enter "test name" in "Tên loại" with "_@Tên loại@_"
    When Click "Lưu lại" button
    Then User look message "Tên danh mục đã tồn tại" popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    When Click on the "Xóa" button in the "${category}" item line

CA_17 Verify the changing with the existed "Mã"
    [Tags]    changeInfo
    ${category}=       Create a category
    Create a category
    When Click on the "Sửa" button in the "${category}" item line
    When Enter "number" in "Mã" with "_@Mã@_"
    When Click "Lưu lại" button
    Then User look message "Code đã tồn tại" popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    When Click on the "Xóa" button in the "${category}" item line

### Verify the go back function of buttons in change information's page
CA_18 Check the "Đóng lại" button in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list account from database
    Then Webpage should contain "Tạo mới" button

CA_19 Check the left arrow icon ("Trở lại" button) in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    When Click on the left arrow icon
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list account from database
    Then Webpage should contain "Tạo mới" button

CA_20 Check the (left arrow icon) "Trở lại" button in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    When Click on the "Sửa" button in the "_@Tên loại@_" item line
    When Click on the left arrow icon
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contains the list account from database
    Then Webpage should contain "Tạo mới" button

### Verify the delete data function
CA_21 Verify the delete data function
    [Tags]                                                                                     Delete                                                                        
    Create a category
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    Then User look message "Success" popup
    Then "_@Tên loại@_" should not be visible in item line

CA_22 Verify the cancel action button when delete data
    [Tags]                                                                                     Delete                                                                        
    Create a category
    When Click on the "Xóa" button in the "_@Tên loại@_" item line with cancel
    Then "_@Tên loại@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
CT_23 Check to delete category that still having data inside
    [Tags]                                                                                     Delete                                                                        
    Create a category
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"
    When Click "Lưu lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    Then User look message "Danh mục có dữ liệu không thể xóa" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
*** Keywords ***

Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Quản lý dữ liệu'
        Click "Quản lý dữ liệu" sub menu to "/data"
    END
Go to page create category "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới" button

Create a category
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Quản lý dữ liệu" page
    IF    '${condition}' == 'True'
        Click "Tạo mới" button
    ELSE
        Go to page create category "Quản lý dữ liệu" with "/data"
    END
    Enter "test name" in "Tên loại" with "_RANDOM_"
    ${text}=    Check Text    _@Tên loại@_
    ${name}=    Set Variable    ${text}
    Enter "number" in "Mã" with "_RANDOM_"
    Click "Lưu lại" button
    User look message "Success" popup
    RETURN    ${name}

Heading of separated group should contain "${text}" inner Text
  ${actual_text}            Get Text                  //div[contains(@class,'h-14')]//span[contains(text(),"${text}")]                         
  Should Contain            ${text}                   ${actual_text}



