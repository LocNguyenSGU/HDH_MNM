#!/bin/bash

function docFileNV {
    clear
    if [ -f dataNV.txt ]; then
        printf "%s\n" "                                          DANH SACH NHAN VIEN"
        printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-10s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Que quan" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
        printf "%s\n" "------------------------------------------------------------------------------------------------------------------------"
        awk -F '#' '{
            printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n", $1, $2, $3, $4, $5, $6, $7, $9, $10, $11
        }' dataNV.txt
        printf "%s\n" "------------------------------------------------------------------------------------------------------------------------"
    else
        echo "Tep dataNv.txtx khong ton tai."
    fi
}

function quaTrinhThayDoiMucLuongTheoIdNV {
    clear
    option="y"
    while [[ $option == "yes" || $option == "y" ]]; do
        read -p "Nhap ma nhan vien can kiem tra: " idNV

        # Kiem tra xem ma nhan vien co ton tai trong tap tin khong
        if ! grep -q "^$idNV#" dataNV.txt; then
            echo "Ma nhan vien $idNV khong ton tai."
            continue
        fi
        awk -F "#" -v id="$idNV" '$1 == id {print "Ten nhan vien: " $2 " " $3}' dataNV.txt
        # Su dung awk de loc va in ra qua trinh thay doi muc luong dua tren ma nhan vien
        sort -t "#" -k2.7,2.10n -k2.4,2.5n -k2.1,2.2n LuongThayDoi.txt |  awk -F "#" -v id="$idNV" '$1 == id {print "Ngay: " $2 " - Luong: " $3}'
	    read -p "Ban co muon tiep tuc khong(y/n)?" option
        until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]; do
            echo "Ki tu khong hop le."
            read -p "Ban co muon tiep tuc khong? (yes/no): " option
        done
    done
}


function thongKeDanhSachMucLuongMoiNhatNamTuXDenY {
    clear
    option="yes"
    while [[ $option == "yes" || $option == "y" ]]
    do
        regexNumber='^[0-9]+$'
        read -p "Nhap muc luong x: " mucLuongX
        while ! [[ $mucLuongX =~ $regexNumber ]]; do 
            echo "Muc luong x phai la so va lon hon hoac bang 0."
            read -p "Nhap muc luong x: " mucLuongX
        done
        read -p "Nhap muc luong y: " mucLuongY
        while ! [[ $mucLuongY =~ $regexNumber ]]; do 
            echo "Muc luong y phai la so va lon hon hoac bang 0."
            read -p "Nhap muc luong y: " mucLuongY
        done
        # Kiểm tra xem mức lương X có nhỏ hơn mức lương Y không
        if [ $mucLuongX -gt $mucLuongY ]; then
            echo "Muc luong x phai nho hon muc luong y."
            continue
        fi
        # Tìm mức lương từ X đến Y
        luong=$(awk -F "#" -v x="$mucLuongX" -v y="$mucLuongY" '$3 >= x && $3 <= y {print}' LuongThayDoi.txt)
        if [ -z "$luong" ]; then
            echo "Khong co nhan vien nao co muc luong nam trong khoang tu $mucLuongX den $mucLuongY."
            return
        fi
        sortNgayTangDan=$(echo "$luong" | sort -t'#' -k2.7,2.10n -k2.4,2.5n -k2.1,2.2n)
        # -t'#': Đặt dấu phân cách là #.
        # -k2.7,2.10n: Sắp xếp theo phần năm (từ cột 7 đến 10) trong ngày tháng năm.
        # -k2.4,2.5n: Nếu phần năm giống nhau, sắp xếp theo phần tháng (từ cột 4 đến 5) trong ngày tháng năm.
        # -k2.1,2.2n: Nếu phần tháng và năm giống nhau, sắp xếp theo phần ngày (từ cột 1 đến 2) trong ngày tháng năm.
        dongCuoi=$(echo "$sortNgayTangDan" | tail -1)
        ngayMoiNhat=$(echo "$dongCuoi" | cut -d "#" -f 2)
        dataLuongMoiNhat=$(echo "$sortNgayTangDan" | grep "$ngayMoiNhat")
        declare -a danhSachNhanVien  # Khai báo một mảng để lưu trữ thông tin của các nhân viên

        while read line; do
            id=$(echo "$line" | cut -d '#' -f 1)
            dataNhanVien="$(grep "^$id#" dataNV.txt)"  # Tìm thông tin của nhân viên trong tệp dataNV.txt
            danhSachNhanVien+=("$dataNhanVien")  # Thêm thông tin của nhân viên vào mảng
        done <<< "$dataLuongMoiNhat"

        echo "Danh sach nhan vien co muc luong moi nhat tu $mucLuongX den $mucLuongY:"
        echo "Ngay co muc luong moi nhat: $ngayMoiNhat"
        printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-10s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Que quan" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
        printf "%s\n" "------------------------------------------------------------------------------------------------------------------------"
        # In ra thông tin của từng nhân viên trong mảng`
        for dataNhanVien in "${danhSachNhanVien[@]}"; do
            echo "$dataNhanVien" | awk -F '#' '{
                printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n", $1, $2, $3, $4, $5, $6, $7, $9, $10, $11
            }'
        done
        read -p "Ban co muon tiep tuc khong(y/n)?" option
        until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]; do
            echo "Ki tu khong hop le."
            read -p "Ban co muon tiep tuc khong? (yes/no): " option
        done
    done
    
}
function test {
    danhSach=$(sort -t'#' -k1.1,1.2n -k2.7,2.10n -k2.4,2.5n -k2.1,2.2n LuongThayDoi.txt | awk -F "#" -v id="1" ' if ($1 == id) {temp=$0} else {print temp; id=$1; temp=$0} END {print temp}')
    ehco "$danhSach" | awk -F "#" '$3 >= 100 && $3 <= 200 {print}'
}

function lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi {
    clear
    awk -F '#' '{
    department = $7
    salary = $8
    employee_info = $0
    if (salary > max_salaries[department]) {
        max_salaries[department] = salary
        max_employees[department] = employee_info
    } else if (salary == max_salaries[department]) {
        max_employees[department] = max_employees[department] "\n" employee_info
    }
}
END {
    printf "                       DANH SACH NHAN VIEN CO MUC LUONG CAO NHAT THEO TUNG DON VI\n"
    printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-10s|%-15s|%-13s|\n", "ID", "Ho va ten lot", "Ten", "Ngay sinh", "Que quan", "Gioi tinh", "Don vi", "Luong", "Email", "So dien thoai"
    printf "----------------------------------------------------------------------------------------------------------------------\n"
    for (department in max_salaries) {
        n = split(max_employees[department], employees, "\n")
        for (i = 1; i <= n; i++) {
            split(employees[i], fields, "#")
            printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-10s|%-15s|%-13s|\n", fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8], fields[9], fields[10]
            if (i < n) {
                split(employees[i+1], next_fields, "#")
                if (next_fields[7] != fields[7]) {
                    printf "----------------------------------------------------------------------------------------------------------------------\n"
                }
            } else {
                printf "----------------------------------------------------------------------------------------------------------------------\n"
            }
        }
    }
}' dataNV.txt
}
