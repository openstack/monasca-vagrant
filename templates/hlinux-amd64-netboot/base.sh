# Update the box
apt-get -y update
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev
apt-get -y install curl unzip

# Set up sudo
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo hLinux`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub

# Install upstart - needed until hLinux switches to systemd and all upstart scripts are converted
apt-get install upstart
# Install rsync used for vagrant synced dirs
apt-get install rsync

# Setup proxy
cat <<EOF >> /root/.bashrc
export http_proxy='http://web-proxy.fc.hp.com:8080'
export https_proxy='http://web-proxy.fc.hp.com:8080'
EOF

