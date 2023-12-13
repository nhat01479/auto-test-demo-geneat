*** Settings ***
Resource            ../keywords/common.robot
# Resource            category.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down


*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Category page ###
DA_01 Verify that navigating to the right "Data" page
    [Tags]    MainPage    ui    smoketest
    Login to admin
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Quản lý dữ liệu" sub menu to "/data"
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    # Then Heading of separated group should contain "Tất cả dữ liệu" inner Text
    Then Webpage should contains the search function
    Then Webpage should contain "Thêm mới dữ liệu" button
    Then Webpage should contains the list data from database
DA_02 Verify the function changing the number of data show in each list
    [Tags]    MainPage    ui    smoketest
    Go to "Quản lý dữ liệu" page
    When Click on "second" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "fifth" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "second" selection to change the number of account show in list and check

DA_03 Verify that highlight after clicking on it
    [Tags]    MainPage    ui    smoketest
    Go to "Quản lý dữ liệu" page
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click "Đóng lại" button
    Then "_@Tiêu đề@_" table line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_04 Verify the function navigating to other lists of data page
    [Tags]    MainPage    ui    smoketest
    Go to "Quản lý dữ liệu" page
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Move to the "next" page
    When Move to the "previous" page
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line 
    When Move to the last page and check
    When Click on the "Xóa" button in the "_@Tên loại@_" item line   

### Verify the creating data type function			

DA_05 Verify "Thêm mới dữ liệu" button function
    [Tags]    create
    Create a category
    # Select on the "_@Tên loại@_" item line
    When Click "Thêm mới dữ liệu" button
    Then Heading should contains "Thêm mới dữ liệu" inner Text
    Then Confirm adding account "/data" page
    # Then Heading of separated group should contain "Thông tin" inner Text
    Then Webpage should contains "Chuyên mục" input field
    Then Webpage should contains "Thứ tự" input field
    Then Webpage should contains "Thứ tự" input field
    Then Webpage should contains "Thứ tự" input field
    Then Webpage should contains "Thứ tự" input field
    Then Webpage should contain left arrow icon
    # Then Webpage should contain "Tải lên" button
    # Then Webpage should contain "Dán ảnh" button
    Then Webpage should contain "Lưu lại" button
    Then Webpage should contain "Đóng lại" button
    # Then Heading of separated group should contain "Hình ảnh" inner Text   
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_06 Create new data with the valid data
    [Tags]    create
    Create a category
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
DA_07 Check the update of data list after creating a new data
    [Tags]    create
    Create a category
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Success" popup
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
### Create new data with blank field			
DA_08 Create new data with blank fields
    [Tags]    create    blankField
    Go to page create data "Quản lý dữ liệu" with "/data"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn chuyên mục" displayed under "Chuyên mục" field
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
DA_09 Create a new data when leaving "Chuyên mục" field blank
    [Tags]    create    blankField
    # Create a category 
    Go to page create data "Quản lý dữ liệu" with "/data"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    When Click "Lưu lại" button    
    Then Required message "Xin vui lòng chọn chuyên mục" displayed under "Chuyên mục" field

DA_10 Create a new data when leaving "Tiêu đề" field blank
    [Tags]    create    blankField
    Create a category 
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    When Click "Lưu lại" button    
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field

DA_11 Verify that CAN create a new data when leaving a blank field in "Thứ tự"
    [Tags]    create    blankField
    Create a category 
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line  
DA_12 Verify that CAN create a new data when leaving a blank field in "Mô tả"
    [Tags]    create    blankField
    Create a category 
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line  

DA_13 Verify that CAN create a new data when leaving a blank field in "Nội dung"
    [Tags]    create    blankField
    Create a category 
    Select on the "${STATE["Tên loại"]}" item line
    When Click "Thêm mới dữ liệu" button
    When Click select "Chuyên mục" with "_@Tên loại@_"
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"  
    When Click "Lưu lại" button
    Then User look message "Success" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

### Verify the go back function of buttons in Creating data type page		
DA_14 Verify the "Đóng lại" button
    [Tags]    create    blankField
    Go to page create data "Quản lý dữ liệu" with "/data"
    When Click "Đóng lại" button
    When Confirm locating exactly in "Quản lý dữ liệu" page
    When Webpage should contains the search function
    When Webpage should contain "Thêm mới dữ liệu" button
    When Webpage should contains the list data from database    

DA_15 Verify the left arrow icon ("Trở lại" button)
    [Tags]    create    blankField
    Go to page create data "Quản lý dữ liệu" with "/data"
    When Click on the left arrow icon
    When Confirm locating exactly in "Quản lý dữ liệu" page
    When Webpage should contains the search function
    When Webpage should contain "Thêm mới dữ liệu" button
    When Webpage should contains the list data from database 

