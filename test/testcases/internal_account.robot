*** Settings ***
Resource            ../keywords/common.robot
Library             DateTime

Test Setup          Setup
Test Teardown       Tear Down


*** Test Cases ***
### Link to Test Cases    https://docs.google.com/spreadsheets/d/1DbP64bT7QpASuE3NeiIVDdeHpdrKQon3HqF9rsUzbFU/edit#gid=1995480892 ###

### Check the User Interface of the Internal-Account page ###
IA_01 Verify that navigating to the right "Internal-Account" page
    [Tags]    mainpage    ui    smoketest
    Login to admin
    When Click "QUẢN LÝ TÀI KHOẢN" menu
    When Click "Tài khoản Nội bộ" sub menu to "/internal-account"
    Then Confirm locating exactly in "Tài khoản nội bộ" page
    Then Heading should contains "Danh sách tài khoản nội bộ" inner Text
    Then Webpage should contains the list account from database
    Then Webpage Should Contains The Search Function
    Then Webpage should contains the "Ngày tham gia" filter function
    Then Webpage should contains the "Loại tài khoản" filter function
    Then Webpage should contains the "Kích hoạt" filter function

IA_02 Verify the function changing the number of accounts show in each list
    [Tags]    mainpage    ui    smoketest
    Go to "Internal Account" page
    When Click on "second" selection to change the number of account show in list and check
    When Click on "third" selection to change the number of account show in list and check
    When Click on "fourth" selection to change the number of account show in list and check
    When Click on "fifth" selection to change the number of account show in list and check

IA_03 Verify the function navigating to other lists of account page
    [Tags]    mainpage    ui    smoketest
    Go to "Internal Account" page
    Then Check the amount of page list
    ${Last_name}=    Get data in the last row
    When Create a test account with "CSKH" type
    When Move to the "next" page
    ${First_name}=    Get data in the first row
    Then Should Be Equal    ${First_name}    ${Last_name}
    When Move to the "previous" page
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    Then Move to the last page and check

IA_04 Verify the highlight table line function after operated
    [Tags]    mainpage    ui
    Create a test account with "Kế toán" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click "Đóng lại" button
    Then "_@Họ và tên@_" table line should be highlighted
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the correct design in detail information's account page ###

IA_05 Verify that navigating to the right "Detail-information" page
    [Tags]    detailedinfo    ui    smoketest
    Create a test account with "CSKH" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Heading should contains "Xem chi tiết thông tin tài khoản" inner Text
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_06_01 Check account information after creation (CSKH)
    [Tags]    detailedinfo    ui    smoketest
    ${today}=    Get Current Date    local    result_format=%d/%m/%Y
    Create a test account with "Kế toán" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Data's information in "Họ và tên" should be equal "_@Họ và tên@_"
    Then Data's information in "Email" should be equal "_@Email@_"
    Then Data's information in "Giới tính" should be equal "_@Giới tính@_"
    Then Data's information in "Loại tài khoản" should be equal "_@Loại tài khoản@_"
    Then Data's information in "Số điện thoại" should be equal "_@Số điện thoại@_"
    Then Data's information in "Ngày hoạt động cuối" should be equal "${today}"
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_06_02 Check account information after creation (Kế toán)
    [Tags]    detailedinfo    ui    smoketest
    ${today}=    Get Current Date    local    result_format=%d/%m/%Y
    Create a test account with "Kế toán" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    Then Data's information in "Họ và tên" should be equal "_@Họ và tên@_"
    Then Data's information in "Email" should be equal "_@Email@_"
    Then Data's information in "Giới tính" should be equal "_@Giới tính@_"
    Then Data's information in "Loại tài khoản" should be equal "_@Loại tài khoản@_"
    Then Data's information in "Số điện thoại" should be equal "_@Số điện thoại@_"
    Then Data's information in "Ngày hoạt động cuối" should be equal "${today}"
    When Click "Trở lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the lock account function ###

IA_07 Verify the block account funtion
    [Tags]    lock    smoketest
    Create a test account with "Kế toán" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Khóa"
    Then "_@Họ và tên@_" should be visible in table line
    Then Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_08 Verify the unblock account function
    [Tags]    lock    smoketest
    Create a test account with "Kế toán" type
    When Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Mở Khóa" button
    Then User look message "Mở khóa tài khoản người dùng thành công." popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the search function ###

