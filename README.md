# Dv0vD Backup server
Backup server for dv0vd.xyz website.

## Getting started  
1) Configure the `.env` file.
2) Copy SSH public key to `./deployment/configs/linux/ssh.pub`.
3) Copy Podman images to `./deployment/images`:
- coturn_4.7.0.tar
- dv0vd-https-proxy_1.1.0.tar
- dv0vd-socks4_1.1.3.tar
- dv0vd-socks5_1.1.1.tar
- mongo_7.0.16.tar
- nginx_1.27.3.tar
- node_24.5.0-alpine.tar
- postgres_15.14-alpine.tar
- synapse_1.135.0.tar
4) Run the initialization script `./deployment/init.sh`.
