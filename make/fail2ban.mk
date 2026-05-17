fail2ban-configure:
	bash -c "set -a; . .env; set +a; envsubst < ./deployment/configs/fail2ban/jail_env.local > ./deployment/configs/fail2ban/jail.local"
	cp /root/dv0vd-backup/deployment/configs/fail2ban/jail.local /etc/fail2ban/jail.local
	cp /root/dv0vd-backup/deployment/configs/fail2ban/fail2ban.local /etc/fail2ban/fail2ban.local

fail2ban-status:
	fail2ban-client status
	fail2ban-client status sshd

fail2ban-unban-all:
	fail2ban-client unban --all

fail2ban-start:
	systemctl start fail2ban

fail2ban-stop:
	systemctl stop fail2ban