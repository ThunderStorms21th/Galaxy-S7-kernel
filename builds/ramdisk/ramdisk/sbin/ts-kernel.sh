#!/system/bin/sh

# ThunderStorm bash script for kernel and policy features settings v1.1
# Thanks to MoRoGoKu and djb77

# Set Variables
RESETPROP="/sbin/magisk resetprop -v -n"

# Mount
mount -o remount,rw -t auto /
mount -t rootfs -o remount,rw rootfs
mount -o remount,rw -t auto /system
mount -o remount,rw /data
mount -o remount,rw /cache

# Set KNOX to 0x0 on running /system
$RESETPROP ro.boot.warranty_bit "0"
$RESETPROP ro.warranty_bit "0"

# Fix Samsung Related Flags
$RESETPROP ro.fmp_config "1"
$RESETPROP ro.boot.fmp_config "1"

# Fix safetynet flags
$RESETPROP ro.boot.veritymode "enforcing"
$RESETPROP ro.boot.verifiedbootstate "green"
$RESETPROP ro.boot.flash.locked "1"
$RESETPROP ro.boot.ddrinfo "00000001"

# Stop services
su -c "stop secure_storage"
su -c "stop irisd"

# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
echo "0" > /sys/fs/selinux/enforce
chmod 640 /sys/fs/selinux/enforce

# SafetyNet
chmod 440 /sys/fs/selinux/policy

##KILL MEDIA
if [ "`pgrep media`" ] && [ "`pgrep mediaserver`" ]; then
busybox killall -9 android.process.media
busybox killall -9 mediaserver
busybox killall -9 com.google.android.gms
busybox killall -9 com.google.android.gms.persistent
busybox killall -9 com.google.process.gapps
busybox killall -9 com.google.android.gsf
busybox killall -9 com.google.android.gsf.persistent
fi;

# Google play services wakelock fix
sleep 1
su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver"

# init.d
if [ ! -d /system/etc/init.d ]; then
	mkdir -p /system/etc/init.d
fi
chown -R root.root /system/etc/init.d
chmod -R 755 /system/etc/init.d
for FILE in /system/etc/init.d/*; do
	sh $FILE >/dev/null
done;
for FILE2 in /system/etc/init.d/*.sh; do
	sh $FILE2 >/dev/null
done;

# Deepsleep fix (@Chainfire)
if [ -f /data/adb/su/su.d/000000deepsleep ]; then
	rm -f /data/adb/su/su.d/000000deepsleep
fi

for i in `ls /sys/class/scsi_disk/`; do
	cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	if [ $? -eq 0 ]; then
		echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	fi
done;

# Fix personalist.xml
if [ ! -f /data/system/users/0/personalist.xml ]; then
	touch /data/system/users/0/personalist.xml
	chmod 600 /data/system/users/0/personalist.xml
	chown system:system /data/system/users/0/personalist.xml
fi

# PWMFix (0 = Disabled, 1 = Enabled)
echo "0" > /sys/class/lcd/panel/smart_on

# Kernel Panic off
echo "0" > /proc/sys/kernel/panic

# Stock CPU Settings
echo "2288000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "312000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "1586000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "234000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "546000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo "624000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo "50000 754000:30000 754000:30000 962000:30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo "60000 728000:30000 1040000:25000 1248000:20000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo "80 858000:85 1066000:90" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo "80 832000:85 1040000:88 1352000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo "93" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo "95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo "40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo "40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo "40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo "30000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack

# HMP settings
echo "740" > /sys/kernel/hmp/up_threshold
echo "270" > /sys/kernel/hmp/down_threshold
echo "962000" > /sys/kernel/hmp/down_compensation_high_freq
echo "858000" > /sys/kernel/hmp/down_compensation_mid_freq
echo "754000" > /sys/kernel/hmp/down_compensation_low_freq

# Stock GPU Settings
echo "650" > /sys/devices/14ac0000.mali/max_clock
echo "112" > /sys/devices/14ac0000.mali/min_clock
echo "419" /sys/devices/14ac0000.mali/highspeed_clock
echo "1" /sys/devices/14ac0000.mali/highspeed_delay
echo "95" /sys/devices/14ac0000.mali/highspeed_load

# I/O sched settings
echo 'cfq' > /sys/block/sda/queue/scheduler
echo "512" > /sys/block/sda/queue/read_ahead_kb
echo 'bfq' > /sys/block/mmcblk0/queue/scheduler
echo "512" > /sys/block/mmcblk0/queue/read_ahead_kb
echo "0" > /sys/block/sda/queue/iostats
echo "0" > /sys/block/mmcblk0/queue/iostats
echo "1" > /sys/block/sda/queue/rq_affinity
echo "1" > /sys/block/mmcblk0/queue/rq_affinity
echo "368" > /sys/block/sda/queue/nr_requests
echo "368" > /sys/block/mmcblk0/queue/nr_requests

# LMK
echo "18920,23552,32256,42472,65536,102400" > /sys/module/lowmemorykiller/parameters/minfree

# SSWAP and Entropy
echo "130" > /proc/sys/vm/swappiness
echo "128" > /proc/sys/kernel/random/write_wakeup_threshold
echo "64" > /proc/sys/kernel/random/read_wakeup_threshold
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1000" > /proc/sys/vm/dirty_writeback_centisecs

# ZRAM assigns size limit to virtual ram disk
echo 3072M > /sys/block/zram0/disksize
echo "1" > /sys/block/zram0/reset
swapoff /dev/block/zram0 >/dev/null 2>&1
for ZRAM in /dev/block/zram*; do
    swapoff $ZRAM
done;

# CPU BOOST OFF
echo "0" > /sys/module/cpu_boost/parameters/input_boost_enabled

# FINGERPRINT BOOST - ON
echo 1 > /sys/kernel/fp_boost/enabled

# Tweaks: Internet Speed
echo 'westwood' > /proc/sys/net/ipv4/tcp_congestion_control
echo "0" > /proc/sys/net/ipv4/tcp_timestamps
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes
echo "20" > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo "20" > /proc/sys/net/ipv4/tcp_fin_timeout
echo "404480" > /proc/sys/net/core/wmem_max
echo "404480" > /proc/sys/net/core/rmem_max
echo "256960" > /proc/sys/net/core/rmem_default
echo "256960" > /proc/sys/net/core/wmem_default
echo "4096,16384,404480" > /proc/sys/net/ipv4/tcp_wmem
echo "4096,87380,404480" > /proc/sys/net/ipv4/tcp_rmem

# Unmount
mount -o remount,ro -t auto /
mount -t rootfs -o remount,ro rootfs
mount -o remount,ro -t auto /system
mount -o remount,rw /data
mount -o remount,rw /cache

