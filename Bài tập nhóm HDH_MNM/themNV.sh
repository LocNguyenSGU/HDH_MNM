#!/bin/bash

# Hàm kiểm tra xem ngày có hợp lệ không
checkDOB2() {
    date -d "$1" "+%d/%m/%Y" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra tên có kí tự đặc biệt không
function is_valid_name() {
    if [[ "$1" =~ ^[[:alnum:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra số điện thoại có hợp lệ không
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

# Kiểm tra xem dataNV.txt có tồn tại không, nếu không tạo mới
if [ ! -f "dataNV.txt" ]; then
    touch dataNV.txt
fi




function themNV(){
    input="yes"

    # Yêu cầu người dùng nhập thông tin nhân viên
 while [ "$input" != "no" ]; do
 	clear
    # Tìm mã số nhân viên lớn nhất
    max_id=$(awk -F '#' '{print $1}' dataNV.txt | sort -n | tail -n 1 | awk -F ',' '{print     $1}')

    # Khởi tạo biến
    new_id=$((max_id + 1))
    # Yêu cầu thông tin của nhân viên
    echo "Thêm nhân viên mới:"
    echo -n "Họ và Tên Lot: "
    read firstname
    # Kiểm tra tên có kí tự đặc biệt không
    while ! is_valid_name "$firstname"; do
        echo "Tên không được chứa kí tự đặc biệt. Vui lòng nhập lại."
        echo -n "Họ và Tên Lot: "
        read firstname
    done
    echo -n "Tên: "
    read name
    # Kiểm tra tên có kí tự đặc biệt không
    while ! is_valid_name "$name"; do
        echo "Tên không được chứa kí tự đặc biệt. Vui lòng nhập lại."
        echo -n "Tên: "
        read name
    done
    echo -n "Ngày sinh (DD/MM/YYYY): "
    read dob
    # Kiểm tra định dạng ngày sinh
    while ! checkDOB2 "$dob"; do
        echo "Định dạng ngày không hợp lệ. Vui lòng nhập lại theo định dạng YYYY-MM-DD."
        echo -n "Ngày sinh (DD/MM/YYYY): "
        read dob
    done
    echo -n "Nơi sinh: "
    read pob
    echo -n "Giới tính: "
    read gender
    echo -n "Phòng ban: "
    read department
    echo -n "Mức lương hiện tại: "
    read salary
    echo -n "Email: "
    read email
    # Kiểm tra định dạng email
    while ! is_valid_email "$email"; do
        echo "Định dạng email không hợp lệ. Vui lòng nhập lại."
        echo -n "Email: "
        read email
    done
    echo -n "Số điện thoại: "
    read phone
    # Kiểm tra số điện thoại
    while ! is_valid_phone "$phone"; do
        echo "Số điện thoại không hợp lệ. Vui lòng nhập lại (10 chữ số)."
        echo -n "Số điện thoại: "
        read phone
    done
    
    # Thêm thông tin của nhân viên mới vào dataNV.txt
    echo "$new_id#$firstname#$name#$dob#$pob#$gender#$department#$salary#$email#$phone" >> dataNV.txt
    
    # Hỏi người dùng có muốn thêm nhân viên khác không
    echo -n "Bạn có muốn thêm nhân viên khác không? (yes/no): "
    read input
done

echo "Thêm nhân viên thành công."
}
