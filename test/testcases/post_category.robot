*** Settings ***
Resource            ../keywords/common.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down
 

*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Category page ###
PC_01 Verify that navigating to the right "Post Category" page
    [Tags]    mainpage    ui    smoketest
    Login to admin
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Post" sub menu to "/post"
    Then Confirm locating exactly in "Post" page
    Then Heading of separated group should contain "Chuyên mục" inner Text
    Then Webpage should contain "Tạo mới" button
    Then Webpage should contains the list category from database
PC_02 Verify that highlight category line after clicking on it
    [Tags]    mainpage    ui    smoketest
    Go to "Post" page
    When Click "Tạo mới" button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    When Select on the "${STATE["Tiêu đề"]}" item line
    Then "${STATE["Tiêu đề"]}" item line should be highlighted
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

### Verify the creating post type function		
PC_03 Verify "Tạo mới" button function
    [Tags]    create      smoketest
    Go to "Post" page
    When Click "Tạo mới" button
    Then Heading should contains "Tạo mới bài viết" inner Text
    Then Confirm adding "/post/categories" page 
    Then Heading should contains "Thông tin" inner Text
    # Then Heading of separated group should contain "Thông tin" inner Text
    Then Webpage should contains "Tiêu đề" input field
    Then Webpage should contains "Giới thiệu" input field 
    Then Webpage should contain "Lưu lại" button
    Then Webpage should contain "Đóng lại" button
    Then Webpage should contain left arrow icon

PC_04 Create new post type with the valid data
    [Tags]    create      smoketest
    Go to page create category "Post" with "/post"         
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Thêm mới danh mục bài viết thành công" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

PC_05 Check the update of data list after creating a new categories
    [Tags]    create      smoketest    
    Go to page create category "Post" with "/post"         
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Thêm mới danh mục bài viết thành công" popup
    Then "_@Tiêu đề@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

### Create new post with blank field

PC_06 Create a new data with all blank fields
    [Tags]    create      blankfield    
    Go to page create category "Post" with "/post"         
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
PC_07 Create a new data when leaving "Tiêu đề" field blank
    [Tags]    create      blankfield    
    Go to page create category "Post" with "/post"
    When Enter "word" in "Slug" with "_RANDOM_"         
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field

PC_08 Create a new data when leaving "Slug" field blank
    [Tags]    create      blankfield    
    Go to page create category "Post" with "/post"         
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Thêm mới danh mục bài viết thành công" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
PC_09 Create a new data when leaving "Giới thiệu" field blank
    [Tags]    create      blankfield    
    Go to page create category "Post" with "/post"         
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Thêm mới danh mục bài viết thành công" popup
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line   
### Create new data with invalid data
PC_10 Create a new data with the existence of "Tiêu đề"
    [Tags]    create    invalidData
    Create a test post_category
    When Click "Tạo mới" button
    When Enter "test name" in "Tiêu đề" with "_@Tiêu đề@_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Tiêu đề đã tồn tại" popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

### Verify the go back function of buttons in Creating page
PC_11 Check the "Đóng lại" button
    [Tags]    create    button
    Go to page create category "Post" with "/post"
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

PC_12 Check the left arrow icon ("Trở lại" button)
    [Tags]    create    button
    Go to page create category "Post" with "/post"
    When Click on the left arrow icon
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

PC_13 Check the (left arrow icon) "Trở lại" button
    [Tags]    create    button
    Go to page create category "Post" with "/post"
    When Click "Trở lại" button
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list category from database
    Then Webpage should contain "Tạo mới" button

### Verify the funtion of changing data information
PC_14 Verify the changing "Tiêu đề" field
    [Tags]    changeInfo
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật bài viết thành công" popup
    Then "_@Tiêu đề@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
