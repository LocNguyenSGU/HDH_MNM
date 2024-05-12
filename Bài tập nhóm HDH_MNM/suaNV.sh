#!/bin/bash
# For MacOS
checkDOB(){
    # -j: date không thay đổi giá trị của hệ thống ngày và giờ, mà chỉ thực hiện phân tích và định dạng ngày được cung cấp.
    # -f "%d/%m/%Y": xác định định dạng của chuỗi ngày tháng năm qua tham số $1
    # "+%d/%m/%Y": xác định định dạng của kết quả mà date sẽ trả về
    [[ $(date -j -f "%d/%m/%Y" "$1" "+%d/%m/%Y" 2> /dev/null) == $1 ]] && return 0 || return 1
}

# Hàm kiểm tra xem ngày có hợp lệ khong
checkDOB2() {
    date -d "$1" "+%d/%m/%Y" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra tên có kí tự đặc biệt khong
function is_valid_name() {
    if [[ "$1" =~ ^[[:alnum:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra tên có chứa kí tự chữ và dấu cách
function is_valid_name1() {
    if [[ "$1" =~ ^[[:alpha:][:space:]-]+$ ]]; then
        return 0
    else
        return 1
    fi
}


# Hàm kiểm tra so dien thoai có hợp lệ khong
function is_valid_phone() {
    if [[ "$1" =~ ^[0-9]{10}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra email có đúng định dạng chuẩn khong
function is_valid_email() {
    if [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra giới tính có giá trị hợp lệ
function is_valid_gender() {
    gender=$(echo "$1" | tr '[:upper:]' '[:lower:]')  # Chuyển đổi sang chữ thường
    if [[ "$gender" =~ ^(nam|nu)$ ]]; then
        return 0
    else
        return 1
    fi
}

# Hàm kiểm tra mức lương có giá trị hợp lệ
function is_valid_salary() {
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}



function suaNV(){
# Kiểm tra xem dataNV.txt có tồn tại khong
if [ ! -f "dataNV.txt" ]; then
    echo "File dataNV.txt khong tồn tại."
    exit 1
fi

option="yes"

until [[ "$option" == "no" || "$option" == "n" ]]; do
    clear
    echo "Danh sách nhân viên:"
    echo "===================="
    cat dataNV.txt | awk -F '#' '{print $1 " - " $2 " " $3}'

    read -p "Nhap ma nhan vien can chinh sua: " id

    emp_info=$(awk -F'#' -v id="$id" '$1 == id {print}' dataNV.txt)
    if [ -z "$emp_info" ]; then
        echo "Ma so nhan vien khong ton tai." && continue
    fi

    read -p "Nhap ho và ten lot moi (neu khong muon thay doi, nhan Enter): " fname
    if [ ! -z "$fname" ]; then
        while ! is_valid_name1 "$fname"; do
            echo "Ho va ten lot khong duoc chua ki tu dac biet. Vui long nhap lai."
            echo -n "Ho va ten lot: "
            read fname
        done
    fi
    read -p "Nhap ten moi (neu khong muon thay doi, nhan Enter): " name
    if [ ! -z "$name" ]; then
        while ! is_valid_name "$name"; do
            echo "ten khong đuoc chua ki tu đac biet. Vui long nhap lai."
            read -p "nhap ten moi: " name
        done
    fi

    read -p "nhap ngay sinh moi (neu khong muon thay doi, nhan Enter): " dob
    if [ ! -z "$dob" ]; then
        while ! checkDOB2 "$dob"; do
            echo -p "Ngay sinh khong hop le. Vui long nhap lai (dd/mm/yyyy)." $dob
        done
    fi
       
    read -p "nhap noi sinh moi (neu khong muon thay doi, nhan Enter): " place_of_birth
    if [ ! -z "$place_of_birth" ]; then
        while ! is_valid_name "$place_of_birth"; do
            echo "Noi sinh khong co ki tu đat biet. Vui long nhap lai"
            echo -n "Noi sinh moi: "
            read place_of_birth
        done
    fi
    read -p "Nhap gioi tinh moi (neu khong muon thay doi, nhan Enter): " gender
    if [ ! -z "$gender" ]; then
        while ! is_valid_gender "$gender"; do
            echo "Gioi tinh la nam hoac nu.Vui long nhap lai"
            echo -n "Gioi tinh moi: "
            read gender
        done
    fi
    read -p "Nhap don vi (neu khong muon thay doi, nhan Enter): " department
    if [ ! -z "$department" ]; then
        while ! is_valid_name "$department"; do
            echo "Don vi khong chua ki tu dac biet. Vui long nhap lai"
            echo -n "Don vi moi: "
            read department
        done
    fi
    department=$(echo "$department" | tr '[:upper:]' '[:lower:]')
    
    read -p "Nhap email moi (neu khong muon thay doi, nhan Enter): " email
    if [ ! -z "$email" ]; then
        while ! is_valid_email "$email"; do
            echo "Dinh dang email khong hop le. Vui long nhap lai."
            echo -n "Email moi: "
            read email
        done
    fi
    read -p "Nhap so dien thoai moi (neu khong muon thay doi, nhan Enter): " phone
    if [ ! -z "$phone" ]; then
        while ! is_valid_phone "$phone"; do
            echo "So dien thoai khong hop le. Vui long nhap lai (10 chu so)."
            echo -n "So dien thoai: "
            read phone
        done
    fi  

    read -p "Nhap chuc vu (neu khong muon thay doi, nhan Enter): " chucVu
    if [ ! -z "$chucVu" ]; then
        while ! is_valid_name "$chucVu"; do
            echo "Chuc vu khong chua ki tu dac biet. Vui long nhap lai"
            echo -n "Chuc vu moi: "
            read chucVu
        done
    fi  
    
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
    
    
    if [ "$email" != "" ]; then
        awk -v id="$id" -v newemail="$email" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$9 = newemail} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    
    if [ "$phone" != "" ]; then
        awk -v id="$id" -v newphone="$phone" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$10 = newphone} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi

    if [ "$chucVu" != "" ]; then
        awk -v id="$id" -v newCV="$chucVu" 'BEGIN {FS = "#"; OFS = "#"} $1 == id {$11 = newCV} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
    fi
    echo "Da cap nhat thong tin nhan vien co ma so $id thanh cong"
    read -p "Ban co muon tiep tuc (yes/no or y/n)? " option
done

}
