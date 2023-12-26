*** Settings ***
Resource            ../keywords/common.robot
# Resource            category.robot
Library             DateTime

Test Setup              Setup
Test Teardown           Tear Down


*** Test Cases ***
## Link to Test Cases  https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Category page ###
PO_01 Verify that navigating to the right "Post" page
    [Tags]    MainPage    ui    smoketest
    Login to admin
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Post" sub menu to "/post"
    Then Confirm locating exactly in "Post" page
    # Then Heading of separated group should contain "Tất cả dữ liệu" inner Text
    Then Webpage should contains the search function
    Then Webpage should contain "Tạo mới bài viết" button
    Then Webpage should contains the list data from database
PO_02 Verify the function changing the number of data show in each list
    [Tags]    MainPage    ui    smoketest
    Go to "Post" page
    When Click on "second" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "fifth" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "second" selection to change the number of account show in list and check

PO_03 Verify that highlight after clicking on it
    [Tags]    MainPage    ui    smoketest
    Go to "Post" page
    ${category}=       Create a test post_category
    ${title_1}=        Create a test post with "_@Tiêu đề@_" type
    When Select on the "${category}" item line
    When Click on the "Sửa" button in the "${title_1}" table line
    When Click "Đóng lại" button
    Then "${title_1}" table line should be highlighted
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line

# PO_04 Verify the function navigating to other lists of data page
#     [Tags]    MainPage    ui    smoketest
#     Go to "Post" page
#     ${category}=       Create a test post_category
#     # ${title_1}=        Create a test post with "_@Tiêu đề@_" type
#     Create 10 test post with "${category}" type
#     When Move to the "next" page
#     When Move to the "previous" page
#     # When Click on the "Xóa" button in the "${title_1}" table line 
#     When Move to the last page and check
#     When Click on the "Xóa" button in the "${category}" item line   

### Verify the creating post function			

PO_05 Verify "Tạo mới bài viết" button function
    [Tags]    create
    Create a test post_category
    Select on the "_@Tiêu đề@_" item line
    When Click "Tạo mới bài viết" button
    Then Heading should contains "Thêm mới bài viết" inner Text
    Then Confirm adding "/post" page
    Then Webpage should contains "Loại editor" input field
    Then Webpage should contains "Chuyên mục" input field
    Then Webpage should contains "SEO URL" input field
    Then Webpage should contains "Tác giả" input field
    Then Webpage should contains "Mô tả ảnh cover" input field
    Then Webpage should contains "Giới thiệu" input field
    Then Webpage should contains "Nội dung" input field
    Then Webpage should contains "Tiêu đề SEO" input field
    Then Webpage should contains "Từ khóa SEO" input field
    Then Webpage should contains "Mô tả SEO" input field
    Then Webpage should contain left arrow icon
    Then Webpage should contain "Lưu lại" button
    Then Webpage should contain "Đóng lại" button
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

PO_06 Create new post with the valid data
    [Tags]    create
    ${category}=    Create a test post_category
    When Select on the "_@Tiêu đề@_" item line
    When Click "Tạo mới bài viết" button
    When Click select "Chuyên mục" with "_@Tiêu đề@_"
    When Click radio "Loại editor" in line "Block"
    ${title_1}=    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Tiếng Việt" tab button
    When Enter "test name" in "SEO URL" with "_RANDOM_"
    When Enter "test name" in "Tác giả" with "_RANDOM_"
    When Enter "test name" in "Mô tả ảnh cover" with "_RANDOM_"
    When Enter "paragraph" in textarea "Giới thiệu" with "_RANDOM_"
    When Enter "paragraph" in editor "Nội dung" with "_RANDOM_"
    When Enter "test name" in "Tiêu đề SEO" with "_RANDOM_"
    When Enter "word" in placeholder "Nhập từ khóa seo" with "_RANDOM_" 
    When Enter "paragraph" in textarea "Mô tả SEO" with "_RANDOM_"
    When Click "English" tab button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Thêm mới bài viết thành công" popup
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line
PO_07 Check the update of data list after creating a new data
    [Tags]    create
    ${category}=       Create a test post_category
    ${title_1}=        Create a test post with "_@Tiêu đề@_" type
    When Select on the "${category}" item line
    Then "${title_1}" should be visible in table line
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line
### Create new data with blank field			
PO_08 Create new data with blank fields
    [Tags]    create    blankField
    Go to page create post "Post" with "/post"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn chuyên mục" displayed under "Chuyên mục" field
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
PO_09 Create a new data when leaving "Chuyên mục" field blank
    [Tags]    create    blankField
    Go to page create post "Post" with "/post"
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "English" tab button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button    
    Then Required message "Xin vui lòng chọn chuyên mục" displayed under "Chuyên mục" field

