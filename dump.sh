#!/bin/bash

#structure of efuse form signing-tool-g12a-dev/efuse-gen.sh
#structure of efuse can be different and has on box 

dd if=efuse.bin of=licence.bin bs=16 skip=10 count=1

dd if=efuse.bin of=licence2.bin bs=16 skip=25 count=1

dd if=efuse.bin of=roothash.bin bs=16 skip=20 count=2

dd if=efuse.bin of=aeskey.bin bs=16 skip=2 count=2

dd if=efuse.bin of=m4roothash.bin bs=16 skip=22 count=2

dd if=efuse.bin of=m4aeskey.bin bs=16 skip=5 count=1

dd if=efuse.bin of=password.bin bs=16 skip=6 count=2

dd if=efuse.bin of=scanpasswordhash.bin bs=16 skip=8 count=2

dd if=efuse.bin of=userefuse.bin bs=16 skip=26 count=6

dd if=efuse.bin of=kwrap.bin bs=16 skip=31 count=1


