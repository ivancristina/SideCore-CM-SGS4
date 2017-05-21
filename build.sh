VERSION_NUMBER=$(<build/version)
TOOLCHAIN_DIR=android_toolchain/bin/arm-eabi-

build()
{
	
	#Build pure zImage
	export CROSS_COMPILE=$TOOLCHAIN_DIR
	export ARCH=arm
	make side_jf_defconfig
	make -j4
	
	PRODUCTIMAGE="arch/arm/boot/Image"
	if [ ! -f "$PRODUCTIMAGE" ]; then
		echo "build failed" 
		exit 0;
	fi
	
}

deep_clean()
{
	echo "Distro cleaning"
	make clean
	make clobber
	make ARCH=arm distclean
	ccache -c 
	ccache -C
	
}

rerun()
{
	bash build.sh;
}
echo ""
echo ""
echo "SideCore kernel for jflte LineageOS ROMs"
echo "1) Clean Workspace"
echo "2) Build kernel"
echo "3) Exit"
echo ""
read -p "Please select an option " prompt
echo ""
if [ $prompt == "1" ]; then
	deep_clean; 
	rerun;
elif [ $prompt == "2" ]; then
	build;
	rerun;
elif [ $prompt == "3" ]; then
	exit;
fi


