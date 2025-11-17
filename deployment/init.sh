#!/bin/bash
set -e # stop script on any error



configure_fail2ban() {
  log "Configuring fail2ban..."
  cp /root/dv0vd/deployment/configs/fail2ban/jail.local /etc/fail2ban/jail.local
  cp /root/dv0vd/deployment/configs/fail2ban/fail2ban.local /etc/fail2ban/fail2ban.local
  systemctl disable fail2ban
  systemctl start fail2ban
  log "Fail2ban successfully configured"
}

configure_ssh() {
  log "Configuring SSH..."
  cat /root/dv0vd/deployment/configs/ssh/ssh.pub >> /root/.ssh/authorized_keys
  touch /etc/ssh/sshd_config.d/00-dv0vd.conf
  echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf
  echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf
  log "SSH successfully generated"
}

finish() {
  log "Configuring rc.local autostart..."
  rm /etc/rc.local -f
  cp /root/dv0vd/deployment/configs/linux/rc.local /etc/rc.local
  chmod a+x /etc/rc.local
  log "rc.local autostart successfully configured"
  log "Initialization finished. Rebooting now..."
  reboot
}

install_packages() {
  log "Updating system and installing required packages..."
  apt update
  apt upgrade -y
  apt install -y make
  apt install -y git
  apt install -y fail2ban
  apt install -y iptables
  apt install -y ipset # for iptables
  log "Packages successfully installed"
}

load_env() {
  log "Loading environment variables..."
  set -a
  source .env
  set +a
  log "Environment variables successfully loaded"
}

log() {
  local log_file="/var/log/init.log"
  local msg="$1"
  local ts
  ts=$(date +"%F %T")
  local line="===================================================================="
  echo -e "\n$line" | tee -a "$log_file"
  echo "[INIT][$ts] $msg" | tee -a "$log_file"
  echo "$line" | tee -a "$log_file"
}

set_timezone() {
  log "Setting timezone to UTC..."
  timedatectl set-timezone UTC
  log "Timezone successfully set"
}

configure_dns() {
  log "Configuring DNS..."
  touch /etc/resolv.conf || true
  echo "nameserver ${DNS1}" > /etc/resolv.conf
	echo "nameserver ${DNS2}" >> /etc/resolv.conf
	echo "nameserver 1.1.1.1" >> /etc/resolv.conf
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
  log "DNS successfully configured"
}



load_env
set_timezone
install_packages
configure_dns
configure_ssh
configure_fail2ban
finish
