echo "Make boot.img"
./mkbootfs ramdisk | gzip > ramdisk.gz
cmd_line="console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 ehci-hcd.park=3 androidboot.selinux=permissive"
./mkbootimg --cmdline "$cmd_line" --kernel zImage --ramdisk ramdisk.gz --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x02000000 --output boot.img
