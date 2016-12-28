#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Running Drools Workbench on JBoss Wildfly..."
exec $JBOSS_HOME/bin/standalone.sh  -b $JBOSS_BIND_ADDRESS -c standalone-full-drools.xml  -Dorg.kie.demo=$KIE_DEMO -Dorg.kie.example.repositories=/home/kie-example  -Dorg.uberfire.metadata.index.dir=/home/lucene -Dorg.uberfire.nio.git.daemon.host=0.0.0.0 -Dorg.guvnor.m2repo.dir=/root/.m2/repository -DM2_HOME=/root/.m2/repository -Dorg.uberfire.nio.git.dir=/home/niodir  -Djbpm.tsr.jndi.lookup=java:comp/env/TransactionSynchronizationRegistry -Dorg.kie.server.persistence.dialect=org.hibernate.dialect.PostgresPlusDialect -Dorg.kie.server.persistence.ds=java:jboss/datasources/jbpmDS  -Dorg.kie.server.location="http://localhost:8080/kie-server/services/rest/server" -Dorg.kie.server.controller="http://localhost:8080/kie-wb/rest/controller" -Derrai.bus.enable_sse_support=false
exit $?org.kie.example.repositories