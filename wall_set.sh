#created by Tedley Meralus 
# Twitter: @TechGameTeddy
#
#Developed for Ubuntu 14.04
#Make sure both .sh files land in the same directory
#Run wall_set.sh to set up chron jobs for the current user and configure wall.sh
#After wall_set.sh has been run, wall.sh will be run at the top of every hour.
#wall.sh can be run by itself once configured.
#
#
#!/bin/bash

#finds the first directory named wallpaper17
dir_loc=$(find / -name wallpaper17 2> >(grep -v 'Permission denied')|head -n 1)
echo $dir_loc

#assigns the photo directory to the wallpaper-changing script.
sed -i "2s|.*|dir_loc=$dir_loc|" wall.sh

#checks if the cron job exists already
cron_hour_exists=$(crontab -u $USER -l | grep wall.sh | grep -v "@reboot"| wc -l)
cron_boot_exists=$(crontab -u $USER -l | grep -E 'wall.sh.*@reboot' | wc -l)
echo "hourly: $cron_hour_exists"
echo "boot: $cron_boot_exists"

#find script's directory
script_dir="$( cd "$( dirname "$BASH_SOURCE[0]}" )" && pwd )"

#adds hourly cron job is one doesn't already exist
if [ "$cron_hour_exists" -eq 0 ]; then
	(crontab -u $USER -l ; echo "0 * * * * $script_dir/wall.sh") | crontab -u $USER -
fi

#adds boot cron job is one doesn't already exist
if [ "$cron_boot_exists" -eq 0 ]; then
	(crontab -u $USER -l ; echo "@reboot $script_dir/wall.sh") | crontab -u $USER -
fi


echo $script_dir

