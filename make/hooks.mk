on-startup:
	- systemctl disable fail2ban
	- $(MAKE) fail2ban-stop
	- ip addr add 9.9.9.9/32 dev lo || true
	- bash -c 'set -a; . .env; set +a; envsubst "\$$SSH_PORT" < ./deployment/configs/iptables/iptables_env.sh > ./deployment/configs/iptables/iptables.sh'
# - chmod +x ./deployment/configs/iptables/iptables.sh && ./deployment/configs/iptables/iptables.sh
	- shutdown -r 23:00
	- $(MAKE) fail2ban-start
	- echo "nameserver ${DNS1}" > /etc/resolv.conf
	- echo "nameserver ${DNS2}" >> /etc/resolv.conf
	- echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	- echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	- $(MAKE) logs-clear