PO_10 Create a new data when leaving "Tiêu đề" field blank
    [Tags]    create    blankField
    ${category}=    Create a test post_category 
    Select on the "_@Tiêu đề@_" item line
    When Click "Tạo mới bài viết" button
    When Click select "Chuyên mục" with "_@Tiêu đề@_"
    When Click "Lưu lại" button    
    Then Required message "Xin vui lòng nhập tiêu đề" displayed under "Tiêu đề" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "${category}" item line


### Create new post with invalid data		
PO_11 Create a new post with the existence of "Tiêu đề"
    [Tags]    create    invalid
    ${category}=    Create a test post_category
    ${title_1}=    Create a test post with "_@Tiêu đề@_" type
    When Select on the "${category}" item line
    When Click "Tạo mới bài viết" button
    When Click select "Chuyên mục" with "${category}"
    When Enter "test name" in "Tiêu đề" with "${title_1}"
    When Click "English" tab button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Tiêu đề đã tồn tại" popup
    When Click "Đóng lại" button
    When Select on the "${category}" item line
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line
PO_12 Create a new post with the same Vietnamese title and English title
    [Tags]    create    invalid
    ${category}=    Create a test post_category
    Select on the "${category}" item line
    Click "Tạo mới bài viết" button
    Click select "Chuyên mục" with "${category}"
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    Click "English" tab button
    Enter "test name" in "Tiêu đề" with "_@Tiêu đề@_"
    Click "Lưu lại" button
    User look message "Tiêu đề bản dịch bị trùng lặp" popup
    Click "Đóng lại" button
    # Select on the "${category}" item line
    # Click on the "Xóa" button in the "${title_1}" table line
    Click on the "Xóa" button in the "${category}" item line

### Verify the go back function of buttons in Creating data type page		
PO_13 Verify the "Đóng lại" button
    [Tags]    create    blankField
    Go to page create post "Post" with "/post"
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the search function
    Then Webpage should contain "Tạo mới bài viết" button
    Then Webpage should contains the list data from database    

PO_14 Verify the left arrow icon ("Trở lại" button)
    [Tags]    create    blankField
    Go to page create post "Post" with "/post"
    When Click on the left arrow icon
    When Confirm locating exactly in "Post" page
    When Webpage should contains the search function
    When Webpage should contain "Tạo mới bài viết" button
    When Webpage should contains the list data from database 

PO_15 Verify the "Trở lại" (left arrow icon) button
    [Tags]    create    blankField
    Go to page create post "Post" with "/post"
    When Click "Trở lại" button
    When Confirm locating exactly in "Post" page
    When Webpage should contains the search function
    When Webpage should contain "Tạo mới bài viết" button
    When Webpage should contains the list data from database 

### Verify the funtion of changing data information
PO_16 Verify the changing "Chuyên mục" field
    [Tags]    changeInfo
    ${cate_1}=    Create a test post_category
    ${cate_2}=    Create a test post_category
    ${title}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_2}" item line
    When Click on the "Sửa" button in the "${title}" table line
    When Click select "Chuyên mục" with "${cate_1}"
    When Click "Lưu lại" button
    When Select on the "${cate_1}" item line
    When Click on the "Xóa" button in the "${title}" table line
    When Click on the "Xóa" button in the "${cate_2}" item line
    When Click on the "Xóa" button in the "${cate_1}" item line

PO_17 Verify the changing "Tiêu đề" field
    [Tags]    changeInfo
    ${cate_1}=    Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Sửa" button in the "${title_1}" table line
    ${title_2}=    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "English" tab button
    When Enter "test name" in "Tiêu đề" with "_RANDOM_"
    When Click "Lưu lại" button
    When Click on the "Xóa" button in the "${title_2}" table line
    When Click on the "Xóa" button in the "${cate_1}" item line   