DA_16 Verify the "Trở lại" (left arrow icon) button
    [Tags]    create    blankField
    Go to page create data "Quản lý dữ liệu" with "/data"
    When Click "Trở lại" button
    When Confirm locating exactly in "Quản lý dữ liệu" page
    When Webpage should contains the search function
    When Webpage should contain "Thêm mới dữ liệu" button
    When Webpage should contains the list data from database 

### Verify the funtion of changing data information
DA_17 Verify the changing "Chuyên mục" field
    [Tags]    changeInfo
    ${Category1}=    Create a category
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click select "Chuyên mục" with "${Category1}"
    When Click "Lưu lại" button
    Then User look message "Cập nhật thành công" popup
    When Select on the "${Category1}" item line
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
    When Click on the "Xóa" button in the "${Category1}" item line

DA_18 Verify the changing "Tiêu đề" field
     [Tags]    changeInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật thành công" popup
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line    

DA_19 Verify the changing "Thứ tự" field
    [Tags]    changeInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "number" in "Thứ tự" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật thành công" popup
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    # Then Data's information in "Thứ tự" should be equal "_@Thứ tự@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_20 Verify the changing "Mô tả" field
    [Tags]    changeInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "text" in textarea "Mô tả" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật thành công" popup
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    # Then Data's information in "Mô tả" should be equal "_@Thứ tự@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_21 Verify the changing "Nội dung" field
    [Tags]    changeInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Enter "text" in textarea "Nội dung" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật thành công" popup
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    # Then Data's information in "Nội dung" should be equal "_@Thứ tự@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

### Verify the go back function of buttons in change information's page
DA_22 Check the "Đóng lại" button in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contain "Thêm mới dữ liệu" button
    Then Webpage should contains the list data from database
    Then "_@Tiêu đề@_" item line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
DA_23 Check the left arrow icon ("Trở lại" button) in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click on the left arrow icon
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contain "Thêm mới dữ liệu" button
    Then Webpage should contains the list data from database
    Then "_@Tiêu đề@_" item line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
DA_24 Check the "Trở lại" (left arrow icon) button in edit infomation page
    [Tags]    changeInfo    button
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Sửa" button in the "_@Tiêu đề@_" table line
    When Click "Trở lại" button
    Then Confirm locating exactly in "Quản lý dữ liệu" page
    Then Webpage should contain "Thêm mới dữ liệu" button
    Then Webpage should contains the list data from database
    Then "_@Tiêu đề@_" item line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line
### Verify the User Interface of detail information's account page		
DA_25 Verify that navigating to the right "edit data" page
    [Tags]    DetailedInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    Then Heading should contains "Chỉnh sửa dữ liệu" inner Text
    Then Webpage should contains "Chuyên mục" input field
    Then Webpage should contains "Tiêu đề" input field
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_26 Check data information after creation
    [Tags]    DetailedInfo
    Create a category
    Create a test data with "_@Tên loại@_" type
    When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    # Then Data's information in "Chuyên mục" should be equal "_@Tên loại@_"
    # Then Data's information in "Thứ tự" should be equal "_@Thứ tư@_"
    # Then Data's information in "Tiêu đề" should be equal "_@Tiêu đề@_"
    # Then Data's information in "Mô tả" should be equal "_@Mô tả@_"
    # Then Data's information in "Nội dung" should be equal "_@Nội dung@_"
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

### Verify the delete data type function
DA_27 Verify the delete data function
    [Tags]    delete
    Create a category
    Create a test data with "_@Tên loại@_" type
    # When Select on the "${STATE["Tên loại"]}" item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    Then User look message "Xóa thành công" popup
    Then "_@Tiêu đề@_" should not be visible in item line
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

DA_28 Verify the cancel action button when delete data
    [Tags]    delete
    Create a category
    Create a test data with "_@Tên loại@_" type
    # When Select on the "${STATE["Tên loại"]}" item line
    # When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
    # When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line with cancel
    Then "_@Tiêu đề@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
    Then User look message "Xóa thành công" popup
    When Click on the "Xóa" button in the "_@Tên loại@_" item line

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

Create a test data with "_@Tên loại@_" type
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Quản lý dữ liệu" page
    IF    '${condition}' == 'True'
        Click "Thêm mới dữ liệu" button
    ELSE
        Go to page create data "Quản lý dữ liệu" with "/data"
    END
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Click select "Chuyên mục" with "_@Tên loại@_"
    Enter "number" in "Thứ tự" with "_RANDOM_"   
    Enter "paragraph" in textarea "Mô tả" with "_RANDOM_"
    Enter "paragraph" in textarea "Nội dung" with "_RANDOM_"  
    Click "Lưu lại" button
    User look message "Success" popup
    RETURN    ${name}

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

Go to page create category "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới" button

Heading of separated group should contain "${text}" inner Text
  ${actual_text}            Get Text                  //*[contains(@class,'sm:h-14')]//span[contains(@class, 'ng-star-inserted')]                          
  Should Be Equal           ${text}                   ${actual_text}
