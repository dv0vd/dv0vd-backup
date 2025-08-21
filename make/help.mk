GREEN='\033[1;32m'
WHITE='\033[1;37m'
RESET='\033[0m'
help:
	@echo ${GREEN}logs-clear'                   '${WHITE}— clear journalctl logs olden then 1 day${RESET}
	@echo ${GREEN}logs-auth'                    '${WHITE}— get SSH connection attemps logs${RESET}
	@echo ${GREEN}fail2ban-status'              '${WHITE}— get fail2ban jails status${RESET}
	@echo ${GREEN}fail2ban-unban-all'           '${WHITE}— unban all IPs in fail2ban${RESET}
	@echo ${GREEN}schedule-midnight-reboot'     '${WHITE}— reboot server at midnight${RESET}