
await() { echo -e "\n\n$1"; read -rsn1 -p "Press any key to continue" && echo -e "\n\n"; }

randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;}

change_cpuser_passwd() {
	local logfile="./log.tmp"
	for user_file in /var/cpanel/users/*; do 
		username=$(grep "USER=" $user_file | cut -f2 -d '=' | xargs)
		passwd -S $username
		password=$(randpw)
		echo "${username} | ${password}" >> $logfile
		#echo $password | passwd --stdin $username
		await "${username} | ${password}"
	done
}
