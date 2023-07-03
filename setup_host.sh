#!/bin/bash
yum update -y
yum install -y https://repo.mongodb.org/yum/amazon/2/mongodb-org/5.0/x86_64/RPMS/mongodb-org-server-5.0.9-1.amzn2.x86_64.rpm
systemctl stop mongod
/usr/bin/mongod -f /etc/mongod.conf --bind_ip_all --fork
yum install -y java-1.8.0-openjdk
chown -R 0755 /tmp
cd /tmp
wget -nv https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz
tar -xvf ycsb-0.17.0.tar.gz
cd ycsb-0.17.0
echo -e "recordcount= 10000000\noperationcount=1000000000\nworkload=site.ycsb.workloads.CoreWorkload\nreadallfields=true\nreadproportion=0\nupdateproportion=1\nscanproportion=0\ninsertproportion=0\nrequestdistribution=zipfian" > benchmark
wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
tar xzf apache-maven-*-bin.tar.gz -C /usr/local
cd /usr/local
ln -s apache-maven-* maven
echo -e "export PATH=$PATH:/usr/local/maven/bin" | tee /etc/profile.d/maven.sh
cd /tmp/ycsb-0.17.0
chmod 0755 -R /var/lib/mongo