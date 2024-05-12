#bin/bash

LANG=vi_VN.UTF-8

func131() {
	clear
	coin=0
	regex='^[a-zA-Z ]+$|^[\p{L} ]+$'
	while true
	do
		read -p "Nhập tên đơn vị muốn tìm kiếm : " tenDonVi
		if [[ $tenDonVi =~ $regex ]]
		then
			break
		else
			echo "Tên đơn vị chỉ chứa chữ cái , khoảng trắng"
		fi
	done
	printf "|%-4s|%-18s|%-8s|%-10s|%-10s|%-5s|%-10s|%-10s|%-15s|%-10s\n" "STT" "Họ" "Tên" "Ngày sinh" "Địa chỉ" "Giới tính" "Phòng" "Lương" "Email" "SDT"
echo "-------------------------------------------------------------------------------------"
	awk -F '#' -v tdv="${tenDonVi,,}" '{if (tdv == tolower($7)) {printf "|%-4s|%-19s|%-10s|%-10s|%-10s|%-5s|%-10s|%-10s|%-15s|%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
}

func132(){
	coin=0
	regexAlpha='^[a-zA-Z ]+$|^[\p{L} ]+$'
	while true
	do
		read -p "Nhập tên đơn vị : " tenDonVi
		if [[ $tenDonVi =~ $regexAlpha ]]
		then
			break
		else
			echo "Tên đơn vị chỉ chứa chữ cái , khoảng trắng"
		fi
	done
	
	
	regexNumber='^[0-9]+$'
	while true
	do
		read -p "Nhap nam sinh : " namSinh
		if [[ $namSinh =~ $regexNumber ]]
		then
			break
		else
			echo "Năm sinh chỉ chữa chữ số"
		fi
	done
	
	awk -F '#' -v tdv="${tenDonVi,,}" -v ns="${namSinh,,}" '{split($4,date,"/");if ( tdv == tolower($7) && ns == date[3] ) {print;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
}


func133(){
	regexNumber='^[0-9]+$'
	coin=0
	while true
	do
		read -p "Nhập tháng sinh : " thangSinh
		if [[ $thangSinh =~ $regexNumber && $thangSinh -ge 1 && $thangSinh -le 12  ]]
		then
				break;
		else
			echo "Tháng sinh chỉ chứa số nằm trong khoảng từ 1-12 "
		fi
	done
	
	awk -F '#' -v ts="${thangSinh,,}" '{split($4,date,"/");if ( ts == date[2]) {print;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
}


func134(){
	coin=0
	regexAlpha='^[a-zA-Z ]+$|^[\p{L} ]+$'
	while true
	do
		read -p "Nhập chữ cần tìm trong họ tên  : " hoTen
		if [[ $hoTen =~ $regexAlpha ]]
		then
			break
		else
			echo "chữ cần tìm chỉ chứa chữ cái , khoảng trắng"
		fi
	done
	
	
	while true
	do
		read -p "Nhap gioi tinh  : " gioiTinh
		if [[ $gioiTinh =~ $regexAlpha && "${gioiTinh,,}" = "nam" || "${gioiTinh,,}" = "nu"  ]]
		then
			break
		else
			echo "Giới tính là nam hoặc nữ"
		fi
	done
	
	regexNumber='^[0-9]+$'
	while true
	do
		read -p "Nhập năm sinh : " namSinh
		if [[ $namSinh =~ $regexNumber ]]
		then
			break
		else
			echo "Năm chỉ chứa số"
		fi
	done
	awk -F '#' -v ht="${hoTen,,}" -v ns="${namSinh,,}" -v gt="${gioiTinh,,}" '{split($4,date,"/");if ( gt == tolower($6) && ns == date[3] && ( tolower($2) ~ ht || tolower($3) ~ ht ) ) {print;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
}


