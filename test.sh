#!/bin/sh -v

mkdir -p test

cat > ./test/test.txt << EOF
This is a test file.
Just a test file.
EOF

./self-decrypt-maker ./test/test.txt

more ./test/test.txt.self-decrypt.sh

sh ./test/test.txt.self-decrypt.sh

more ./test/test.txt.decrypted

diff ./test/test.txt ./test/test.txt.decrypted
