VERSION_NUMBER=2.0
build()
{
	
	#Build pure zImage
	export CROSS_COMPILE=android-toolchain/bin/arm-eabi-
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
	make ARCH=arm mrproper;
	make clean;
	ccache -c 
	ccache -C
	
	rm -rf android-toolchain/*
	echo "Copying toolchain..."
	cp -r ../tc/* android-toolchain
	
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


