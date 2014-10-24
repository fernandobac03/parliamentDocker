# Docker Parliament triple store
#
# VERSION               0.0.1

FROM     ubuntu:14.04
MAINTAINER Alber Sanchez


# Install
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes \
	openssh-server \
	sudo \
	wget \
	gcc \
	nano \
	dialog \
	unzip \ 
	default-jre \ 
	default-jdk \ 
	ssh


# Set environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
RUN env	


# Users and passwords	
RUN echo 'root:xxxx.xxxx.xxxx' | chpasswd


# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/22/49701/g' /etc/ssh/sshd_config
#RUN echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config


# Parliament
RUN mkdir /usr/local/ParliamentKB
RUN wget -P /usr/local/ParliamentKB/ semwebcentral.org/frs/download.php/522/ParliamentQuickStart-v2.7.6-gcc-64.zip
RUN unzip /usr/local/ParliamentKB/ParliamentQuickStart-v2.7.6-gcc-64.zip -d /usr/local/ParliamentKB
RUN chown -R root:root /usr/local/ParliamentKB
RUN chmod +x /usr/local/ParliamentKB/StartParliament.sh
RUN chmod +x /usr/local/ParliamentKB/StartParliamentDaemon.sh



# Add files
ADD containerSetup.sh /home/root/containerSetup.sh
ADD jetty.xml /usr/local/ParliamentKB/conf/jetty.xml
ADD ParliamentConfig.txt /usr/local/ParliamentKB/ParliamentConfig.txt
ADD realm.properties /etc/realm.properties


RUN chown root:root \
	/home/root/containerSetup.sh \
	/usr/local/ParliamentKB/conf/jetty.xml \ 
	/usr/local/ParliamentKB/ParliamentConfig.txt \ 
	/etc/realm.properties


# Restarting services
RUN stop ssh
RUN start ssh


EXPOSE 49701
EXPOSE 49702


CMD ["/usr/sbin/sshd", "-D"]
