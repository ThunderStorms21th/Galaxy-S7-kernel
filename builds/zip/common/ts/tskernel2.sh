#!/sbin/sh
# ------------------------------
# ThundeRStormS KERNEL INSTALLER
# Created by @djb77
#
# Credit also goes to @Tkkg1994,
# @lyapota, @Morogoku and 
# @dwander for bits of code
# ------------------------------

# Block location
BLOCK=/dev/block/platform/155a0000.ufs/by-name

# Variables
TSTEMP=/tmp/tstemp
AROMA=/tmp/aroma
TS=/data/media/0/Spectrum/profiles
KERNELPATH=$TSTEMP/kernels
BUILDPROP=/system/build.prop

	## System Patches

	# mkdir $TS
        # cp -rLf profiles/. /data/media/0/Spectrum/profiles/
	# chmod 777 $TS

	## SPECTRUM PROFILES
	ui_print " "
	ui_print "@Install Spectrum (TS) Profiles"
	mkdir -p /data/media/0/Spectrum/profiles 2>/dev/null;
	cp -rf /tmp/ts/profiles/. /data/media/0/Spectrum/profiles/

