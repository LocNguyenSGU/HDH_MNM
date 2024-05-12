#!/bin/bash
# For MacOS
checkDOB(){
    # -j: date không thay đổi giá trị của hệ thống ngày và giờ, mà chỉ thực hiện phân tích và định dạng ngày được cung cấp.
    # -f "%d/%m/%Y": xác định định dạng của chuỗi ngày tháng năm qua tham số $1
    # "+%d/%m/%Y": xác định định dạng của kết quả mà date sẽ trả về
    [[ $(date -j -f "%d/%m/%Y" "$1" "+%d/%m/%Y" 2> /dev/null) == $1 ]] && return 0 || return 1
}

# Hàm kiểm tra xem ngày có hợp lệ không
checkDOB2() {
    date -d "$1" "+%d/%m/%Y" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra có kí tự đặc biệt không
function is_valid_name() {
    if [[ "$1" =~ ^[[:alnum:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra Ten có chứa kí tự chữ và dấu cách
function is_valid_name1() {
    if [[ "$1" =~ ^[[:alpha:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra So đien thoai có hợp lệ không
function is_valid_phone() {
    if [[ "$1" =~ ^[0-9]{10}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra email có đúng định dạng chuẩn không
function is_valid_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra Gioi tinh có giá trị hợp lệ
function is_valid_gender() {
    gender=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    # Chuyển đổi sang chữ thường
    if [[ "$gender" =~ ^(nam|nu)$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra Muc luongcó giá trị hợp lệ
function is_valid_salary() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Kiểm tra xem dataNV.txt có tồn tại không, nếu không tạo mới
if [ ! -f "dataNV.txt" ]; then
    touch dataNV.txt
fi

function themNV(){
    input="yes"

    # Yêu cầu người dùng nhập thông tin nhân viên
    while [[ "$input" != "no" && "$input" != "n" ]]; do
        clear
        # Tìm mã số nhân viên lớn nhất
        max_id=$(awk -F '#' '{print $1}' dataNV.txt | sort -n | tail -n 1 | awk -F '#' '{print $1}')

        # Khởi tạo biến
        new_id=$((max_id + 1))
        # Yêu cầu thông tin của nhân viên
        echo "Them nhan vien moi: "
        echo -n "Ho va ten lot: "
        read firstname
        # Kiểm tra Ten có kí tự đặc biệt không
        while ! is_valid_name1 "$firstname"; do
            echo "Ho va ten lot khong duoc chua ki tu dac biet hoac chu so. Vui long nhap lai."
            echo -n "Ho va ten lot: "
            read firstname
        done
        echo -n "Ten: "
        read name
        # Kiểm tra Ten có kí tự đặc biệt không
        while ! is_valid_name1 "$name"; do
            echo "Ten khong duoc chua ki tu dac biet hoac chu so. Vui long nhap lai."
            echo -n "Ten: "
            read name
        done
        echo -n "Ngay sinh (DD/MM/YYYY): "
        read dob
        # Kiểm tra định dạng ngày sinh
        while ! checkDOB2 "$dob"; do
            echo "Ngay nhap vao khong hop le. Vui long nhap lai theo đinh dang DD/MM/YYYY."
            echo -n "Ngay sinh (DD/MM/YYYY): "
            read dob
        done
        echo -n "Noi sinh: "
        read pob
        while ! is_valid_name "$pob"; do
            echo "Noi sinh khong duoc chua ki tu dac biet. Vui long nhap lai."
            echo -n "Noi sinh: "
            read pob
        done
        echo -n "Gioi tinh: "
        read gender
        while ! is_valid_gender "$gender"; do
            echo "Gioi tinh khong hop le. Vui long nhap lai (nam hoac nu)."
            echo -n "Gioi tinh: "
            read gender
        done
        gender=$(echo "$gender" | tr '[:upper:]' '[:lower:]')
        echo -n "Don vi: "
        read department
        while ! is_valid_name "$department"; do
            echo "Don vi khong chua ki tu dac biet. Vui long nhap lai."
            echo -n "Don vi: "
            read department
        done
        department=$(echo "$department" | tr '[:upper:]' '[:lower:]')
        # echo -n "Muc luong hien tai: "
        # read salary
        # while ! is_valid_salary "$salary"; do
        #     echo "Muc luong khong hop le . Vui long nhap lai (chi chua chu so)."
        #     echo -n "Muc luong hien tai: "
        #     read salary
        # done
        echo -n "Email: "
        read email
        # Kiểm tra định dạng email
        while ! is_valid_email "$email"; do
            echo "Dinh dang email khong hop le. Vui long nhap lai."
            echo -n "Email: "
            read email
        done
        echo -n "So đien thoai: "
        read phone
        # Kiểm tra So đien thoai
        while ! is_valid_phone "$phone"; do
            echo "So đien thoai khong hop le. Vui long nhap lai (10 chu so)."
            echo -n "So đien thoai: "
            read phone
        done
        echo -n "Chuc vu: "
        read chucVu
        while ! is_valid_name "$chucVu"; do
            echo "Chuc vu khong chua ki tu dac biet. Vui long nhap lai."
            echo -n "Chuc vu: "
            read chucVu
        done
        # Thêm thông tin của nhân viên mới vào dataNV.txt
        echo "$new_id#$firstname#$name#$dob#$pob#$gender#$department#-1#$email#$phone#$chucVu" >> dataNV.txt
        echo "Thong tin nhan vien da duoc them vao file dataNV.txt."
        # Hỏi người dùng có muốn thêm nhân viên khác không
        echo -n "Ban co muon them nhan vien khac khong? (yes/no or y/n): "
        read input
    done
}
