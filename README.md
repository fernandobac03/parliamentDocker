# GitHub repo. content

Scripts and stuff for building a Docker image of Parliament triple store (http://parliament.semwebcentral.org/).


## Files :

	README.md - This file.
	Dockerfile - Docker file for building a Docker Image.
	setup.sh - Host script for removing old containers and images from host machine. Then, it creates a Docker image called "parliament_img".
	jetty.xml - Web and application server configuration file .
	ParliamentConfig.txt - Parliament configuration file, modified to enable basic authentication.
	StartParliament.sh - Parliament startup script (last line modified to exec $EXEC).
	StartParliamentDaemon.sh - Parliament startup script as a daemon.
	webdefault.xml - Jetty Webapp config modified to enable basic authentication.
	realm.properties - Jetty declaration of users.


# Instructions:

## Run the image in a container
For instance with :
docker run -d --name="parliament1" -p 8089:8089 daxid/parliament_triplestore

 
## Runtime informations

Parliament runs on port 8089. 
The application web interface should be available at http://localhost:8089/parliament.
The access recquire login : parliament /pwd : xxxx  (you can modify that in /usr/local/ParliamentDB/conf/realm.properties)
Stoping the container (docker stop parliament1) should shut down parliament gracefully so it can flush the databases and avoid coruption. You can  flush using the web interface before stopping the container to be sure... 

To check the logs for the container you gave --name parliament, use:

```docker logs parliament```

To stop the named container, use:

```docker stop parliament```

To restart a named container (it will remember the volume and port config)

```docker restart parliament```


## Data persistence

Parliament data is stored in the volume /usr/local/ParliamentKB/data within the container.
Note that unless you use docker restart or one of the mechanisms below, data
is lost between each run of the image.

To store the data in a named Docker volume container parliament-data, create it first as:

```docker run --name parliament-data -v /usr/local/ParliamentKB/data busybox```

Then start Parliament using --volumes-from. This allows you to later upgrade the
Parliament docker image without losing the data. The command below also uses
-d to start the container in the background.

```docker run -d --name parliament --volumes-from parliament-data -p 8089:8089 daxid/parliament_triplestore```


If you want to store fuseki data in a specified location on the host (e.g. for
disk space or speed requirements), specify it using -v:

```docker run -d --name parliament -v /volume/hd/parliament-data:/usr/local/ParliamentKB/data -p 8089:8089 daxid/parliament_triplestore```

Note that the data volume must only be accessed from a single Parliament container at a time.


# Todo 

- Run as non-root user
- Setup a random password on first startup
