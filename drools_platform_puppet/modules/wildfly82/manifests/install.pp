# install the wildfly82 on the machine
class wildfly82::install {


  # download kie-wb.war :
  lib::wget { "kie-wb.war":
    destination => '/opt/jboss/wildfly/standalone/deployments',
    user        => 'root',
    src         => maven_to_link("org.chtijbug.drools:drools-framework-kie-wb-wars:2.0.0-SNAPSHOT:war"),

  }

  # download kie-wb.war :
  lib::wget { "kie-server.war":
    destination => '/opt/jboss/wildfly/standalone/deployments',
    user        => 'root',
    src         => maven_to_link("org.chtijbug.drools:kie-server:2.0.0-SNAPSHOT:war"),

  }
}



