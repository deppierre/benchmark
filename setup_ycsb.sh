#!/bin/bash
yum update -y
yum install -y java-devel
chown -R 0755 /tmp
cd /tmp
wget -nv https://github.com/brianfrankcooper/YCSB/releases/download/0.17.0/ycsb-0.17.0.tar.gz
tar -xvf ycsb-0.17.0.tar.gz
cd ycsb-0.17.0
echo -e "recordcount= 100000\noperationcount=10000000\nworkload=site.ycsb.workloads.CoreWorkload\nreadallfields=true\nreadproportion=0\nupdateproportion=1\nscanproportion=0\ninsertproportion=0\nrequestdistribution=zipfian" > benchmark
wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
tar xzf apache-maven-*-bin.tar.gz -C /usr/local
cd /usr/local
ln -s apache-maven-* maven
echo -e "export PATH=$PATH:/usr/local/maven/bin" | tee /etc/profile.d/maven.sh
cd /tmp/ycsb-0.17.0