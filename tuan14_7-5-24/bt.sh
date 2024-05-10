#!/bin/bash

function docFile {
    while read line 
    do
        echo $line
    done < dsnv.data
}

function idTangTuDong() {
    dongCuoi=$(tail -1 dsnv.data)
    id=$(echo $dongCuoi | cut -d "," -f 1)
    id=$((id + 1))
    echo $id
}
#!/bin/bash

function docFile {
    while read line 
    do
        echo $line
    done < dsnv.data
}

function idTangTuDong() { #sort id, lấy id cuối cùng cộng thêm 1
    dongCuoi=$(tail -1 dsnv.data)
    id=$(echo $dongCuoi | cut -d "," -f 1)
    id=$((id + 1))
    echo $id
}

checkDOB(){
    # -j: date không thay đổi giá trị của hệ thống ngày và giờ, mà chỉ thực hiện phân tích và định dạng ngày được cung cấp.
    # -f "%d/%m/%Y": xác định định dạng của chuỗi ngày tháng năm qua tham số $1
    # "+%d/%m/%Y": xác định định dạng của kết quả mà date sẽ trả về
    [[ $(date -j -f "%d/%m/%Y" "$1" "+%d/%m/%Y" 2> /dev/null) == $1 ]] && return 0 || return 1
}
function them1NV {
    echo "Nhập tên nhân viên: "
    read tenNV
    ngaySinh=""
    while [ "$ngaySinh" == "" ]
    do
        read -p "Nhap ngày tháng năm sinh có dạng dd/mm/yyyy: " ngaySinh
        checkDOB "$ngaySinh"
        [ $? -eq 0 ] && break || ngaySinh=""
    done
    echo "Nhập quê quán: "
    read queQuan
    idMoi=$(idTangTuDong)
    echo "$idMoi, $tenNV, $ngaySinh, $queQuan" >> dsnv.data
}
function capNhatTenNV {
    echo "Nhập id nhân viên cần cập nhật: "
    read idNV
    echo "Nhập tên mới: "
    read tenMoi
    if [ "tenMoi" != "" ]; then 
        awk -v idNV="$idNV" -v tenMoi="$tenMoi" 'BEGIN {FS=","; OFS=","} $1 == idNV $2 = tenMoi' dsnv.data > temp.data
        mv temp.data dsnv.data
    fi
}

while true
do
    echo "1. Đọc danh sách nhân viên"
    echo "2. Thêm 1 nhân viên"
    echo "3. Cập nhật tên nhân viên"
    echo "4. Thoát"
    echo "Chọn chức năng: "
    read chon
    case $chon in 
        1) docFile;;
        2) them1NV;;  
        3) capNhatTenNV;;  
        4) break;;
    esac
done
