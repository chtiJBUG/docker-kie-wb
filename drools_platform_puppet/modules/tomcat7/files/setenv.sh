#!/bin/sh
JAVA_OPTS="$JAVA_OPTS -Ddrools.platform.conf=/home/guvnor/myconfig"
export JAVA_OPTS   

CATALINA_OPTS="-Xms1536m -Xmx6536m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=556m -XX:+DisableExplicitGC -Dhibernate.dialect=org.hibernate.dialect.PostgreSQLDialect -Dorg.kie.example.repositories=/home/kie-samples -Dorg.kie.example=true -Dorg.uberfire.nio.git.daemon.host=0.0.0.0 -Dorg.guvnor.m2repo.dir=$M2_HOME -Dorg.uberfire.nio.git.dir=/home/niodir -Djava.security.auth.login.config=/home/tomcat7/apache-tomcat-7.0/conf/jaasConfig -Dbtm.root=/home/bittronix -Dbitronix.tm.configuration=/home/tomcat7/apache-tomcat-7.0/conf/btm-config.properties -Djbpm.tsr.jndi.lookup=java:comp/env/TransactionSynchronizationRegistry"