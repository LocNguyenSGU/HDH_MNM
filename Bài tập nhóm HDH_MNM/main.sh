#!/bin/bash


source lam.sh
source loc.sh
source themNV.sh
source suaNV.sh
source nhapLuong.sh


while true
    do
    	clear
    	echo "0. In danh sach nhan vien"
    	echo "1. Nhap thong tin nhan vien"
    	echo "2. Cap nhat thong tin nhan vien (tru ma so nhan vien khong the chinh sua)"
        echo "3. Thong ke danh sach nhan vien theo tung don vi"
        echo "4. Liet ke danh sach nhan vien cua don vi x , co nam sinh y (x,y do nguoi dung nhap vao)"
        echo "5. Thong ke danh sach nhan vien co sinh nhat vao thang x (x do nguoi dung nhap vao)"
        echo "6. Liet ke danh sach nhan vien  ma ho ten co chu x, gioi tinh y, sinh nam z (x,y,z do nguoi dung nhap vao)"
        echo "7. Nhap luong nhan vien"
    	echo "8. Xem qua trinh thay doi luong cua 1 nhan vien"
    	echo "9. Thong ke danh sach nhan vien co muc luong moi nhat nam trong khoang x den y"
    	echo "10. Liet ke danh sach nhan vien co muc luong lon nhat theo tung don vi"
        echo "11. Thoat"
        read -p "Nhap lua chon cua ban : " luaChon
        case $luaChon in
            0) docFileNV;;
            1) themNV;;
            2) suaNV;;
            3) func131;;
            4) func132;;
            5) func133;;
            6) func134;;
            7) nhapLuongNhanVien;;
            8) quaTrinhThayDoiMucLuongTheoIdNV;;
            9) thongKeDanhSachMucLuongMoiNhatNamTuXDenY;;
            10) lietKeDanhSachNVCoMucLuongLonNhatTheoTungDonVi;;
            11) break;;
            *) echo "Lua chon không hợp lê";;
        esac
        echo "Nhan phim bat ki de tiep tuc"
        # -n 1 :an 1 phim
        # -s : tat hien thi phim da nhap
        # -r : bat ca dau /
        # -p : hien thi dong echo truoc khi read
        read -n 1 -s  -r -p "" 
    done