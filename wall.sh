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
dir_loc=/home/a/Downloads/wallpaper17

#Finds all the image files within the selected directory and randomly selects one.
pic=$(find $dir_loc -name '*' -exec file {} \; | grep -o -P '^.+: \w+ image'| sort -R | head -n 1| cut -f1 -d":")

#finds the pid to export the DBUS SESSION ADDRESS to the shell executing the script
#cron jobs weren't working w/o this
PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

echo $DBUS_SESSION_BUS_ADDRESS
echo $pic

#Sets the background to to the random picture.
gsettings set org.gnome.desktop.background picture-uri "file://$pic"

echo "$pic, $(date)" >> /home/a/Documents/wall.log