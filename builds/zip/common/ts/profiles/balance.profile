# Balance (default profile, ThunderStormS)
   
   # Little CPU
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
   write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
   write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 234000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
   write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1586000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 93
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay "50000 754000:30000 754000:30000 962000:20000"
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 40000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 754000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack 30000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "80 858000:85 1066000:90"
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 40000
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/mode 0
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy 1
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/param_index 0
   chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration
   write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration 20000

   # Big CPU
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
   write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor interactive
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
   write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 312000
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 2288000
   chmod 0444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 95
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "60000 728000:30000 1040000:25000 1248000:20000"
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 40000
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 728000
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack 30000
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "80 832000:85 1040000:88 1352000:90"
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/mode 0
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy 1
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/param_index 0
   chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration
   write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration 20000

   # CPU HOTPLUG
   write /sys/power/cpuhotplug/enabled 1
   write /sys/devices/system/cpu/cpufreq/mp-cpufreq/cluster1_all_cores_max_freq 0

   # HMP
   chmod 0664 /sys/kernel/hmp/up_threshold
   write /sys/kernel/hmp/up_threshold 740
   chmod 0664 /sys/kernel/hmp/down_threshold
   write /sys/kernel/hmp/down_threshold 270
   chmod 0664 /sys/kernel/hmp/down_compensation_high_freq
   write /sys/kernel/hmp/down_compensation_high_freq 962000
   chmod 0664 /sys/kernel/hmp/down_compensation_mid_freq
   write /sys/kernel/hmp/down_compensation_mid_freq 858000
   chmod 0664 /sys/kernel/hmp/down_compensation_low_freq
   write /sys/kernel/hmp/down_compensation_low_freq 754000
   write /proc/sys/kernel/random/write_wakeup_threshold 128
   write /proc/sys/kernel/random/read_wakeup_threshold 64
   write /proc/sys/vm/dirty_expire_centisecs 500
   write /proc/sys/vm/dirty_writeback_centisecs 1000

   # GPU
   chmod 0664 /sys/devices/14ac0000.mali/max_clock
   write /sys/devices/14ac0000.mali/max_clock 650
   chmod 0664 /sys/devices/14ac0000.mali/min_clock
   write /sys/devices/14ac0000.mali/min_clock 112
   chmod 0664 /sys/devices/14ac0000.mali/power_policy
   write /sys/devices/14ac0000.mali/power_policy coarse_demand
   chmod 0664 /sys/devices/14ac0000.mali/dvfs_governor
   write /sys/devices/14ac0000.mali/dvfs_governor 1
   chmod 0664 /sys/devices/14ac0000.mali/highspeed_clock
   write /sys/devices/14ac0000.mali/highspeed_clock 419
   chmod 0664 /sys/devices/14ac0000.mali/highspeed_load
   write /sys/devices/14ac0000.mali/highspeed_load 95
   chmod 0664 /sys/devices/14ac0000.mali/highspeed_delay
   write /sys/devices/14ac0000.mali/highspeed_delay 1

   # IO Scheduler
   write /sys/block/sda/queue/scheduler cfg
   write /sys/block/sda/queue/read_ahead_kb 512
   write /sys/block/mmcblk0/queue/scheduler cfq
   write /sys/block/mmcblk0/queue/read_ahead_kb 512
   write /sys/block/sda/queue/iostats 0
   write /sys/block/mmcblk0/queue/iostats 0
   write /sys/block/sda/queue/rq_affinity 1
   write /sys/block/mmcblk0/queue/rq_affinity 1
   write /sys/block/sda/queue/nr_requests 368
   write /sys/block/mmcblk0/queue/nr_requests 368


   # Wakelocks
   write /sys/module/wakeup/parameters/enable_sensorhub_wl 0
   write /sys/module/wakeup/parameters/enable_ssp_wl 0
   write /sys/module/wakeup/parameters/enable_bcmdhd4359_wl 0
   write /sys/module/wakeup/parameters/enable_bluedroid_timer_wl 0
   write /sys/module/wakeup/parameters/enable_wlan_wake_wl 0
   write /sys/module/sec_battery/parameters/wl_polling 3
   write /sys/module/sec_nfc/parameters/wl_nfc 1

   # Misc
   write /sys/module/sync/parameters/fsync_enabled 1
   write /sys/kernel/dyn_fsync/Dyn_fsync_active 1
   write /sys/kernel/sched/gentle_fair_sleepers 0
   write /sys/kernel/sched/arch_power 0
   write /sys/kernel/power_suspend/power_suspend_mode 3
   write /proc/sys/net/ipv4/tcp_congestion_control westwood

   # SSWAP
   write /proc/sys/vm/swappiness 130

   # LMK
   write /sys/module/lowmemorykiller/parameters/minfree "18920,23552,32256,42472,65536,102400"

