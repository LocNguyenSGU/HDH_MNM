#!/bin/bash

LANG=vi_VN.UTF-8

function func131 {
	option="y"
	while [[ $option == "y" || $option == "yes" ]] ; do
	clear
	coin=0
	regex='^[a-zA-Z0-9 ]+$'
	while true
	do
		read -p "Nhap ten don vi muon tim kiem : " tenDonVi
		if [[ $tenDonVi =~ $regex ]]
		then
			break
		else
			echo "Ten don vi chi chua chu cai, khoang trang"
		fi
	done
	tenDonVi=$(echo $tenDonVi | tr '[:upper:]' '[:lower:]')
	printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
	echo "-----------------------------------------------------------------------------------------------------------------------"
	awk -F '#' -v tdv="$tenDonVi" '{if (tdv == tolower($7)) {printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n",$1,$2,$3,$4,$5,$6,$7,$9,$10,$11;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(y/n)?" option
	until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(yes/no)?" option
	done
	done 
}
function func132 {
	option="y"
	while [[ $option == "y" || $option == "yes" ]]
		do
			clear
			coin=0
			regexAlpha='^[a-zA-Z0-9 ]+$'
			while true
				do
					read -p "Nhap ten don vi : " tenDonVi
					if [[ $tenDonVi =~ $regexAlpha ]]
					then
						break
					else
						echo "Ten don vi chi chua chu cai, khoang trang"
					fi
				done
	
	
			regexNumber='^[0-9]{4}$'
			while true
				do
					read -p "Nhap nam sinh : " namSinh
					if [[ $namSinh =~ $regexNumber ]]
					then
						break
					else
						echo "Nam sinh chi chua 4 chu so (YYYY vi du: 1999)"
					fi
				done
			printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
			echo "-----------------------------------------------------------------------------------------------------------------------"
			tenDonVi=$(echo $tenDonVi | tr '[:upper:]' '[:lower:]')
			awk -F '#' -v tdv="$tenDonVi" -v ns="$namSinh" '{split($4,date,"/");if ( tdv == tolower($7) && ns > date[3] ) {printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n",$1,$2,$3,$4,$5,$6,$7,$9,$10,$11;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
			read -p "Ban co muon tiep tuc khong(y/n)?" option
			until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]
				do
					echo "ki tu khong hop le"
					read -p "Ban co muon tiep tuc khong(yes/no)?" option
				done
		done
}


function func133 {
	option="y"
	while [[ $option == "y" || $option == "yes" ]] ; do
	clear
	regexNumber='^[0-9]{2}$'
	coin=0
	while true
	do
		read -p "Nhap thang sinh : " thangSinh
		temp=$thangSinh
		thangSinh=$((10#$thangSinh))
		if [[ $temp =~ $regexNumber && $thangSinh -ge 1 && $thangSinh -le 12  ]]
		then
				break;
		else
			echo "Thang sinh chi tu 1 den 12 và thuoc dang MM (vi du: 06)"
		fi
	done
	printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
	echo "-----------------------------------------------------------------------------------------------------------------------"
	awk -F '#' -v ts="$thangSinh" '{split($4,date,"/");if ( ts == date[2]) {printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n",$1,$2,$3,$4,$5,$6,$7,$9,$10,$11;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(y/n)?" option
	until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(yes/no)?" option
	done
	done
}


function func134 {
	option="y"
	while [[ $option == "y" || $option == "yes" ]] ; do
	clear
	coin=0
	regexAlpha='^[a-zA-Z]+$'
	while true
	do
		read -p "Nhap chu can tim trong ho ten : " hoTen
		if [[ $hoTen =~ $regexAlpha ]]
		then
			break
		else
			echo "Chu can tim chi chua chu cai"
		fi
	done
	
	
	while true
	do
		read -p "Nhap gioi tinh (nam hoac nu): " gioiTinh
		gioiTinh=$(echo $gioiTinh | tr '[:upper:]' '[:lower:]')
		if [[ $gioiTinh =~ $regexAlpha && "$gioiTinh" = "nam" || "$gioiTinh" = "nu"  ]]
		then
			break
		else
			echo "Gioi tinh la nam hoac nu"
		fi
	done
	
	regexNumber='^[0-9]{4}$'
	while true
	do
		read -p "Nhap nam sinh: " namSinh
		if [[ $namSinh =~ $regexNumber ]]
		then
			break
		else
			echo "Nam sinh chi chua 4 chu so (YYYY vi du: 1999)"
		fi
	done
	printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n" "ID" "Ho va ten lot" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Don vi" "Email" "So dien thoai" "Chuc vu"
	echo "-----------------------------------------------------------------------------------------------------------------------"
	awk -F '#' -v ht="$hoTen" -v ns="$namSinh" -v gt="$gioiTinh" '{split($4,date,"/");if ( tolower(gt) == tolower($6) && ns == date[3] && ( tolower($2) ~ tolower(ht) || tolower($3) ~ tolower(ht) ) ) {printf "|%-4s|%-14s|%-7s|%-11s|%-15s|%-10s|%-8s|%-15s|%-13s|%-12s|\n",$1,$2,$3,$4,$5,$6,$7,$9,$10,$11;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(yes/no)? " option
	until [[ $option == "y" || $option == "n" || $option == "yes" || $option == "no" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(yes/no)?" option
	done
	done
}


