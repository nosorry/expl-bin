##### Copy files via rsync

`rsync --rsh='ssh -p22000' <source folder> 10.11.1.232:~/ -r`

##### Find password plain text

`find /etc /home /var /usr/share \! -group root -type f -exec grep -Iq . {} \; -print0 2>/dev/null | xargs -0 grep -in "password"`

##### gobuster for quick directory search

`gobuster -u 10.11.1.1 -w /usr/share/seclists/Discovery/Web_Content/common.txt -t 80 -a Linux -x .txt,.asp,.php`

##### Kill any tcp port being used

`fuser 445/tcp -k`

##### find passwd strings in windows

`findstr /si password *.txt` <br>
`findstr /si password *.xml` <br>
`findstr /si password *.ini`<br>
<br>
`dir /s *pass* == *cred* == *vnc* == *.config*`<br>
<br>
`findstr /spin “password” *.*`<br>
`findstr /spin “password” *.*`<br>
