#!/bin/sh
JAVA_OPTS="$JAVA_OPTS -Ddrools.platform.conf=/home/guvnor/myconfig"
export JAVA_OPTS
until /usr/bin/pg_isready
do
sleep 1
echo "not ready"
done
CATALINA_OPTS="-Xms1536m -Xmx6536m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=556m -XX:+DisableExplicitGC -Dhibernate.dialect=org.hibernate.dialect.PostgreSQLDialect -Dorg.kie.example.repositories=/home/kie-samples -Dorg.kie.example=true -Dorg.uberfire.metadata.index.dir=/home/lucene -Dorg.uberfire.nio.git.daemon.host=0.0.0.0 -Dorg.guvnor.m2repo.dir=/home/M2_HOME -Dorg.uberfire.nio.git.dir=/home/niodir -Djava.security.auth.login.config=/home/tomcat7/apache-tomcat-7.0/conf/jaasConfig -Dbtm.root=/home/bittronix -Dbitronix.tm.configuration=/home/tomcat7/apache-tomcat-7.0/conf/btm-config.properties -Djbpm.tsr.jndi.lookup=java:comp/env/TransactionSynchronizationRegistry -Dorg.kie.server.persistence.ds=java:comp/env/jdbc/kieserver -Dorg.kie.server.persistence.dialect=org.hibernate.dialect.PostgresPlusDialect -Dorg.kie.server.persistence.tm=org.hibernate.service.jta.platform.internal.BitronixJtaPlatform -Dorg.kie.server.location=http://localhost:8080/kie-server/services/rest/server -Dorg.kie.server.controller=http://localhost:8080/kie-wb/rest/controller"
"