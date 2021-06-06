#!/bin/bash
sudo apt update
sudo apt upgrade -y
curl https://deb.releases.teleport.dev/teleport-pubkey.asc | sudo apt-key add -
# Add repo to APT
add-apt-repository 'deb https://deb.releases.teleport.dev/ stable main'
# Update APT Cache
sudo apt-get update
# Install Teleport
sudo apt install teleport

cat > teleport.yaml <<EOF
teleport:
      data_dir: /var/lib/teleport
auth_service:
      enabled: true
      cluster_name: "teleport-tryouts"
      listen_addr: 192.168.43.67:3025
      tokens:
      - proxy,node,app:f7adb7ccdf04037bcd2b52ec6010fd6f0caec94ba190b765
ssh_service:
      enabled: true
      labels:
app_service:
      enabled: true
      debug_app: true
proxy_service:
      enabled: true
      listen_addr: 0.0.0.0:3023
      web_listen_addr: 0.0.0.0:3080
      tunnel_listen_addr: teleport.it-qa.chargepoint.com:3024
      tunnel_public_addr: teleport.it-qa.chargepoint.com:3024
      public_addr: teleport.it-qa.chargepoint.com:3080
EOF
sudo mv teleport.yaml /etc/
sudo echo '127.0.0.1  teleport.it-qa.chargepoint.com' | sudo tee -a /etc/hosts
cat > teleport.service <<EOF
[Unit]
Description=Teleport SSH Service
After=network.target
[Service]
Type=simple
Restart=on-failure
EnvironmentFile=-/etc/default/teleport
ExecStart=/usr/local/bin/teleport start --pid-file=/run/teleport.pid
ExecReload=/bin/kill -HUP $MAINPID
PIDFile=/run/teleport.pid
LimitNOFILE=8192
[Install]
WantedBy=multi-user.target
EOF
sudo cp teleport.service /etc/systemd/system/teleport.service
sudo systemctl daemon-reload
sudo systemctl enable teleport
sudo systemctl start teleport
sudo systemctl status teleport
sudo apt install letsencrypt
sudo certbot certonly --standalone --agree-tos --preferredchallenges http -d teleport.it-qa.chargepoint.com

sudo tctl users add teleport-admin ubuntu


