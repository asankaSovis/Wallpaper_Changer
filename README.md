# 

# 🖼️ Wallpaper Changer

![Poster](./.assets/poster.png)

---

**Wallpaper Changer** is a simple script for Gnome that changes the wallpaper every x time period.

This program is licensed under the **[MIT License](https://github.com/asankaSovis/Wallpaper_Changer/blob/main/LICENSE)**.

![Technologies](https://skillicons.dev/icons?i=bash,linux)

## 🖼️ Prerequisites

The installer will run on almost any x64-based hardware system with any Linux distribution supporting **Bash**. An active internet connection is required to download the required components. Make sure **not** to run the script with `sudo` access as this might be too risky.

## 🖼️ How to Setup

Clone the components from this repo. If you do not know how to clone the repo, you can also download a release from [Releases](https://github.com/asankaSovis/Wallpaper_Changer/releases). It is recommended to download the latest version.

Create a directory in `~/Pictures/` called `Wallpapers`. Copy the required wallpapers to this directory.

Copy the `change_wallpaper.sh` to a convenient location, possibly to your *home (`~`)* directory. Open a terminal from the copied location. Enter the following command to make the script run automatically on startup.

```bash
SCRIPT_PATH="$PWD/change_wallpaper.sh"; SERVICE_NAME="change_wallpaper.service"; chmod +x $SCRIPT_PATH; echo "[Unit]
Description=My Script
After=network.target

[Service]
ExecStart=$SCRIPT_PATH

[Install]
WantedBy=default.target
" | tee ~/.config/systemd/user/"$SERVICE_NAME"; systemctl --user daemon-reload; systemctl --user enable "$SERVICE_NAME"; systemctl --user start "$SERVICE_NAME"
```

Voila! Enjoy your wallpaper slideshow.

> NOTE: **Do not** run this command with `sudo`.

## 🖼️ Additional Options

Adding additional wallpapers is as simple as copying them to the `Wallpapers` directory. Both JPEG and PNG wallpapers are supported.

You can also customize the script to your liking. Simply open the script in a text editor and change the following variables:

1. `wallpaper_path="/home/$USER/Pictures/Wallpapers"` - Wallpaper path: The wallpapers must be in a directory. Enter the directory path here between double quotes. Do **not** enter the path to a file. Make sure to provide an absolute path relative to the root.

2. `update_wallpaper_every=10m` - Time to update the wallpaper: Replace `10m` with your own value. This can be given as: s or (no suffix): seconds (default), m: minutes, h: hours, d: days. Decimals and combinations are also accepted. For example: `update_wallpaper_every=5` : 5 seconds, `update_wallpaper_every=5s` : 5 seconds, `update_wallpaper_every=2m` : 2 minutes, `update_wallpaper_every=1.5h` : 1.5 hours, `update_wallpaper_every=7d` : 7 days, `update_wallpaper_every=1h30m` : 1 hour and 30 minutes. It is recommended to provide a time greater than 5 seconds. The script is also not set to persist time every reboot. Therefore might not change the wallpapers properly for higher timeframes.

3. `update_list_every=5` - Number of times to wait to update the list of images: This will wait until the given number of times of wallpaper updates to update the list of images in the wallpaper path. For example if `update_wallpaper_every=10m` and `update_list_every=5`, the list of wallpapers will be updated evey 50 minutes.

Further modifications can be done to the script itself if needed.

## 🖼️ Further Control

1. The script can be temporarily stopped by killing the script.

```bash
sudo kill -9 $(ps -eo pid,command | grep /bin/bash | grep live_wallpaper_script.sh | tr -d " " | tr "/" "\n" | head -n 1)
```

> NOTE: **Have to** run this command with `sudo`.

2. The script can be permanently stopped and removed by deleting the service file.

```bash
SERVICE_NAME="change_wallpaper.service"; systemctl --user disable $SERVICE_NAME; rm ~/.config/systemd/user/"$SERVICE_NAME"
```

> NOTE: **Do not** run this command with `sudo`.

3. In case the script is modified, the service can be restarted to pull updates to the script.

```bash
systemctl --user restart "change_wallpaper.service"
```

> NOTE: **Do not** run this command with `sudo`.

## 🖼️ Changelog

### 1. [Wallpaper Changer v1.0](https://github.com/asankaSovis/Wallpaper_Changer/releases/tag/v1.0)

- Initial release

## 🖼️ Reporting Bugs and Requesting Features

To report bugs and request features, go to [issues](https://github.com/asankaSovis/Wallpaper_Changer/issues) and create a new Issue. Make sure to include the terminal output and a clear explanation of what you were trying to do and what happened. Also, include device information such as the distro and install path. It will take some time to provide support.

## 🖼️ Contributing

Anyone can contribute to this project. If you're a bash programmer, any new features or bug fixes are greatly appreciated. Any suggestions are also appreciated along with documentation improvements. The same goes for any bug reporting and feature suggestions. Also, if you're willing to, consider trying all features of this script in your distro and providing any feedback; especially if you're on a different distro.

---

> Tested on Ubuntu 24.10
> 
> ![Tested list](https://skillicons.dev/icons?i=ubuntu)

`© 2025 Asanka Sovis`