#bin/bash

LANG=vi_VN.UTF-8

func131() {
	option="y"
	while [ $option == "y" ] ; do
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
	tenDonVi=$(echo $tenDonVi | tr '[:upper:]' '[:lower:]')
	printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n" "STT" "Ho" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Phong" "Luong" "Email" "SDT"
	echo "-------------------------------------------------------------------------------------"
	awk -F '#' -v tdv="$tenDonVi" '{if (tdv == tolower($7)) {printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(y/n)?" option
	until [[ $option == "y" || $option == "n" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(y/n)?" option
	done
	done 
}
func132(){
	option="y"
	while [ $option == "y" ]
		do
			clear
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
			printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n" "STT" "Ho" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Phong" "Luong" "Email" "SDT"
			tenDonVi=$(echo $tenDonVi | tr '[:upper:]' '[:lower:]')
			awk -F '#' -v tdv="$tenDonVi" -v ns="$namSinh" '{split($4,date,"/");if ( tdv == tolower($7) && ns >= date[3] ) {printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
			read -p "Ban co muon tiep tuc khong(y/n)?" option
			until [[ $option == "y" || $option == "n" ]]
				do
					echo "ki tu khong hop le"
					read -p "Ban co muon tiep tuc khong(y/n)?" option
				done
		done
}


func133(){
	option="y"
	while [ $option == "y" ] ; do
	clear
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
	printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n" "STT" "Ho" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Phong" "Luong" "Email" "SDT"
	awk -F '#' -v ts="$thangSinh" '{split($4,date,"/");if ( ts == date[2]) {printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(y/n)?" option
	until [[ $option == "y" || $option == "n" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(y/n)?" option
	done
	done
}


func134(){
	option="y"
	while [ $option == "y" ] ; do
	clear
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
	printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n" "STT" "Ho" "Ten" "Ngay sinh" "Dia chi" "Gioi tinh" "Phong" "Luong" "Email" "SDT"
	awk -F '#' -v ht="$hoTen" -v ns="$namSinh" -v gt="$gioiTinh" '{split($4,date,"/");if ( tolower(gt) == tolower($6) && ns == date[3] && ( tolower($2) ~ tolower(ht) || tolower($3) ~ tolower(ht) ) ) {printf "|%-4s|%-18s|%-8s|%-10s|%-13s|%-10s|%-10s|%-10s|%-15s|%-10s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10;coin=1}}END{ if ( coin == 0 ) {print"Khong co ket qua"}}' dataNV.txt
	read -p "Ban co muon tiep tuc khong(y/n)?" option
	until [[ $option == "y" || $option == "n" ]]
	do
		echo "ki tu khong hop le"
		read -p "Ban co muon tiep tuc khong(y/n)?" option
	done
	done
}