PC_15 Verify the changing "Slug" field
    [Tags]  ChangeInfo 
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Enter "word" in "Slug" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật bài viết thành công" popup
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    # Then Data's information in "Slug" should be equal "_@Slug@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
PC_16 Verify the changing "Giới thiệu" field
    [Tags]  ChangeInfo 
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Cập nhật bài viết thành công" popup
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    # Then Data's information in "Giới thiệu" should be equal "_@Giới thiệu@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
# PC_17 Verify the changing with the existed "Tiêu đề"
#     [Tags]    changeInfo
#     ${category}=       Create a test post_category
#     Create a test post_category
#     When Click on the "Sửa" button in the "${category}" item line
#     When Enter "test name" in "Tiêu đề" with "_@Tiêu đề@_"
#     When Click "Lưu lại" button
#     Then User look message "Tiêu đề đã tồn tại" popup
#     When Click "Đóng lại" button
#     When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
#     When Click on the "Xóa" button in the "${category}" item line


### Verify the go back function of buttons in change information's page
PC_18 Check the "Đóng lại" button in edit infomation page
    [Tags]    changeInfo    button
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list data from database
    Then Webpage should contain "Tạo mới" button

PC_19 Check the left arrow icon ("Trở lại" button) in edit infomation page
    [Tags]    changeInfo    button
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Click on the left arrow icon
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list account from database
    Then Webpage should contain "Tạo mới" button

PC_20 Check the (left arrow icon) "Trở lại" button in edit infomation page
    [Tags]    changeInfo    button
    Create a test post_category
    When Click on the "Sửa" button in the "_@Tiêu đề@_" item line
    When Click on the left arrow icon
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the list account from database
    Then Webpage should contain "Tạo mới" button

### Verify the delete data function
PC_21 Verify the delete data function
    [Tags]  Delete                                                                        
    Create a test post_category
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
    Then User look message "Đã xóa thành công" popup
    Then "_@Tiêu đề@_" should not be visible in item line

PC_22 Verify the cancel action button when delete data
    [Tags]  Delete                                                                        
    Create a test post_category
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line with cancel
    Then "_@Tiêu đề@_" should be visible in item line
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line
CT_23 Check to delete category that still having data inside
    [Tags]  Delete                                                                        
    ${category}=    Create a test post_category
    Click "Tạo mới bài viết" button
    Click radio "Loại editor" in line "Block"
    Click select "Chuyên mục" with "${category}"
    Click "Tiếng Việt" tab button
    ${title_1}=    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    Enter "test name" in "SEO URL" with "_RANDOM_"
    Enter "test name" in "Tác giả" with "_RANDOM_"
    Enter "test name" in "Mô tả ảnh cover" with "_RANDOM_"
    Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    Enter "paragraph" in editor "Nội dung" with "_RANDOM_"
    Enter "test name" in "Tiêu đề SEO" with "_RANDOM_"
    Enter "word" in placeholder "Nhập từ khóa seo" with "_RANDOM_" 
    Enter "paragraph" in textarea "Mô tả SEO" with "_RANDOM_"
    Click "English" tab button
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    Click "Lưu lại" button
    Click on the "Xóa" button in the "${category}" item line
    User look message "Không thể xóa danh mục đang có bài viết" popup
    Select on the "${category}" item line
    Click on the "Xóa" button in the "${title_1}" table line
    Click on the "Xóa" button in the "${category}" item line
*** Keywords ***

Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Post'
        Click "Post" sub menu to "/post"
    END
Go to page create category "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới" button

Create a test post_category
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Post" page
    IF    '${condition}' == 'True'
        Click "Tạo mới" button
    ELSE
        Go to page create category "Post" with "/post"
    END
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    Click "Lưu lại" button
    User look message "Thêm mới danh mục bài viết thành công" popup
    RETURN    ${name}

Heading of separated group should contain "${text}" inner Text
  ${actual_text}            Get Text                  //div[contains(@class,'h-14')]//span[contains(text(),"${text}")]                         
  Should Contain            ${text}                   ${actual_text}



