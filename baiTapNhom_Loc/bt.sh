#!/bin/bash

function docFile {
    while read line
    do
        echo "$line"
    done < dataNV.txt
}

function quaTrinhThayDoiMucLuongTheoIdNV {
    docFile
    read -p "Nhập ID nhân viên cần xem quá trình thay đổi mức lương: " idNV
    echo "Quá trình thay đổi mức lương cho nhân viên có ID $idNV:"
    awk -F '#' -v id="$idNV" '$1 == id {print "Ngày: " $2 " - Mức lương: " $3}' luongThayDoi.txt
}

function thongKeDanhSachMucLuongMoiNhatNamTuXDenY {
    docFile
    read -p "Nhập mức lương X: " mucLuongX
    read -p "Nhập mức lương Y: " mucLuongY
    
    # Lấy ra tất cả các dòng có mức lương nằm trong khoảng X đến Y và lưu vào biến data
    data=$(awk -F '#' -v x="$mucLuongX" -v y="$mucLuongY" '$3 >= x && $3 <= y {print}' luongThayDoi.txt)

    # Sắp xếp theo cột số 2 (ngày tháng năm) theo thứ tự tăng dần
    sorted_data=$(echo "$data" | sort -t '#' -k2,2n)
    echo "$sorted_data"

    # Lấy ra dòng đầu tiên (dòng có ngày mới nhất)
    newest_record=$(echo "$sorted_data" | tail -1)
    ngayLonNhat=$(echo "$newest_record" | cut -d '#' -f 2)
    echo "lon nhat la:  $newest_record"
    echo "ngayLonNhat: $ngayLonNhat"

    # In ra dòng có ngày mới nhất, và nếu có nhiều dòng cùng có ngày mới nhất thì in ra cả các dòng đó
    echo "Danh sách nhân viên có mức lương từ $mucLuongX đến $mucLuongY và có ngày cập nhật mới nhất:"
    dataLuongMoiNhat=$(echo "$sorted_data" | grep "$ngayLonNhat")
    echo "$dataLuongMoiNhat"
    
    while read line; do
        id=$(echo "$line" | cut -d '#' -f 1)  # Trích xuất ID từ dòng hiện tại
        if grep -q "^$id#" dataNV.txt; then   # Tìm kiếm ID trong tệp dataNV.txt
            grep "^$id#" dataNV.txt           # In ra dòng hiện tại của dataNV.txt nếu ID được tìm thấy
        fi
    done <<< "$dataLuongMoiNhat"
}

function lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi {
    awk -F '#' '{
        unit = $7
        salary = $8
        if (salary >= max_salary[unit]) {
            max_salary[unit] = salary
            employee_info[unit, salary] = employee_info[unit, salary] ? employee_info[unit, salary] "\n" $0 : $0
        }
    }
    END {
        print "Danh sách nhân viên có mức lương cao nhất theo từng đơn vị:"
        for (unit in max_salary) {
            print "Đơn vị:", unit, "- Mức lương cao nhất:", max_salary[unit]
            print employee_info[unit, max_salary[unit]]
        }
    }' dataNV.txt
}

while true
do
    echo "1. Đọc file"
    echo "2. Xem quá trình thay đổi lương của 1 nhân viên"
    echo "3. Thống kê danh sách nhân viên có mức lương mới nhất nằm trong khoảng X đến Y"
    echo "4. Liệt kê danh sách nhân viên có mức lương lớn nhất theo từng đơn vị"
    echo "5. Thoát"
    echo "6. 131"
    read -p "Chọn chức năng: " chucNang
    case $chucNang in
        1) docFile;;
        2) quaTrinhThayDoiMucLuongTheoIdNV;;
        3) thongKeDanhSachMucLuongMoiNhatNamTuXDenY;;
        4) lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi;;
        5) break;;
        6) 131;;
        *) echo "Chức năng không hợp lệ";;
    esac
done