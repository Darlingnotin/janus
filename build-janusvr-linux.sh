#!/bin/bash -E
pkglist=(
	cmake
	qtcreator
	qt5-default
	build-essential
	mesa-common-dev
	git
	git-lfs
	build-essential
	libqt5websockets5-dev
	qtscript-tools
	libbullet-dev
	libopenal-dev
	libopus-dev
	libvorbis-dev
	libudev-dev
	libvlc-dev
	libopenexr-dev
	libudev-dev
	vlc
	zlib1g-dev
	qt5-default
	qtscript5-dev
	mesa-common-dev
	libilmbase-dev
	libassimp-dev
	qtbase5-private-dev
	libqt5webengine5
	libqt5webenginecore5
	libqt5webenginewidgets5
	qtwebengine5-dev
	)

# TODO: Enable automatic package installation via CLI flag
#echo -e "\n[*] Installing prerequisite OS packages for Ubuntu 18.04"
#sudo apt install ${pkglist[@]}

echo "########################################################"
echo " Welcome to the magical Linux Auto Compiler for JanusVR "
echo "########################################################"

BUILD_DIR="dist/linux/"

NPROC=$(nproc)

echo -e "\n[*] Building JanusVR Native binary distribution with $NPROC processors. Please wait..."
qmake FireBox.pro -spec linux-g++ CONFIG+=release CONFIG+=force_debug_info
time { make -j$NPROC; }

# remove previous build attempts in case of failed compilations
echo -e "\n[*] Deleting build dir $BUILD_DIR"
rm -rf $BUILD_DIR

echo -e "\n[*] Creating directory for build distribution in $BUILD_DIR..."
mkdir -p $BUILD_DIR
cp -v janusvr $BUILD_DIR
ln -v -s $(pwd)/assets $BUILD_DIR/assets
cp -v -r dependencies/linux/* $BUILD_DIR

echo -e "\n[#] PATCH 1: Adding depedencies from OS to distribution directory"
cp -v /usr/lib/x86_64-linux-gnu/libBulletDynamics.so.2.87	$BUILD_DIR
cp -v /usr/lib/x86_64-linux-gnu/libBulletCollision.so.2.87	$BUILD_DIR
cp -v /usr/lib/x86_64-linux-gnu/libLinearMath.so.2.87		$BUILD_DIR

echo -e "\n[*] Done! Please run 'janusvr' from $BUILD_DIR"