IA_09 Verify the search function when enter the existed name
    [Tags]    search    smoketest
    Create a test account with "Kế toán" type
    When Enter "test name" in "Tìm kiếm" with "_@Họ và tên@_"
    When Click on magnifier icon in search box
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_10 Verify the search function when enter the name was not existed
    [Tags]    search
    Create a test account with "CSKH" type
    When Enter "text" in "Tìm kiếm" with "opp"
    When Click on magnifier icon in search box
    Then Table line should show empty
    When Enter "test name" in "Tìm kiếm" with "_@Họ và tên@_"
    When Click on magnifier icon in search box
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_11 Check the update of account list after cancel the search action
    [Tags]    search
    ${AccountName}=    Create a test account with "CSKH" type
    Create a test account with "Kế toán" type
    When Enter "text" in "Tìm kiếm" with "${AccountName}"
    When Click on magnifier icon in search box
    Then "${AccountName}" should be visible in table line
    Then "_@Họ và tên@_" should not be visible in table line
    When Enter "text" in "Tìm kiếm" with ""
    When Click on magnifier icon in search box
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    When Click on the "Xóa" button in the "${AccountName}" table line

### Verify the filter function ###

IA_12 Verify the "Loại tài khoản" filter function when select "CSKH"
    [Tags]    filter
    Create a test account with "CSKH" type
    When Click filter "Loại tài khoản" with "Kế toán"
    Then "_@Họ và tên@_" should not be visible in table line
    When Click filter "Loại tài khoản" with "CSKH"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_13 Verify the "Loại tài khoản" filter function when select "CSKH"
    [Tags]    filter
    Create a test account with "Kế toán" type
    When Click filter "Loại tài khoản" with "CSKH"
    Then "_@Họ và tên@_" should not be visible in table line
    When Click filter "Loại tài khoản" with "Kế toán"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_14 Verify the "Kích hoạt" filter function when select "Khóa"
    [Tags]    filter
    Create a test account with "CSKH" type
    when Click on the "Chi tiết" button in the "_@Họ và tên@_" table line
    When Click "Khóa" button
    Then User look message "Khóa tài khoản người dùng thành công !" popup
    When Click "Trở lại" button
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then "_@Họ và tên@_" should not be visible in table line
    When Click filter "Kích hoạt" with "Khóa"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_15 Verify the "Kích hoạt" filter function when select "Mở Khóa"
    [Tags]    filter
    Create a test account with "Kế toán" type
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then "_@Họ và tên@_" should be visible in table line
    When Click filter "Kích hoạt" with "Khóa"
    Then "_@Họ và tên@_" should not be visible in table line
    When Click on cross icon in select "Kích hoạt"
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_16 Verify the deselect filter function when click on cross button
    [Tags]    filter
    Create a test account with "CSKH" type
    When Click filter "Loại tài khoản" with "Kế toán"
    Then "_@Họ và tên@_" should not be visible in table line
    When Click on cross icon in select "Loại tài khoản"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_17 Verify the date selection filter function
    [Tags]    filter
    ${today}=    Get Current Date    local    result_format=%Y-%m-%d
    ${yesterday}=    Get Current Date    local    - 1 day    result_format=%Y-%m-%d
    Create a test account with "CSKH" type
    When Enter date in placeholder "Bắt đầu" with "${yesterday}"
    When Enter date in placeholder "Kết thúc" with "${yesterday}"
    Then "_@Họ và tên@_" should not be visible in table line
    When Enter date in placeholder "Bắt đầu" with "${today}"
    When Enter date in placeholder "Kết thúc" with "${today}"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_18 Verify the filter function by applying all filter at the same time
    [Tags]    filter
    ${today}=    Get Current Date    local    result_format=%Y-%m-%d
    Create a test account with "CSKH" type
    When Enter date in placeholder "Bắt đầu" with "${today}"
    When Enter date in placeholder "Kết thúc" with "${today}"
    When Click filter "Loại tài khoản" with "CSKH"
    When Click filter "Kích hoạt" with "Mở Khóa"
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the creating account function ###

IA_19 Verify "Tạo mới" button function
    [Tags]    create    smoketest
    Go to "Internal Account" page
    When Click "Tạo mới" button
    Then Heading should contains "Tạo mới tài khoản nội bộ" inner Text
    Then Confirm adding account "/internal-account" page
    Then Webpage should contains "Họ và tên" input field
    Then Webpage should contains "Email" input field
    Then Webpage should contains "Số điện thoại" input field
    Then Webpage should contains "Giới tính" input field
    Then Webpage should contains "Loại tài khoản" input field
    Then Webpage should contains "Mật khẩu" input field
    Then Webpage should contains "Xác nhận mật khẩu" input field
    Then Webpage should contain "Lưu lại" button
    Then Webpage should contain "Đóng lại" button

