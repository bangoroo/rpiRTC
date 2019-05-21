#!/bin/bash
if [[ "$USER" != 'root' ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

install_i2c() {
                if [ $(sudo i2cdetect -y 1 | wc -l) -ge 1 ] ; then
                echo "i2c found on on pin 1"
                i2cdetect -y 1
                echo "Add the number in the from the test:"
                read number
                echo "ds3231 0x$number" | sudo tee /sys/class/i2c-adapter/i2c-1/new_device
                hwclock -r
                sed -i -e '13imodprobe i2c-bcm2708\' /etc/rc.local
                sed -i -e '14echo ds3231 0x$number > /sys/class/i2c-adapter/i2c-1/new_device\' /etc/rc.local
                sed -i -e '15ihwclock -s\' /etc/rc.local
            else
                if [ $(sudo i2cdetect -y 0 | wc -l) -ge 1 ] ; then
                    echo "i2c found on on pin 0"
                    i2cdetect -y 0
                    echo "Add the number in the from the test:"
                    read number
                    echo "ds3231 0x$number" | sudo tee /sys/class/i2c-adapter/i2c-0/new_device
                    hwclock -r
                    sed -i -e '13imodprobe i2c-bcm2708\' /etc/rc.local
                    sed -i -e '14echo ds3231 0x$number > /sys/class/i2c-adapter/i2c-0/new_device\' /etc/rc.local
                    sed -i -e '15ihwclock -s\' /etc/rc.local
                fi
                echo "cant find i2c module"
            fi
            reboot
}

install_i2c