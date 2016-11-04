FROM jboss/wildfly:10.1.0.Final
MAINTAINER Nicolas Heron

ENV REFRESHED_AT 2016-11-04

ENV JBOSS_BIND_ADDRESS 0.0.0.0
USER root
#RUN rpm -Uvh http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
RUN yum makecache fast
RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y update
RUN yum -y upgrade
#RUN yum install -y wget python-setuptools postgresql95-server postgresql95-contrib postgresql95-libs  postgresql95 unzip puppet vim gzip gunzip
RUN yum install -y wget python-setuptools  unzip puppet vim gzip gunzip git
RUN mkdir /home/db
RUN mkdir /home/lucene
RUN mkdir /home/niodir
RUN mkdir /home/kie-example
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-nautic-project.git
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-carinsurance-project.git
RUN cd /home/kie-example && git clone https://github.com/chtiJBUG/onboarding-loyalty-project.git
#RUN mkdir -p  /var/log/supervisor
#RUN easy_install supervisor
#ADD examples /home/examples

# to copy Puppet code into container
ADD drools_platform_puppet /drools_platform_puppet 
RUN puppet module install puppetlabs/postgresql
#RUN mkdir -p $JBOSS_HOME/modules/org/postgresql/main
#ADD etc/module.xml $JBOSS_HOME/modules/org/postgresql/main/module.xml
#ADD etc/postgresql-9.4.1208.jre7.jar $JBOSS_HOME/modules/org/postgresql/main/postgresql-9.4.1208.jre7.jar
#to run Puppet code
RUN puppet apply -d /drools_platform_puppet/manifests/site.pp --confdir=drools_platform_puppet/  --modulepath=/etc/puppet/modules:/drools_platform_puppet/modules: --libdir=/drools_platform_puppet/modules/lib --verbose
####### SCRIPTS ############
USER root
ADD etc/start_drools-wb.sh $JBOSS_HOME/bin/start_drools-wb.sh
RUN chown jboss:jboss $JBOSS_HOME/bin/start_drools-wb.sh
####### Drools Workbench CUSTOM CONFIGURATION ############
ADD etc/standalone-full-drools.xml $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml
ADD etc/drools-users.properties $JBOSS_HOME/standalone/configuration/drools-users.properties
ADD etc/drools-roles.properties $JBOSS_HOME/standalone/configuration/drools-roles.properties
#ADD etc/supervisord.conf /etc/supervisord.conf
RUN chown jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full-drools.xml && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-users.properties && \
chown jboss:jboss $JBOSS_HOME/standalone/configuration/drools-roles.properties
RUN mkdir /root/.m2
ADD etc/settings.xml /root/.m2


# tomcat7
EXPOSE 8080

# Expose the PostgreSQL and SSH port
EXPOSE 22
# for remote debugging of tomcat7 applications.


EXPOSE 9418

VOLUME /home/db
VOLUME /home/lucene
VOLUME /home/niodir
WORKDIR $JBOSS_HOME/bin/
CMD ["/usr/bin/supervisord"]

#CMD ["./start_drools-wb.sh"]