IA_20 Create new account with the valid data
    [Tags]    create    smoketest
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tạo tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_21 Verify showing "Mật khẩu" and "Xác nhận mật khẩu" on "Tạo mới" page
    [Tags]    create    ui
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Mật khẩu" field
    Then The hidden password in "Mật khẩu" field should be visibled as "_@Mật khẩu@_"
    When Click on eye icon in "Xác nhận mật khẩu" field
    Then The hidden password in "Xác nhận mật khẩu" field should be visibled as "_@Xác nhận mật khẩu@_"
    When Click "Đóng lại" button

IA_22 Check the update of account list after creating a new account
    [Tags]    create    smoketest
    Go to "Internal Account" page
    When Create a test account with "Kế toán" type
    Then "_@Họ và tên@_" should be visible in table line
    Then Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Create new account with blank field ###

IA_23 Create a new account with all blank fields
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập họ và tên" displayed under "Họ và tên" field
    Then Required message "Xin vui lòng nhập email" displayed under "Email" field
    Then Required message "Xin vui lòng nhập số điện thoại" displayed under "Số điện thoại" field
    Then Required message "Xin vui lòng chọn giới tính" displayed under "Giới tính" field
    Then Required message "Xin vui lòng chọn loại tài khoản" displayed under "Loại tài khoản" field
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field

IA_24 Create a new account when leaving "Họ và tên" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập họ và tên" displayed under "Họ và tên" field

IA_25 Create a new account when leaving "Email" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập email" displayed under "Email" field

IA_26 Create a new account when leaving "Số điện thoại" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập số điện thoại" displayed under "Số điện thoại" field

IA_27 Create a new account when leaving "Giới tính" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn giới tính" displayed under "Giới tính" field

IA_28 Create a new account when leaving "Loại tài khoản" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng chọn loại tài khoản" displayed under "Loại tài khoản" field

IA_29 Create a new account when leaving "Mật khẩu" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Xác nhận mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field

IA_30 Create a new account when leaving "Xác nhận mật khẩu" field blank
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field

### Create new account with invalid data ###

IA_31 Create a new account with the invalid email
    [Tags]    create    blankfield
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "text" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập địa chỉ email hợp lệ!" displayed under "Email" field

IA_32 Create a new account with the invalid phone number
    [Tags]    create    invalid
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "123456789"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Số điện thoại gồm 10 số" pop up

IA_33 Create a new account with the existed phone number
    [Tags]    create    invalid
    ${AccountName}=    Create a test account with "Kế toán" type
    When Click "Tạo mới" button
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_@Số điện thoại@_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Số điện thoại đã được sử dụng." popup
    When Click "Đóng lại" button
    Then Click on the "Xóa" button in the "${AccountName}" table line

IA_34 Create a new account with the existed email
    [Tags]    create    invalid
    ${AccountName}=    Create a test account with "Kế toán" type
    When Click "Tạo mới" button
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_@Email@_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "CSKH"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Tên người dùng/Email đã được sử dụng." popup
    When Click "Đóng lại" button
    Then Click on the "Xóa" button in the "${AccountName}" table line

IA_35 Create a new account with the "Xác nhận mật khẩu" different with "Mật khẩu"
    [Tags]    create    invalid
    Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Enter "email" in "Email" with "_RANDOM_"
    When Enter "phone" in "Số điện thoại" with "_RANDOM_"
    When Click select "Giới tính" with "Nam"
    When Click select "Loại tài khoản" with "Kế toán"
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "abc123"
    When Click "Lưu lại" button
    Then Required message "Mật khẩu và mật khẩu xác nhận không khớp" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button

### Verify changing Password function

IA_36 Verify the changing password function
    [Tags]    changepassword    smoketest
    Create a test account with "Kế toán" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click "Lưu lại" button
    Then User look message "Đổi mật khẩu thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_37 Verify the changing password function by entering the "Xác nhận mật khẩu" different with the "Mật khẩu"
    [Tags]    changepassword    smoketest
    Create a test account with "CSKH" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "123123"
    When Click "Lưu lại" button
    Then Required message "Mật khẩu và mật khẩu xác nhận không khớp" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_38 Verify the changing password function when leave the "Mật khẩu" filed blank
    [Tags]    changepassword
    Create a test account with "Kế toán" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Xác nhận mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập mật khẩu" displayed under "Mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_39 Verify the changing password function when leave the "Xác nhận mật khẩu" filed blank
    [Tags]    changepassword
    Create a test account with "CSKH" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Click "Lưu lại" button
    Then Required message "Xin vui lòng nhập xác nhận mật khẩu" displayed under "Xác nhận mật khẩu" field
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_40 Verify the ability of showing password when in the "Mật khẩu" field
    [Tags]    changepassword
    Create a test account with "CSKH" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Mật khẩu" field
    Then The hidden password in "Mật khẩu" field should be visibled as "_@Mật khẩu@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_41 Verify the ability of showing password when in the "Xác nhận mật khẩu" field
    [Tags]    changepassword
    Create a test account with "Kế toán" type
    When Click on the "Đổi mật khẩu" button in the "_@Họ và tên@_" table line
    When Enter "password" in "Mật khẩu" with "_RANDOM_"
    When Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    When Click on eye icon in "Xác nhận mật khẩu" field
    Then The hidden password in "Xác nhận mật khẩu" field should be visibled as "_@Xác nhận mật khẩu@_"
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

