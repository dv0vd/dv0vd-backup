# env
set -a &&
source .env &&
set + a &&

# timezone
timedatectl set-timezone UTC &&

#apt
apt update &&
apt upgrade -y &&
apt install -y make &&
apt install -y git && 

#ssh
cat /root/dv0vd.xyz-backup/deployment/configs/linux/ssh.pub >> /root/.ssh/authorized_keys &&
touch /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
echo Port $SSH_PORT >> /etc/ssh/sshd_config.d/00-dv0vd.conf &&
envsubst < ./deployment/configs/linux/ssh_env.conf > /root/.ssh/config &&
chmod 600 /root/.ssh/config &&

# fail2ban
apt install fail2ban -y &&
cat /root/dv0vd.xyz-backup/deployment/configs/fail2ban/jail.local >> /etc/fail2ban/jail.local &&
cat /root/dv0vd.xyz-backup/deployment/configs/fail2ban/fail2ban.local >> /etc/fail2ban/fail2ban.local &&
systemctl enable fail2ban &&
systemctl start fail2ban &&

# restart
rm /etc/rc.local -f &&
cp /root/dv0vd.xyz-backup/deployment/configs/linux/rc.local /etc/rc.local
chmod a+x /etc/rc.local &&

reboot

