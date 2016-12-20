#!/bin/bash
export LC_ALL="en_US.UTF-8"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export JAVA_HOME="/usr/lib/jvm/default-java"
#export CLASSPATH="/usr/local/ParliamentKB/lib/"

cd /usr/local/ParliamentKB
./StartParliamentDaemon.sh start
