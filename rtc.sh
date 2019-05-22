#!/bin/bash
if [[ "$USER" != 'root' ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

install_i2c () {
    apt-get install -y python-smbus i2c-tools
    if grep -Fxq "dtparam=i2c_arm=on" /boot/config.txt
        then
	        echo \"dtparam=i2c_arm=on\" is present in config.txt
        else
	        echo "dtparam=i2c_arm=on" >> /boot/config.txt
	        echo \"dtparam=i2c_arm=on\" is added to config.txt
    fi
    if grep -Fxq "dtoverlay=rtc-i2c,ds3231" /boot/config.txt
        then
	        echo \"dtoverlay=rtc-i2c,ds3231\" is present in config.txt
        else
	        echo "dtoverlay=rtc-i2c,ds3231" >> /boot/config.txt
	        echo \"dtoverlay=rtc-i2c,ds3231\" is added to config.txt
    fi
    if grep -Fxq "#blacklist i2c-bcm2708" /etc/modprobe.d/raspi-blacklist.conf
        then
	        echo \"#blacklist i2c-bcm2708\" is present in raspi-blacklist.conf
        else
	        echo "#blacklist i2c-bcm2708" >>/etc/modprobe.d/raspi-blacklist.conf
	        echo \"#blacklist i2c-bcm2708\" is added to raspi-blacklist.conf
    fi
    if grep -Fxq "#blacklist i2c-dev" /etc/modprobe.d/raspi-blacklist.conf
        then
	        echo \"#blacklist i2c-dev\" is present in raspi-blacklist.conf
        else
	        echo "#blacklist i2c-dev" >>/etc/modprobe.d/raspi-blacklist.conf
	        echo \"#blacklist i2c-dev\" is added to raspi-blacklist.conf
    fi
    if grep -Fxq "i2c-bcm2835" /etc/modules
        then
	        printf "i2c-bcm2835\ni2c-dev\nrtc-ds1307\n" is present in modules
        else
	        printf "i2c-bcm2835\ni2c-dev\nrtc-ds1307\n" >>/etc/modules
	        printf "i2c-bcm2835\ni2c-dev\nrtc-ds1307\n added modules\n"
    fi
    reboot
}

install_i2c