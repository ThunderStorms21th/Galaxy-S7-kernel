#!/system/bin/sh

# ThunderStormS kill Google and Media servers script
busybox=/sbin/busybox;


sleep 5

##Disable logs
setprop profiler.debugmonitor 0
setprop profiler.launch 0
setprop profiler.hung.dumpdobugreport 0
setprop logcat.live 0


# START LOOP 3600sec = 1h
RUN_EVERY=3600

(
while : ; do

busybox touch /sdcard/TS

# su -c 'stop proca'

##KILL MEDIA
if [ "`pgrep media`" ] && [ "`pgrep mediaserver`" ]; then
# busybox killall -9 android.process.media
# busybox killall -9 mediaserver
busybox killall -9 com.google.android.gms
busybox killall -9 com.google.android.gms.persistent
busybox killall -9 com.google.process.gapps
busybox killall -9 com.google.android.gsf
busybox killall -9 com.google.android.gsf.persistent
fi;

sleep 5

# FIX GOOGLE PLAY SERVICE
pm enable com.google.android.gms/.update.SystemUpdateActivity
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver

sleep 3600

done;
)&

# END OF LOOP


