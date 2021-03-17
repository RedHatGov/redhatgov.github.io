#!/usr/bin/env bash

subscription-manager repos --disable=* --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-openstack-13-rpms --enable=rhel-7-server-openstack-13-tools-rpms
yum install python2-*client
yum update -y

for i in {1..30}; do useradd student$i ; done
for i in {1..30}; do echo "redhat" | passwd student$i --stdin ; done

cp /etc/ssh/sshd_config ~/
sed 's/#\?\(PermitRootLogin\s*\).*$/\1yes/' /etc/ssh/sshd_config > /tmp/sshd_config
sed 's/#\?\(PasswordAuthentication\s*\).*$/\1yes/' /tmp/sshd_config > /tmp/sshd_config2
sudo mv -f /tmp/sshd_config2 /etc/ssh/sshd_config
systemctl restart sshd

echo "Redhat1993" | passwd root --stdin
echo "Redhat1993" | passwd cloud-user --stdin

cp /home/cloud-user/.ssh/authorized_keys ./

for i in {1..30}; do mkdir /home/student${i}/.ssh && chown student${i}: /home/student${i}/.ssh && cp authorized_keys /home/student${i}/.ssh/ && chown student${i}: /home/student${i}/.ssh/authorized_keys ; done
for i in {1..30}; do chmod 700 /home/student${i}/.ssh ; done
for i in {1..30}; do chmod 600 /home/student${i}/.ssh/authorized_keys ; done

#for i in {1..30}; do userdel student$i ; done
#for i in {1..30}; do rm -rf /home/student$i ; done
[root@bastion ~]# cat bastionCleaner.sh 
#!/usr/bin/env bash

for i in {1..30}; do userdel student$i ; done
for i in {1..30}; do rm -rf /home/student$i ; done
[root@bastion ~]# cat bastionConfig.sh 
#!/usr/bin/env bash

subscription-manager repos --disable=* --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-openstack-13-rpms --enable=rhel-7-server-openstack-13-tools-rpms
yum install python2-*client
yum update -y

for i in {1..30}; do useradd student$i ; done
for i in {1..30}; do echo "redhat" | passwd student$i --stdin ; done

cp /etc/ssh/sshd_config ~/
sed 's/#\?\(PermitRootLogin\s*\).*$/\1yes/' /etc/ssh/sshd_config > /tmp/sshd_config
sed 's/#\?\(PasswordAuthentication\s*\).*$/\1yes/' /tmp/sshd_config > /tmp/sshd_config2
sudo mv -f /tmp/sshd_config2 /etc/ssh/sshd_config
systemctl restart sshd

echo "Redhat1993" | passwd root --stdin
echo "Redhat1993" | passwd cloud-user --stdin

cp /home/cloud-user/.ssh/authorized_keys ./

for i in {1..30}; do mkdir /home/student${i}/.ssh && chown student${i}: /home/student${i}/.ssh && cp authorized_keys /home/student${i}/.ssh/ && chown student${i}: /home/student${i}/.ssh/authorized_keys ; done
for i in {1..30}; do chmod 700 /home/student${i}/.ssh ; done
for i in {1..30}; do chmod 600 /home/student${i}/.ssh/authorized_keys ; done
