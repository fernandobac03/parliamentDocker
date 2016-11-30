# GitHub repo. content

Scripts and stuff for building a Docker image of Parliament triple store (http://parliament.semwebcentral.org/).


## Files :

	README.md - This file.
	Dockerfile - Docker file for building a Docker Image.
	containerSetup.sh - Commands for setting up Parliament inside a container.
	setup.sh - Host script for removing old containers and images from host machine. Then, it creates a Docker image called "parliament_img".
	jetty.xml - Web and application server configuration file, .
	ParliamentConfig.txt - Parliament configuration file, modified to enable basic authentication.
	StartParliament.sh - Parliament startup script.
	StartParliamentDaemon.sh - Parliament startup script as a daemon.
	webdefault.xml - Jetty Webapp config modified to enable basic authentication.
	realm.properties - Jetty declaration of users.


# Instructions:

## Run the image in a container
For instance with :
docker run -d --name="parliament1" -p 49701:49701 -p 8089:8089 daxid/docker_semwebcentral-parliament

## Log in the container with ssh and launch parliament
Log in the container : 
```ssh -p 49701 root@localhost``` 
The default password is xxxx
    
Run Parliament launch script : 
```/home/root/./containerSetup.sh```

## NOTES:

Parliament runs on port 8089. 
The application web interface would be available at http://localhost:8089/parliament.
The access recquire login : parliament /pwd : xxxx  (you can modify that in /usr/local/ParliamentDB/conf/realm.properties)
containerSetup.sh runs Parliament on the background by using ./StartParliament.sh &; this produces an exception message.
Remember to flush using the web interface before stopping the container. This can avoid data loss.


