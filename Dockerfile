FROM ubuntu:16.04
MAINTAINER Nicolas Heron

ENV REFRESHED_AT 2016-06-14
RUN echo 'deb http://us.archive.ubuntu.com/ubuntu xenial main universe' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN apt-get install -y wget sudo
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN apt-get update
RUN apt-get -y upgrade

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
#install
RUN apt-get install -y wget openssh-server supervisor openjdk-8-jdk postgresql postgresql-contrib unzip puppet vim

ADD examples /home/examples  
#setup tomcat7

ENV M2_HOME /home/maven/apache-maven-3.3.9


# to copy Puppet code into container
ADD drools_platform_puppet /drools_platform_puppet 
RUN puppet module install puppetlabs/postgresql

#to run Puppet code
RUN puppet apply -d drools_platform_puppet/manifests/site.pp --confdir=drools_platform_puppet/  --modulepath=/etc/puppet/modules:drools_platform_puppet/modules: --libdir=drools_platform_puppet/modules/lib --verbose
USER root

# clean packages
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# tomcat7
EXPOSE 8080

# Expose the PostgreSQL and SSH port
EXPOSE 22
# for remote debugging of tomcat7 applications.
EXPOSE 5005
EXPOSE 5432
EXPOSE 61616
EXPOSE 9418


CMD ["/usr/bin/supervisord"]

