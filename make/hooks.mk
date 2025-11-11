on-startup:
	- shutdown -r 23:00
	- echo "nameserver ${DNS1}" > /etc/resolv.conf
	- echo "nameserver ${DNS2}" >> /etc/resolv.conf
	- $(MAKE) logs-clear

