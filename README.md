# self-decrypt-maker

self-decrypt-maker is a simple shell script to encrypt a file into a self-decrypting shell script.  It produces self-decrypting shell program which depends on sh, awk and openssl.

## Usage example

Run the test.sh script, enter the same password.

```
$ ./test.sh 
#!/bin/sh -v

mkdir -p test

cat > ./test/test.txt << EOF
This is a test file.
Just a test file.
EOF

./self-decrypt-maker ./test/test.txt
enter aes-256-cbc encryption password:
Verifying - enter aes-256-cbc encryption password:

more ./test/test.txt.self-decrypt.sh
#!/bin/sh
FILE=`echo $0 | sed 's/.self-decrypt.sh$//'`
BASE64=`awk '/^__BASE64_ENCRYPT_BELOW__/ {print NR + 1; exit 0; }' $0`
tail -n+$BASE64 $0 |\
    openssl base64 -d |\
    openssl enc -aes-256-cbc -salt -d -out ${FILE}.decrypted ||\
    rm ${FILE}.decrypted
exit 0
__BASE64_ENCRYPT_BELOW__
U2FsdGVkX1/4cDAotZYGuMC+sP7qpoQD/Zjtg8RJl7eVQEvr57Tv1JZWsVkB00QC
foTttdhOo/FqKjeqJQPYHg==

sh ./test/test.txt.self-decrypt.sh
enter aes-256-cbc decryption password:

more ./test/test.txt.decrypted
This is a test file.
Just a test file.

diff ./test/test.txt ./test/test.txt.decrypted

$
```
