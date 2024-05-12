#!/bin/bash

function docFileNV {
    if [ -f dataNV.txt ]; then
        printf "%s\n" "                                          DANH SACH NHAN VIEN"
        printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-8s|%-15s|%-10s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Que quan" "Gioi tinh" "Don vi" "Luong" "Email" "So dien thoai"
        printf "%s\n" "--------------------------------------------------------------------------------------------------------------------"
        awk -F '#' '{
            printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-8s|%-15s|%-13s|\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
        }' dataNV.txt
        printf "%s\n" "--------------------------------------------------------------------------------------------------------------------"
    else
        echo "Tệp dataNV.txt không tồn tại."
    fi
}

function quaTrinhThayDoiMucLuongTheoIdNV {
	clear
    read -p "Nhập mã nhân viên cần kiểm tra: " idNV
    if ! grep -q "^$idNV#" dataNV.txt; then
        echo "Ma nhan vien $idNV khong ton tai."
        return
    fi
    echo "Qua trinh thay doi muc luong cua nhan vien co ma $idNV:"
    awk -F "#" -v id="$idNV" 'id == $1 {print "Ngay: " $2 " - Luong: " $3}' LuongThayDoi.txt
}

function thongKeDanhSachMucLuongMoiNhatNamTuXDenY {
    clear
    read -p "Nhap muc luong X: " mucLuongX
    read -p "Nhap muc luong Y: " mucLuongY
    regexNumber='^[0-9]+$'
    
    if ! [[ $mucLuongX =~ $regexNumber ]] || ! [[ $mucLuongY =~ $regexNumber ]]; then
        echo "Muc luong phai la so."
        return
    fi
    if [ $mucLuongX -gt $mucLuongY ]; then
        echo "Muc luong X phai nho hon muc luong Y."
        return
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
    printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-8s|%-15s|%-10s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Que quan" "Gioi tinh" "Don vi" "Luong" "Email" "So dien thoai"
    printf "%s\n" "--------------------------------------------------------------------------------------------------------------------"
    # In ra thông tin của từng nhân viên trong mảng
    for dataNhanVien in "${danhSachNhanVien[@]}"; do
        echo "$dataNhanVien" | awk -F '#' '{
            printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-8s|%-15s|%-13s|\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
        }'
    done
}
function lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi { # hàm này in ra kết quả đúng nhưng định dạng của nó bị xấu
    # sẽ chỉnh lại sau
    clear
    declare -a danhSachNVCoMucLuongCaoNhat  # Khai báo một mảng để lưu trữ thông tin của nhân viên có mức lương cao nhất theo từng đơn vị

    while IFS= read -r line; do
        danhSachNVCoMucLuongCaoNhat+=("$line")
    done < <(awk -F '#' '{
        unit = $7
        salary = $8
        if (salary >= max_salary[unit]) {
            max_salary[unit] = salary
            employee_info[unit, salary] = employee_info[unit, salary] ? employee_info[unit, salary] "\n" $0 : $0
        }
    }
    END {
        for (unit in max_salary) {
            printf "|%-15s|%-8s|%-8s|%-15s|%-13s|\n", "Đơn vị: " unit, "- Mức lương cao nhất:", "", max_salary[unit], ""
            split(employee_info[unit, max_salary[unit]], employees, "\n")
            for (i in employees) {
                print employees[i]
            }
        }
    }' dataNV.txt)

    # In ra danh sách nhân viên có mức lương cao nhất theo từng đơn vị
    for nv in "${danhSachNVCoMucLuongCaoNhat[@]}"; do
        echo "$nv" | awk -F '#' '{
            printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-8s|%-15s|%-13s|\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
        }'
    done
}