#!/bin/bash


checkEmployeeExistence() {
    grep -q "^$1#" dataNV.txt && return 0 ||  return 1
}
# Kiểm tra xem file dataNV.txt và LuongThayDoi.txt có tồn tại không
if [ ! -f "dataNV.txt" ]; then
    echo "File dataNV.txt không tồn tại."
    exit 1
fi

if [ ! -f "LuongThayDoi.txt" ]; then
    echo "File LuongThayDoi.txt không tồn tại."
    exit 1
fi

function nhapLuongNhanVien(){
option="yes"

until [ "$option" == "no" ]; do
clear
    read -p "Nhập mã nhân viên: " ma_nv
    if ! checkEmployeeExistence "$ma_nv"; then
        echo "Mã nhân viên $ma_nv không tồn tại trong file dataNV.txt. Vui lòng nhập lại."
        continue
    fi
    read -p "Nhập mức lương: " muc_luong
    read -p "Nhập ngày áp dụng (dạng yyyy-mm-dd): " ngay_ap_dung

    # Thêm dữ liệu lương vào file dataNV.txt
    echo "$ma_nv#$muc_luong#$ngay_ap_dung" >> LuongThayDoi.txt
    echo "Đã thêm dữ liệu lương cho nhân viên có mã $ma_nv."

    read -p "Bạn có muốn tiếp tục (yes/no)? " option
done

echo "Kết thúc chương trình."
}