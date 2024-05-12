#!/bin/bash
# For MacOS
checkDOB(){
    # -j: date không thay đổi giá trị của hệ thống ngày và giờ, mà chỉ thực hiện phân tích và định dạng ngày được cung cấp.
    # -f "%d/%m/%Y": xác định định dạng của chuỗi ngày tháng năm qua tham số $1
    # "+%d/%m/%Y": xác định định dạng của kết quả mà date sẽ trả về
    [[ $(date -j -f "%d/%m/%Y" "$1" "+%d/%m/%Y" 2> /dev/null) == $1 ]] && return 0 || return 1
}

checkEmployeeExistence() {
    grep -q "^$1#" dataNV.txt && return 0 ||  return 1
}

checkSalaryValidity() {
    [[ $1 =~ ^[0-9]+$ ]] && [[ $1 -ge 0 ]]
}

# Kiểm tra xem file dataNV.txt và LuongThayDoi.txt có tồn tại không
if [ ! -f "dataNV.txt" ]; then
    echo "File dataNV.txt khong ton tai"
    exit 1
fi

if [ ! -f "LuongThayDoi.txt" ]; then
    echo "File LuongThayDoi.txt Khong ton tai."
    exit 1
fi

function nhapLuongNhanVien(){
    clear
    option="yes"
    until [[ "$option" == "no" || "$option" == "n" ]]; do
        read -p "Nhap ma nhan vien: " ma_nv
        if ! checkEmployeeExistence "$ma_nv"; then
            echo "ma nhan vien $ma_nv khong ton tai trong file dataNV.txt. Vui long nhap lai."
            continue
        fi
        
        read -p "Nhap muc luong: " muc_luong
        while ! checkSalaryValidity "$muc_luong"; do
            read -p "Muc luong la so va khong duoc am. Vui long nhap lai: " muc_luong
        done

        read -p "Nhap ngay ap dung (dạng dd/mm/yyyy): " ngay_ap_dung
        while ! checkDOB2 "$ngay_ap_dung"; do
            echo "Ngay nhap vao khong hop le. Vui long nhap lai theo đinh dang DD/MM/YYYY."
            echo -n "Ngay sinh (DD/MM/YYYY): "
            read ngay_ap_dung
        done

        # Thêm dữ liệu lương vào file LuongThayDoi.txt
        echo "$ma_nv#$ngay_ap_dung#$muc_luong" >> LuongThayDoi.txt
        awk -v id="$ma_nv" -v newML="$muc_luong" 'BEGIN {FS = "#"; OFS = "#"} $1 == id && $8=="-1" {$8 = newML} 1' dataNV.txt > tmp 
        mv tmp dataNV.txt
        echo "Đa them du lieu cho nhan vien co ma $ma_nv."

        read -p "Ban co muon tiep tuc (yes/no)? " option
    done

    echo "Ket thuc chuong trinh."
}

