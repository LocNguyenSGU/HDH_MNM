#bin/bash

LANG=vi_VN.UTF-8

function func131 {
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
	
	cat dataNV.txt | grep -i "#$tenDonVi#" | awk -F '#' '{ coin=1; print $1 " - " $2 " " $3 } END {if (coin == 0) print"Không có kết quả"}'
}

function func132 {
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
	
	while read -r line 
	do
		temp=($( echo "$line" | cut -d'#' -f4 | cut -d'/' -f3 ))
		tempDonVi=($( echo "$line" | cut -d'#' -f7 ))
		if [[ $namSinh -ge $temp && "$tempDonVi" == "$tenDonVi" ]]
		then 
			coin=1
			echo $line | awk -F '#' '{print $1 "-" $2 " " $3}'
		fi
	done < dataNV.txt
	if [ $coin -eq 0 ]; then
		echo "Không có kết quả"
	fi
}


function func133 {
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
	
	while read -r line 
	do
		temp=($( echo "$line" | cut -d'#' -f4 | cut -d'/' -f2 ))
		if [ $thangSinh -eq $temp ]
		then 
			echo $line | awk -F '#' '{print $1 "-" $2 " " $3}'
			coin=1
		fi
	done < dataNV.txt 
	
	if [ $coin -eq 0 ]; then
		echo "Không có kết quả"
	fi
}


function func134 {
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
		if [[ $gioiTinh =~ $regexAlpha && "${gioiTinh}" = "nam" || "${gioiTinh}" = "nu"  ]]
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
	
	while read -r line 
	do
		tempNamSinh=($( echo $line | cut -d'#' -f4 | cut -d'/' -f3 ))
		tempHo=($( echo $line | cut -d'#' -f2 ))
		tempTen=($( echo $line | cut -d'#' -f3 ))
		valueHoTen="";
		valueHoTen=($( echo "$tempHo$tempTen" | grep -i ".*$hoTen.*" ))
		if [ "$valueHoTen" == "" ]
		then
			continue;
		fi	
		
		if [ $tempNamSinh -ne $namSinh ]
		then
			continue;
		fi
		
		tempGioiTinh=($( echo $line | cut -d'#' -f6 ))
		valueGioiTinh=""
		valueGioiTinh=($( echo "$tempGioiTinh" | grep -i "$gioiTinh"))
		if [ "$valueGioiTinh" == "" ]
		then
			continue;
		fi
		coin=1
		echo $line | awk -F '#' '{print $1 "-" $2 " " $3}'
	done < dataNV.txt
	if [ $coin -eq 0 ]; then
		echo "Không có kết quả"
	fi
}

while true
    do
        echo "1. 131"
        echo "2. 132"
        echo "3. 133"
        echo "4. 134"
        echo "5. Exit"
        read -p "Nhap lua chon cua ban : " luaChon
        case $luaChon in
            1) func131;;
            2) func132;;
            3) func133;;
            4) func134;;
            5) break;;
            *) echo "Lua chon không hợp lê";;
        esac
    done



