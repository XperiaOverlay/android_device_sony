#!/sbin/busybox sh
# Copyright (C) 2011-2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set +x
_PATH="$PATH"
export PATH=/sbin

busybox cd /
busybox date >>boot.txt
exec >>boot.txt 2>&1
busybox rm /init

# include device specific vars
source /sbin/bootrec-device

# create directories
busybox mkdir -m 755 -p /cache
busybox mkdir -m 755 -p /dev/block
busybox mkdir -m 755 -p /dev/input
busybox mkdir -m 555 -p /proc
busybox mkdir -m 755 -p /sys

# create device nodes
busybox mknod -m 600 /dev/block/mmcblk0 b 179 0
busybox mknod -m 600 ${BOOTREC_CACHE_NODE}
busybox mknod -m 600 ${BOOTREC_EVENT_NODE}
busybox mknod -m 666 /dev/null c 1 3

# mount filesystems
busybox mount -t proc proc /proc
busybox mount -t sysfs sysfs /sys
busybox mount -t ext4 ${BOOTREC_CACHE} /cache

if [ ! -f /cache/recovery/boot ]; then
	# trigger amber LED
	busybox echo 0 > ${BOOTREC_LED_RED}
	busybox echo 0 > ${BOOTREC_LED_GREEN}
	busybox echo 255 > ${BOOTREC_LED_BLUE}

	# keycheck
	busybox cat ${BOOTREC_EVENT} > /dev/keycheck&
	busybox sleep 3
fi

# android ramdisk
load_image=/sbin/ramdisk.cpio

# boot decision
if [ -s /dev/keycheck -o -e /cache/recovery/boot ]
then
	busybox echo 'RECOVERY BOOT' >>boot.txt
	busybox rm -fr /cache/recovery/boot
	# trigger blue led
	busybox echo 0 > ${BOOTREC_LED_RED}
	busybox echo 0 > ${BOOTREC_LED_GREEN}
	busybox echo 255 > ${BOOTREC_LED_BLUE}
	# recovery ramdisk
	busybox mknod -m 600 ${BOOTREC_FOTA_NODE}
	busybox mount -o remount,rw /
	busybox ln -sf /sbin/busybox /sbin/sh
	extract_elf_ramdisk -i ${BOOTREC_FOTA} -o /sbin/ramdisk-recovery.cpio -t / -c
	busybox rm /sbin/sh
	load_image=/sbin/ramdisk-recovery.cpio
else
	busybox echo 'ANDROID BOOT' >>boot.txt
	# poweroff LED
	busybox echo 0 > ${BOOTREC_LED_RED}
	busybox echo 0 > ${BOOTREC_LED_GREEN}
	busybox echo 0 > ${BOOTREC_LED_BLUE}
fi

# kill the keycheck process
busybox pkill -f "busybox cat ${BOOTREC_EVENT}"

# unpack the ramdisk image
busybox cpio -i < ${load_image}

busybox umount /cache
busybox umount /proc
busybox umount /sys

busybox rm -fr /dev/*
busybox date >>boot.txt
export PATH="${_PATH}"
exec /init
