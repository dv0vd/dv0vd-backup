fail2ban-status:
	fail2ban-client status
	fail2ban-client status sshd

fail2ban-unban-all:
	fail2ban-client unban --all

fail2ban-start:
	systemctl start fail2ban