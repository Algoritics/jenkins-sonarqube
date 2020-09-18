FROM jenkins/jenkins:lts-centos

# switch to root for install of maven and sonar scanner
USER root

# prereqs for sonar scanner
RUN yum -y update && yum -y install wget maven java-11-openjdk-devel java-11-openjdk
RUN alternatives --set java java-11-openjdk.x86_64

# prereqs for example projects
RUN yum -y update && yum -y python3 make
RUN pip3 install -U pip pytest coverage flake8

# install sonar scanner
WORKDIR /opt
RUN cd /opt \
 && wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.2.0.1873-linux.zip \
 && unzip sonar-scanner-cli-4.2.0.1873-linux.zip \
 && rm sonar-scanner-cli-4.2.0.1873-linux.zip \
 && mv sonar-scanner-4.2.0.1873-linux sonarscanner \
 && ln -s /opt/sonar-scanner/bin/sonarscanner /usr/bin/sonarscanner

ENV JAVA_HOME=/etc/alternatives/jre_11/

# switch back to jenkins user
USER jenkins