PO_18 Verify the changing with the existed "Tiêu đề"
    [Tags]    changeInfo
    ${category}=    Create a test post_category
    ${title_1}=     Create a test post with "${category}" type
    ${title_2}=     Create a test post with "${category}" type
    When Select on the "${category}" item line
    When Click on the "Sửa" button in the "${title_2}" table line
    When Enter "test name" in "Tiêu đề" with "${title_1}"
    When Click "Lưu lại" button
    Then User look message "Tiêu đề đã tồn tại" popup
    When Click "Đóng lại" button
    When Select on the "${category}" item line
    When Click on the "Xóa" button in the "${title_2}" table line
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line

### Verify the go back function of buttons in change information's page
PO_19 Check the "Đóng lại" button in edit infomation page
    [Tags]    changeInfo    button
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Sửa" button in the "${title_1}" table line
    When Click "Đóng lại" button
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the search function
    Then Webpage should contain "Tạo mới bài viết" button
    Then Webpage should contains the list data from database
    Then "${title_1}" table line should be highlighted    
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${cate_1}" item line
PO_20 Check the left arrow icon ("Trở lại" button) in edit infomation page
    [Tags]    changeInfo    button
    ${cate_1}=    Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Sửa" button in the "${title_1}" table line
    When Click on the left arrow icon
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the search function
    Then Webpage should contain "Tạo mới bài viết" button
    Then Webpage should contains the list data from database
    Then "${title_1}" table line should be highlighted    
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${cate_1}" item line
PO_21 Check the "Trở lại" (left arrow icon) button in edit infomation page
    [Tags]    changeInfo    button
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Sửa" button in the "${title_1}" table line
    When Click "Trở lại" button
    Then Confirm locating exactly in "Post" page
    Then Webpage should contains the search function
    Then Webpage should contain "Tạo mới bài viết" button
    Then Webpage should contains the list data from database
    Then "${title_1}" table line should be highlighted    
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${cate_1}" item line
### Verify the User Interface of detail information's account page		
PO_22 Verify that navigating to the right "edit post" page
    [Tags]    DetailedInfo
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Chi tiết" button in the "${title_1}" table line
    Then Heading should contains "Cập nhật bài viết" inner Text
    Then Webpage should contains "Loại editor" input field
    Then Webpage should contains "Chuyên mục" input field
    Then Webpage should contains "SEO URL" input field
    Then Webpage should contains "Tác giả" input field
    Then Webpage should contains "Mô tả ảnh cover" input field
    Then Webpage should contains "Giới thiệu" input field
    Then Webpage should contains "Nội dung" input field
    Then Webpage should contains "Tiêu đề SEO" input field
    Then Webpage should contains "Từ khóa SEO" input field
    Then Webpage should contains "Mô tả SEO" input field
    Then Webpage should contain left arrow icon
    When Click "Trở lại" button
    Then "${title_1}" table line should be highlighted
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${cate_1}" item line

# PO_23 Check data information after creation
#     [Tags]    DetailedInfo
#     Create a category
#     Create a test data with "_@Tiêu đề@_" type
#     When Select on the "_@Tiêu đề@_" item line
#     When Click on the "Chi tiết" button in the "_@Tiêu đề@_" table line
#     # Then Data's information in "Chuyên mục" should be equal "_@Tiêu đề@_"
#     # Then Data's information in "Thứ tự" should be equal "_@Thứ tư@_"
#     # Then Data's information in "Tiêu đề" should be equal "_@Tiêu đề@_"
#     # Then Data's information in "Mô tả" should be equal "_@Mô tả@_"
#     # Then Data's information in "Nội dung" should be equal "_@Nội dung@_"
#     When Click "Trở lại" button
#     When Click on the "Xóa" button in the "_@Tiêu đề@_" table line
#     When Click on the "Xóa" button in the "_@Tiêu đề@_" item line

### Verify the delete data type function
PO_24 Verify the delete data function
    [Tags]    delete
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Xóa" button in the "${title_1}" table line
    Then User look message "Đã xóa thành công" popup
    Then "${title_1}" should not be visible in item line
    When Click on the "Xóa" button in the "${cate_1}" item line

PO_25 Verify the cancel action button when delete data
    [Tags]    delete
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Click on the "Xóa" button in the "${title_1}" table line with cancel
    Then "${title_1}" should be visible in table line
    When Click on the "Xóa" button in the "${title_1}" table line
    Then User look message "Đã xóa thành công" popup
    When Click on the "Xóa" button in the " ${cate_1}" item line