### Verify the funtion of changing account information ###

IA_42 Verify the changing "Họ và tên" field
    [Tags]    changeinfo
    Create a test account with "CSKH" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Enter "test name" in "Họ và tên" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_43 Verify the changing "Số điện thoại" field
    [Tags]    changeinfo
    Create a test account with "Kế toán" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Enter "number" in "Số điện thoại" with "_RANDOM_"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_44 Verify the changing "Giới tính" field
    [Tags]    changeinfo
    Create a test account with "CSKH" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click select "Giới tính" with "Nữ"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_45 Verify the changing "Loại tài khoản" field
    [Tags]    changeinfo
    Create a test account with "Kế toán" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click select "Loại tài khoản" with "CSKH"
    When Click "Lưu lại" button
    Then User look message "Chỉnh sửa tài khoản thành công" popup
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

IA_46 Verify the changing with the existed "Số điện thoại"
    [Tags]    changeinfo
    ${AccountName}=    Create a test account with "CSKH" type
    Create a test account with "Kế toán" type
    When Click on the "Sửa" button in the "${AccountName}" table line
    When Enter "number" in "Số điện thoại" with "_@Số điện thoại@_"
    When Click "Lưu lại" button
    Then User look message "Số điện thoại đã được sử dụng." popup
    When Click "Đóng lại" button
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    When Click on the "Xóa" button in the "${AccountName}" table line

### Verify the delete account function ###

IA_47 Verify the delete account function
    [Tags]    delete    smoketest
    Create a test account with "CSKH" type
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
    Then User look message "Xóa thành công" popup
    Then "_@Họ và tên@_" should not be visible in table line

IA_48 Verify the cancel action button when delete account
    [Tags]    delete
    Create a test account with "Kế toán" type
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line with cancel
    Then "_@Họ và tên@_" should be visible in table line
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line
IA_012 Verify the highlight table line function after operateddd
    [Tags]    mainpage    ui
    Create a test account with "Kế toán" type
    When Click on the "Sửa" button in the "_@Họ và tên@_" table line
    When Click "Đóng lại" button
    Then "_@Họ và tên@_" table line should be highlighted
    When Click on the "Xóa" button in the "_@Họ và tên@_" table line

*** Keywords ***
Go to "${page}" page
    Login to admin
    Click "QUẢN LÝ TÀI KHOẢN" menu
    ${cnt}=    Get Length    ${page}
    IF    ${cnt} > 0 and '${page}' == 'Customer Account'
        Click "Tài khoản Người dùng" sub menu to "/customer-account"
    ELSE IF    ${cnt} > 0 and '${page}' == 'Internal Account'
        Click "Tài khoản Nội bộ" sub menu to "/internal-account"
    END

Go to page create account "${name}" with "${url}"
    Login to admin
    Click "QUẢN LÝ TÀI KHOẢN" menu
    Click "${name}" sub menu to "${url}"
    Click "Tạo mới" button

Create a test account with "${type}" type
    ${condition}=    Run Keyword And Return Status    Confirm locating exactly in "Tài khoản nội bộ" page
    ${CurrentDate2}=    Get Current Date        result_format=%d-%m-%Y %H:%M:%S           
    Log To Console    'bbbb: ${CurrentDate2}'
    IF    '${condition}' == 'True'
        Click "Tạo mới" button
    ELSE
        Go to page create account "Tài khoản Nội bộ" with "/internal-account"
    END
    Enter "test name" in "Họ và tên" with "_RANDOM_"
    ${text}=    Check Text    _@Họ và tên@_
    ${name}=    Set Variable    ${text}
    Enter "email" in "Email" with "_RANDOM_"
    Enter "phone" in "Số điện thoại" with "_RANDOM_"
    Click select "Giới tính" with "Nam"
    Click select "Loại tài khoản" with "${type}"
    Enter "password" in "Mật khẩu" with "_RANDOM_"
    Enter "password" in "Xác nhận mật khẩu" with "_@Mật khẩu@_"
    Click "Lưu lại" button
    User look message "Tạo tài khoản thành công" popup
    RETURN    ${name}
