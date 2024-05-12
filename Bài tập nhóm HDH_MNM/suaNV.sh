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
isValidName() {
    if [[ "$1" =~ ^[[:alnum:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra số điện thoại có hợp lệ không
isValidPhone() {
    if [[ "$1" =~ ^[0-9]{10}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra email có đúng định dạng chuẩn không
isValidEmail() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

function suaNV(){
# Kiểm tra xem dataNV.txt có tồn tại không
if [ ! -f "dataNV.txt" ]; then
    echo "File dataNV.txt không tồn tại."
    exit 1
fi

option="yes"

until [ "$option" == "no" ]; do
	clear
    echo "Danh sách nhân viên:"
    echo "===================="
    cat dataNV.txt | awk -F '#' '{print $1 " - " $2 " " $3}'

    read -p "Nhập mã nhân viên cần chỉnh sửa: " id

    emp_info=$(awk -F'#' -v id="$id" '$1 == id {print}' dataNV.txt)
    if [ -z "$emp_info" ]; then
        echo "Mã số nhân viên không tồn tại." && continue
    fi

    read -p "Nhập họ và tên lot mới: " fname
    read -p "Nhập tên mới: " name
    dob=""
    while [ "$dob" == "" ];do
        read -p "Nhập ngày sinh (dạng dd/mm/yyyy): " dob
        checkDOB2 $dob
        [ $? -eq 0 ] && break || dob=""
    done
       
    read -p "Nhập nơi sinh mới: " place_of_birth
    read -p "Nhập giới tính mới: " gender
    read -p "Nhập phòng ban mới: " department
    read -p "Nhập mức lương hiện tại mới: " salary
   
    
        read -p "Nhập email mới (nếu không muốn thay đổi, nhấn Enter): " email


        read -p "Nhập số điện thoại mới (nếu không muốn thay đổi, nhấn Enter): " phone
        
    
    if [ "$fname" != "" ]; then
        awk -v id="$id" -v newFullname="$fname" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$2 = newFullname} 1' dataNV.txt > tmp
        mv tmp dataNV.txt 
    fi
    if [ "$name" != "" ]; then
        awk -v id="$id" -v newname="$name" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$3 = newname} 1' dataNV.txt > tmp
        mv tmp dataNV.txt 
    fi
    # Cập nhật ngày sinh
    if [ "$dob" != "" ]; then
        awk -v id="$id" -v newDOB="$dob" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$4 = newDOB} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    
    if [ "$place_of_birth" != "" ]; then
        awk -v id="$id" -v newplace_of_birth="$place_of_birth" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$5 = newplace_of_birth} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
   
    if [ "$gender" != "" ]; then
        awk -v id="$id" -v newgender="$gender" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$6 = newgender} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi

    if [ "$department" != "" ]; then
        awk -v id="$id" -v newdepartment="$department" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$7 = newdepartment} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    
    if [ "$salary" != "" ]; then
        awk -v id="$id" -v newsalary="$salary" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$8 = newsalary} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    
    if [ "$email" != "" ]; then
        awk -v id="$id" -v newemail="$email" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$9 = newemail} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    
    if [ "$phone" != "" ]; then
        awk -v id="$id" -v newphone="$phone" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$10 = newphone} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    read -p "Bạn có muốn tiếp tục (yes/no)? " option
done

echo "Kết thúc chương trình."
}