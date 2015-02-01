This container when built shall contain : 
-drools-wb 2.0.0 chtjbug 
-postgres

sudo docker build -t="image-wb" .
and to run it : 
sudo docker run -d --name nhs1 -p 19418:9418 -p 19505:5005 -p 19080:8080 -p 19022:22 -p 15432:5432 -p 61616:61616 image-wb

then open a browser and go to http://localhost:19080/kie-wb and user admin with password admin



There is an ssh server
ssh -p 19022 root@localhost
password is root
the logs for the tomcat server are located under /var/log/supervisor/tomcat.log

The git repository is at port 19418.
On the machine, the repository /home/


This docker container is built on the docker hub.
If you want to download the built image : 
sudo docker pull chtijbug/drools-kie-wb
and then 
sudo docker run -d --name nhs1 -p 19080:8080 -p 19022:22 -p 15432:5432  chtijbug/drools-kie-wb
and all the rest is the same.



