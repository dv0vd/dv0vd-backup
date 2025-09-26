logs-clear:
	journalctl --vacuum-time=1d

logs-auth:
	journalctl -u ssh -n 10000 -f

logs-init:
	cat /var/log/init.log

logs-startup:
	cat /var/log/on-startup.log