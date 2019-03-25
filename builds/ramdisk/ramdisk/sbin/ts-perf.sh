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

# Deepsleep fix (@Chainfire)
for i in `ls /sys/class/scsi_disk/`; do
	cat /sys/class/scsi_disk/$i/write_protect 2>/dev/null | grep 1 >/dev/null
	if [ $? -eq 0 ]; then
		echo 'temporary none' > /sys/class/scsi_disk/$i/cache_type
	fi
done;

# PWMFix (0 = Disabled, 1 = Enabled)
echo "0" > /sys/class/lcd/panel/smart_on

# Kernel Panic off
echo "0" > /proc/sys/kernel/panic

# Stock CPU Settings
echo "2600000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "416000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "1586000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "338000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "754000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo "1040000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo "30000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo "30000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo "75" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo "75" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo "85" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo "105000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo "90000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo "10000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo "10000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack

# HMP settings
echo "524" > /sys/kernel/hmp/up_threshold
echo "214" > /sys/kernel/hmp/down_threshold
echo "1170000" > /sys/kernel/hmp/down_compensation_high_freq
echo "962000" > /sys/kernel/hmp/down_compensation_mid_freq
echo "858000" > /sys/kernel/hmp/down_compensation_low_freq

# Stock GPU Settings
echo "650" > /sys/devices/14ac0000.mali/max_clock
echo "260" > /sys/devices/14ac0000.mali/min_clock
echo "419" /sys/devices/14ac0000.mali/highspeed_clock
echo "1" /sys/devices/14ac0000.mali/highspeed_delay
echo "92" /sys/devices/14ac0000.mali/highspeed_load

# I/O sched settings
echo 'zen' > /sys/block/sda/queue/scheduler
echo "1024" > /sys/block/sda/queue/read_ahead_kb
echo 'zen' > /sys/block/mmcblk0/queue/scheduler
echo "2048" > /sys/block/mmcblk0/queue/read_ahead_kb
echo "0" > /sys/block/sda/queue/iostats
echo "0" > /sys/block/mmcblk0/queue/iostats
echo "2" > /sys/block/sda/queue/rq_affinity
echo "2" > /sys/block/mmcblk0/queue/rq_affinity
echo "512" > /sys/block/sda/queue/nr_requests
echo "512" > /sys/block/mmcblk0/queue/nr_requests

# LMK
echo "20432,26040,32648,42256,59064,101152" > /sys/module/lowmemorykiller/parameters/minfree

# SSWAP and Entropy
echo "120" > /proc/sys/vm/swappiness
echo "1024" > /proc/sys/kernel/random/write_wakeup_threshold
echo "192" > /proc/sys/kernel/random/read_wakeup_threshold
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1000" > /proc/sys/vm/dirty_writeback_centisecs

# CPU BOOST OFF
echo "0" > /sys/module/cpu_boost/parameters/input_boost_enabled

# Unmount
mount -o remount,ro -t auto /
mount -t rootfs -o remount,ro rootfs
mount -o remount,ro -t auto /system
mount -o remount,rw /data
mount -o remount,rw /cache

