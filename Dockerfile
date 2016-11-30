# Docker Parliament triple store
#

FROM     ubuntu:15.10
MAINTAINER daXid


# Install
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes \
	openssh-server \
	sudo \
	wget \
	gcc \
	vim \
	nano \
	dialog \
	unzip \ 
	openjdk-8-jdk \ 	
	ssh


# Set environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN env	


# Users and passwords	
RUN echo 'root:xxxx' | chpasswd


# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/22/49701/g' /etc/ssh/sshd_config
#RUN echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config


# Parliament
RUN mkdir /usr/local/ParliamentKB
RUN wget -P /usr/local/ParliamentKB/ http://semwebcentral.org/frs/download.php/555/ParliamentQuickStart-v2.7.10-gcc-64-ubuntu-15.10.zip
RUN unzip /usr/local/ParliamentKB/ParliamentQuickStart-v2.7.10-gcc-64-ubuntu-15.10.zip -d /usr/local/ParliamentKB
RUN chown -R root:root /usr/local/ParliamentKB
RUN chmod +x /usr/local/ParliamentKB/StartParliament.sh
RUN chmod +x /usr/local/ParliamentKB/StartParliamentDaemon.sh



# Add files
ADD containerSetup.sh /home/root/containerSetup.sh
ADD jetty.xml /usr/local/ParliamentKB/conf/jetty.xml
ADD webdefault.xml /usr/local/ParliamentKB/conf/webdefault.xml
ADD realm.properties /usr/local/ParliamentKB/conf/realm.properties
ADD ParliamentConfig.txt /usr/local/ParliamentKB/ParliamentConfig.txt
ADD StartParliament.sh /usr/local/ParliamentKB/StartParliament.sh
ADD StartParliamentDaemon.sh /usr/local/ParliamentKB/StartParliamentDaemon.sh


RUN chown root:root \
	/home/root/containerSetup.sh \
	/usr/local/ParliamentKB/conf/realm.properties \
	/usr/local/ParliamentKB/conf/jetty.xml \ 	
	/usr/local/ParliamentKB/conf/webdefault.xml \
	/usr/local/ParliamentKB/ParliamentConfig.txt \ 
	/usr/local/ParliamentKB/StartParliament.sh \
	/usr/local/ParliamentKB/StartParliamentDaemon.sh



# Restarting services
#RUN stop ssh
#RUN start ssh


EXPOSE 49701
EXPOSE 8089


CMD ["/usr/sbin/sshd", "-D"]
