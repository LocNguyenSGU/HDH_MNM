#!/bin/bash

function docFile {
    while read line
    do
        echo "$line"
    done < dataNV.txt
}

function quaTrinhThayDoiMucLuongTheoIdNV {
	clear
    read -p "Nhập mã nhân viên cần kiểm tra: " idNV
    awk -F "#" -v id="$idNV" 'id == $1 {print "Ngày: " $2 " - Lương: " $3}' LuongThayDoi.txt
}

function thongKeDanhSachMucLuongMoiNhatNamTuXDenY {
	clear
    read -p "Nhập mức lương X: " mucLuongX
    read -p "Nhập mức lương Y: " mucLuongY
    #tìm mức lương từ X -> Y
    luong=$(awk -F "#" -v x="$mucLuongX" -v y="$mucLuongY" '$3 >= x && $3 <= y {print}' LuongThayDoi.txt)    
    sortNgayTangDan=$(echo "$luong" | sort -t'#' -k2.7,2.10n -k2.4,2.5n -k2.1,2.2n)
    # -t'#': Đặt dấu phân cách là #.
    # -k2.7,2.10n: Sắp xếp theo phần năm (từ cột 7 đến 10) trong ngày tháng năm.
    # -k2.4,2.5n: Nếu phần năm giống nhau, sắp xếp theo phần tháng (từ cột 4 đến 5) trong ngày tháng năm.
    # -k2.1,2.2n: Nếu phần tháng và năm giống nhau, sắp xếp theo phần ngày (từ cột 1 đến 2) trong ngày tháng năm.
    echo "$sortNgayTangDan"
    dongCuoi=$(echo "$sortNgayTangDan" | tail -1)
    echo "Dòng có ngày mới nhất là: $dongCuoi" 
    ngayMoiNhat=$(echo "$dongCuoi" | cut -d "#" -f 2)  
    echo "Ngày mới nhất: $ngayMoiNhat"
    dataLuongMoiNhat=$(echo "$sortNgayTangDan" | grep "$ngayMoiNhat")
    echo "Data luong mới nhất: $dataLuongMoiNhat" 
     while read line
        do
            id=$(echo "$line" | cut -d '#' -f 1)
            if grep -q "^$id#" dataNV.txt; then
                grep "^$id#" dataNV.txt
            fi
        done <<< "$dataLuongMoiNhat"
}


function lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi {
	clear
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
