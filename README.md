dockerParliamentTS
==================

Scripts for building a <a href="http://www.docker.com/">Docker</a> image of Parliament triple store.


<h3>Files:</h3>
<ul>
	<li><code>README.md</code> - This file.</li>
	<li><code>Dockerfile</code> - Docker file for building a Docker Image.</li>
	<li><code>containerSetup.sh</code> - Commands for setting up Parliament inside a container.</li>
	<li><code>setup.sh</code> - Host script for removing old containers and images from host machine. Then, it creates a Docker image called "parliament_img".</li>
	<li><code>jetty.xml</code> - Web and application server configuration file.</li>
	<li><code>ParliamentConfig.txt</code> - Parliament configuration file.</li>
</ul>

<h3>Prerequisites:</h3>
<ul>
	<li><a href="http://www.docker.com/">Docker</a></li>
</ul>


<h3>Instructions:</h3>
<ol>
	<li>Clone this project and go to the project's folder</li>
	<li>Run the host script <code>./setup.sh</code>
	<li>Log in the container <code>ssh -p 49701 root@localhost</code>. The default password is <em>xxxx.xxxx.xxxx</em></li>
	<li>Run the container script <code>/home/root/./containerSetup.sh</code></li>
	
</ol>

<h3>NOTES:</h3>
<ul>
	<li>Parliament runs on port 49702. The application web interface would be available at <a href="http://localhost:49702/parliament">http://localhost:49702/parliament</a>.</li>
	<li><code>containerSetup.sh</code> runs Parliament on the background by using <code>./StartParliament.sh &<code>; this produces an exception message.</li>
	<li>Remember to flush using the web interface before stopping teh container. This can avoid data loss.</li>
</ul>