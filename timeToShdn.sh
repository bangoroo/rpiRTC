#!/bin/bash
if [[ "$USER" != 'root' ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi

shdn() {
		echo "Setze Zeit zum Herunterfahren (Minute | Stunde | Tag des Monats | Monat | Tag der Woche)"
		echo "Bsp.: 0 20 * * *"
		read time
		echo "shutdown -h now" >>  /usr/sbin/shdn.sh
		echo "$time /usr/sbin/shdn.sh" >> /etc/crontab
}

shdn