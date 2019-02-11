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

# SELinux (0 / 640 = Permissive, 1 / 644 = Enforcing)
echo "0" > /sys/fs/selinux/enforce
chmod 640 /sys/fs/selinux/enforce

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
fi;
chown -R root.root /system/etc/init.d
chmod -R 755 /system/etc/init.d
for FILE in /system/etc/init.d/*; do
	sh $FILE >/dev/null
done;
for FILE2 in /system/etc/init.d/*.sh; do
	sh $FILE2 >/dev/null
done;

# Deepsleep fix (@Chainfire)
for i in `ls /sys/class/scsi_disk/`; do
	cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	if [ $? -eq 0 ]; then
		su -c 'echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type'
	fi;
done;

# Fix personalist.xml
if [ ! -f /data/system/users/0/personalist.xml ]; then
	touch /data/system/users/0/personalist.xml
	chmod 600 /data/system/users/0/personalist.xml
	chown system:system /data/system/users/0/personalist.xml
fi;

# PWMFix (0 = Disabled, 1 = Enabled)
echo "0" > /sys/class/lcd/panel/smart_on

# Stock CPU Settings
echo "2080000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "416000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "1586000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "338000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "25000 650000:30000 1066000:45000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo "65000 728000:30000 1248000:40000 1560000:45000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo "98" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo "98" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo "60000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo "60000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo "30000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo "40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo "40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
echo "700" > /sys/kernel/hmp/up_threshold
echo "256" > /sys/kernel/hmp/down_threshold

# Stock GPU Settings
echo "650" > /sys/devices/14ac0000.mali/max_clock
echo "112" > /sys/devices/14ac0000.mali/min_clock
echo "338" /sys/devices/14ac0000.mali/highspeed_clock
echo "2" /sys/devices/14ac0000.mali/highspeed_delay
echo "98" /sys/devices/14ac0000.mali/highspeed_load

# I/O sched settings
echo 'cfq' > /sys/block/sda/queue/scheduler
echo "512" > /sys/block/sda/queue/read_ahead_kb
echo 'cfq' > /sys/block/mmcblk0/queue/scheduler
echo "1024" > /sys/block/mmcblk0/queue/read_ahead_kb
echo "0" > /sys/block/sda/queue/iostats
echo "0" > /sys/block/mmcblk0/queue/iostats

# LMK
echo "17920,23552,32256,42472,65536,102400" > /sys/module/lowmemorykiller/parameters/minfree

# Tweaks: Internet Speed
echo 'cubic' > /proc/sys/net/ipv4/tcp_congestion_control
echo "0" > /proc/sys/net/ipv4/tcp_timestamps
echo "1" > /proc/sys/net/ipv4/tcp_tw_reuse
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_tw_recycle
echo "1" > /proc/sys/net/ipv4/tcp_window_scaling
echo "5" > /proc/sys/net/ipv4/tcp_keepalive_probes
echo "30" > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo "30" > /proc/sys/net/ipv4/tcp_fin_timeout
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

