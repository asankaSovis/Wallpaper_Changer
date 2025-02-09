#!/bin/bash

###############################################################################################################
####
####                                 Wallpaper Slideshow for Linux v1.0
####                                Copyright (c) 2025 Asanka Akash Sovis
####
#### This is a simple script for Gnome that changes the wallpaper every x time period.
####
#### This program is released under the MIT License <https://github.com/asankaSovis/Ghidra_Installer/blob/main/LICENSE>"
#### All other components are licensed under their own licenses.
####
#### Github Repository and further information <https://github.com/asankaSovis/Ghidra_Installer>
####
#### Created by Asanka Sovis on 07/02/2025
#### Last Edited by Asanka Sovis on 08/02/2025
####    - Initial release
####
###############################################################################################################

# Wallpaper path: The wallpapers must be in a dir. Enter the dir
# path here. Do not enter the path to a file. Make sure to provide
# an absolute path relative to the root.
wallpaper_path="/home/$USER/Pictures/Wallpapers"

# Time to update the wallpaper: This can be given as below:
#   s or (no suffix): seconds (default)
#   m: minutes
#   h: hours
#   d: days
# Decimals and combinations are also accepted.
# For example:
#   update_wallpaper_every=5 : 5 seconds
#   update_wallpaper_every=5s : 5 seconds
#   update_wallpaper_every=2m : 2 minutes
#   update_wallpaper_every=1.5h : 1.5 hours
#   update_wallpaper_every=7d : 7 days
#   update_wallpaper_every=1h30m : 1 hour and 30 minutes
# It is recommended to provide a time greater than 5 seconds.
# The script is also not set to persist time every reboot. Therefore
# might not change the wallpapers properly for higher timeframes.
update_wallpaper_every=10m

# Number of times to wait to update the list of images: This
# will wait until the given number of times of wallpaper updates
# to update the list of images in the wallpaper path. For example
# if update_wallpaper_every=1m and update_list_every=5, the list
# of wallpapers will be updated evey 5 minutes.
update_list_every=5

# End of user changing variables. Do not modify anything below this point
# unless you want to ------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------------------

# echo "Wallpaper Slideshow v1.0"
# echo "Copyright (c) 2025 Asanka Akash Sovis"
# echo ""
# echo "This is a simple script for Gnome that changes the wallpaper every x time period."
# echo "This third party script is released under the MIT License. By continuing with the install, you will be agreeing to this license and the respective licenses of the third party tools used and installed."
# echo ""
# echo "Initializing..."

# echo "Wallpaper path: $wallpaper_path"
# echo "Update wallpaper every: $update_wallpaper_every"
# echo ""

wallpaper_list=() # List of wallpapers
current_wallpaper_no=0 # Current wallpaper no
update_list=true # Update the list next
update_list_count=0 # Current sleep time multiplier
override_file=".override"

# Check if the wallpaper dir exist
if [ -d "$wallpaper_path" ]; then
  # echo "Directory '$wallpaper_path' exists."
  cd $wallpaper_path
else
  # echo "Directory '$wallpaper_path' does not exist or is not a directory."
  exit 1  # Failure
fi

# Master loop -----------------------------------------------------------------------------------------------

while [ true ]
do
    # echo ""

    # Check if set to override
    if [ -f "$override_file" ]; then
        # echo "$override_file file exist. Script will now exit. Please restart the script manually or restart the device to reload."
        exit 0
    fi

    if [[ "$update_list" == true ]]; then
        # echo "Updating wallpaper list..."
        # echo ""

        wallpaper_list=()

        for file in *; do
            # Get every file/dir in list
            if [ -f "$file" ]; then
                # Check if the path is a file
                file_output=$(file "$file")

                if [[ "$file_output" == *image* ]]; then
                    # Check if the file is an image
                    # echo "The file is an image: $file."

                    # Only adds the image to the list if it is an image
                    wallpaper_list+=("$file")
                # else
                    # echo "The file is not an image."
                fi
            fi
        done

        # Check if at least one image is present
        # if [[ ${#wallpaper_list[@]} -gt 0 ]]; then
            # echo "At least one image file was found."
        # else
            # echo "No image files were found."
            #exit 1
        # fi

        # echo ""

        update_list=false
    fi

    # Reset wallpaper pointer if all wallpapers are displayed
    if [[ ! ($current_wallpaper_no -lt ${#wallpaper_list[@]}) ]]; then
        current_wallpaper=""
        current_wallpaper_no=0
    fi

    # Set current wallpaper
    current_wallpaper="${wallpaper_list[current_wallpaper_no]}"

    # Check if wallpaper file exist
    if [ -f "$current_wallpaper" ]; then
        # Set wallpaper
        print_text="file://$PWD/$current_wallpaper"
        gsettings set org.gnome.desktop.background picture-uri-dark $print_text

        # echo "Wallpaper set to: [$current_wallpaper_no]$PWD/$current_wallpaper."
        current_wallpaper_no=$((current_wallpaper_no + 1)) # Inc wallpaper no
    # else
        # echo "File missing: $current_wallpaper."
    fi

    # Pause
    # echo "Sleep for $update_wallpaper_every..."
    sleep $update_wallpaper_every

    # Check when to update list
    if [[ "$update_list_every" -gt 0 ]]; then
        update_list_count=$((update_list_count + 1))

        if [[ "$update_list_count" -gt update_list_every ]]; then
            update_list_count=0
            update_list=true
        fi
    fi
done
