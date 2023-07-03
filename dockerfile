FROM centos

ARG MAVEN_VERSION=3.9.3
ARG YCSB_VERSION=0.17.0

#Install MongoDB
WORKDIR /data/db

RUN sed -i -e "s|mirrorlist=|#mirrorlist=|g" /etc/yum.repos.d/CentOS-* &&\
    sed -i -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-* &&\
    yum update -y &&\
    yum install -y https://repo.mongodb.org/yum/amazon/2/mongodb-org/5.0/x86_64/RPMS/mongodb-org-server-5.0.9-1.amzn2.x86_64.rpm wget

#Install YCSB
WORKDIR /usr/local

RUN yum install -y java-1.8.0-openjdk &&\
    wget -nv https://github.com/brianfrankcooper/YCSB/releases/download/$YCSB_VERSION/ycsb-$YCSB_VERSION.tar.gz &&\
    tar xzfv ycsb-$YCSB_VERSION.tar.gz &&\
    wget https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz &&\
    tar xzfv apache-maven-$MAVEN_VERSION-bin.tar.gz &&\
    ln -s apache-maven-3.9.3 maven &&\
    ln -s ycsb-$YCSB_VERSION ycsb &&\
    echo -e "export PATH=$PATH:/usr/local/maven/bin" | tee /etc/profile.d/maven.sh &&\
    echo -e "recordcount= 1000000\noperationcount=1000000\nworkload=site.ycsb.workloads.CoreWorkload\nreadallfields=true\nreadproportion=0\nupdateproportion=1\nscanproportion=0\ninsertproportion=0\nrequestdistribution=zipfian\nmaxexecutiontime=600" > ycsb/benchmark

#Cleaning
RUN rm -f *.tar.gz

EXPOSE 27017

CMD ["mongod", "--bind_ip_all"]