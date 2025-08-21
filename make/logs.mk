logs-clear:
	journalctl --vacuum-time=1d

logs-auth:
	journalctl -u ssh -n 10000 -
