#!/bin/bash -e



#		      --generate-efuse-pattern \\
#                      --soc [gxl | txlx | axg | g12a | sm1] \\
#                      [--soc-rev [a | b]] \\
#                      [--root-hash rootkeys.hash] \\
#                      [--password-hash password.hash] \\
#                      [--scan-password-hash password.hash] \\
#                      [--aes-key aeskey.bin] \\
#                      [--m4-root-hash rootkeys.hash] \\
#                      [--m4-aes-key aeskey.bin] \\
#                      [--enable-sb true] \\
#                      [--enable-aes true] \\
#                      [--enable-jtag-password true] \\
#                      [--enable-usb-password true] \\
#                      [--enable-scan-password true] \\
#                      [--enable-anti-rollback true] \\
#                      [--disable-boot-usb true] \\
#                      [--disable-boot-spi true] \\
#                      [--disable-boot-sdcard true] \\
#                      [--disable-boot-nand-emmc true] \\
#                      [--disable-boot-recover true] \\
#                      [--disable-scan-chain true] \\
#                      [--disable-print true] \\
#                      [--disable-jtag true] \\
#                      [--revoke-rsk-0 true] \\
#                      [--revoke-rsk-1 true] \\
#                      [--revoke-rsk-2 true] \\
#                      [--revoke-rsk-3 true] \\
#                      [--user-efuse-file <path-to-general-purpose-user-efuse-data>] \\
#                      [--key-hash-ver [1 | 2]] \\
#                      [--raw-otp-pattern true] \\
#                      -o pattern.efuse

echo "
	Make usb password hash
					"
					


rm -rf ./passwd_salt/password.bin_*

rm -rf ./aml-key/usb.password.hash.bin
					
./stool/amlpwdefs --password ./passwd_salt/password.bin --salt ./passwd_salt/salt.bin

cp -a ./passwd_salt/password.bin_* ./aml-key/usb.password.hash.bin

echo "
	Build Debug Efuse
				"

./stool/signing-tool-g12a-dev/efuse-gen.sh --generate-efuse-pattern \
					--soc g12a --soc-rev b \
					--key-hash-ver 2 \
					--root-hash aml-key/rootkeys-hash.bin  \
					--aes-key aml-key/bl2aeskey \
					--enable-sb true --enable-aes true \
					--enable-anti-rollback true \
					--m4-aes-key aml-key/m4aeskey.bin \
					--m4-root-hash aml-key/m4roothash.bin \
					--raw-otp-pattern true \
					--password-hash aml-key/usb.password.hash.bin \
					-o efuse/pattern.efuse_debug
	
echo "
	Build Burn Efuse	
				"					
					
./stool/signing-tool-g12a-dev/efuse-gen.sh --generate-efuse-pattern \
					--soc g12a --soc-rev b \
					--key-hash-ver 2 \
					--root-hash aml-key/rootkeys-hash.bin \
					--aes-key aml-key/bl2aeskey \
					--enable-sb true --enable-aes true \
					--enable-anti-rollback true \
					--m4-aes-key aml-key/m4aeskey.bin \
					--m4-root-hash aml-key/m4roothash.bin \
					--raw-otp-pattern false \
					--password-hash aml-key/usb.password.hash.bin \
					-o efuse/pattern.efuse
					
echo "
	Build Debug USB Efuse
				"				
					
./stool/signing-tool-g12a-dev/efuse-gen.sh --generate-efuse-pattern \
					--soc g12a --soc-rev b \
					--key-hash-ver 2 \
					--raw-otp-pattern true \
					--password-hash aml-key/usb.password.hash.bin \
					-o efuse/pattern.usb.efuse_debug
					
					
echo "
	Build Enable USB Efuse Debug
				"				
					
./stool/signing-tool-g12a-dev/efuse-gen.sh --generate-efuse-pattern \
					--soc g12a --soc-rev b \
					--key-hash-ver 2 \
					--raw-otp-pattern true \
					--password-hash aml-key/usb.password.hash.bin \
					--enable-usb-password true \
					-o efuse/pattern.usb.efuse_debug_EN
					
echo "
	Build USB Efuse
				"				
					
./stool/signing-tool-g12a-dev/efuse-gen.sh --generate-efuse-pattern \
					--soc g12a --soc-rev b \
					--key-hash-ver 2 \
					--raw-otp-pattern false \
					--password-hash aml-key/usb.password.hash.bin \
					--enable-usb-password true \
					-o efuse/pattern.usb.efuse
					