### Verify the search function
PO_26 Verify the search function when enter the existed title
    [Tags]    search
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Enter "test name" in "Tìm kiếm" with "${title_1}"
    Then "${title_1}" should be visible in table line
    When Click on the "Xóa" button in the "${title_1}" table line 
    When Click on the "Xóa" button in the "${cate_1}" item line
PO_27 Verify the search function when enter the title was not existed
    [Tags]    search
    ${cate_1}=      Create a test post_category
    ${title_1}=     Create a test post with "_@Tiêu đề@_" type
    When Select on the "${cate_1}" item line
    When Enter "test name" in "Tìm kiếm" with "123 xin chào"
    Then Table line should show empty 
    When Enter "text" in "Tìm kiếm" with ""
    Then "${title_1}" should be visible in table line
    When Click on the "Xóa" button in the "${title_1}" table line 
    When Click on the "Xóa" button in the "${cate_1}" item line

PO_28 Check the update of post list after cancel the search action
    [Tags]    search
    ${category}=    Create a test post_category
    ${title_1}=     Create a test post with "${category}" type
    ${title_2}=     Create a test post with "${category}" type
    When Select on the "${category}" item line
    When Enter "test name" in "Tìm kiếm" with "${title_1}"
    Then "${title_1}" should be visible in table line
    Then "${title_2}" should not be visible in table line
    When Enter "text" in "Tìm kiếm" with ""
    Then "${title_2}" should be visible in table line
    When Click on the "Xóa" button in the "${title_2}" table line
    When Click on the "Xóa" button in the "${title_1}" table line
    When Click on the "Xóa" button in the "${category}" item line
   

Create 10 post
    ${title}=    Create a test post_category
    FOR    ${counter}    IN RANGE    1    10    
        Create 10 test post with "${title}" type
    END
Clear Data
    Login to admin 
    When Click "QUẢN LÝ DANH MỤC" menu
    When Click "Post" sub menu to "/post"
    Clear test category data
*** Keywords ***

Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Post'
        Click "Post" sub menu to "/post"
    END
Go to page create post "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới bài viết" button

Create a test post with "${type}" type
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Post" page
    IF    '${condition}' == 'True'
        Click "Tạo mới bài viết" button
    ELSE
        Go to page create post "Post" with "/post"
    END    
    Click select "Chuyên mục" with "${type}"
    Click radio "Loại editor" in line "Block"
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Click "Tiếng Việt" tab button
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
    User look message "Thêm mới bài viết thành công" popup
    RETURN    ${name}

Create 10 test post with "${title}" type
   ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Post" page
    IF    '${condition}' == 'True'
        Click "Tạo mới bài viết" button
    ELSE
        Go to page create post "Post" with "/post"
    END    
    Click select "Chuyên mục" with "${title}"
    Click radio "Loại editor" in line "Block"
    Enter "test name" in "Tiêu đề" with "_RANDOM_"
    ${text}=    Check Text    _@Tiêu đề@_
    ${name}=    Set Variable    ${text}
    Click "Tiếng Việt" tab button
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
    User look message "Thêm mới bài viết thành công" popup
    RETURN    ${name}
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

Go to page create category "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ DANH MỤC" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới" button


Clear test category data
    ${elements}=              Get Elements                //div[contains(@class,'h-[calc(100vh-170px)]')]//button[contains(@class,'item')]    
    ${count}=                 Get Length                  ${elements}
    IF    ${count} > 3
          ${range_end}=          Evaluate                    ${count} - 3
          FOR    ${counter}    IN RANGE    0    ${range_end}
               Click           ${elements}[0]
               Wait Until Element Spin



               ${elm}=          Set Variable                //tr[contains(@class,'ant-table-row')]//button[@title = "Xóa"]
               ${ele_cnt}=      Get Element Count           ${elm}
                Log To Console    'message: ${ele_cnt}'
               IF    '${ele_cnt}' > '0'
                    ${eles}=         Get Elements                //tr[contains(@class,'ant-table-row')]//button[@title = "Xóa"]
                    FOR    ${cnt}    IN RANGE    ${ele_cnt}     0    -1
                            Log To Console    'message-cnt: ${cnt}'

                            Click           ${eles}[${cnt - 1}]
                            Wait Until Element Spin
                            Click Confirm To Action
                    END
               END
                ${e}=    Get Element    (//div[contains(@class,'h-[calc(100vh-170px)]')]//button[contains(@class,'item')])[1]//button[@title = "Xóa"]
                Click                      ${e}
                Click Confirm To Action
                Wait Until Element Spin
          END
    END    
