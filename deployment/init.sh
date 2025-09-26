#!/bin/bash
set -e

LOG_FILE="/var/log/init.log"

log() {
  local msg="$1"
  local ts
  ts=$(date +"%F %T")
  local line="===================================================================="
  echo -e "\n$line" | tee -a "$LOG_FILE"
  echo "[INIT][$ts] $msg" | tee -a "$LOG_FILE"
  echo "$line" | tee -a "$LOG_FILE"
}

log "Loading environment variables..."
set -a &&
source .env &&
set +a &&

log "Setting timezone to UTC..."
timedatectl set-timezone UTC &&

log "Updating system and installing required packages..."
apt update &&
apt upgrade -y &&
apt install -y make &&
apt install -y git && 

log "Configuring SSH..."
cat /root/dv0vd-backup/deployment/configs/linux/ssh.pub >> /root/.ssh/authorized_keys &&
touch /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
# envsubst < ./deployment/configs/linux/ssh_env.conf > /root/.ssh/config &&
# chmod 600 /root/.ssh/config &&

log "Configuring fail2ban..."
apt install fail2ban -y &&
cat /root/dv0vd-backup/deployment/configs/fail2ban/jail.local >> /etc/fail2ban/jail.local &&
cat /root/dv0vd-backup/deployment/configs/fail2ban/fail2ban.local >> /etc/fail2ban/fail2ban.local &&
systemctl enable fail2ban &&
systemctl start fail2ban &&

log "Configuring rc.local autostart..."
rm /etc/rc.local -f &&
cp /root/dv0vd-backup/deployment/configs/linux/rc.local /etc/rc.local
chmod a+x /etc/rc.local &&

log "Initialization finished. Rebooting now..."
reboot

