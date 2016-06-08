# install the tomcat7 on the machine
class tomcat7::install {
  user { "tomcat7":
    ensure     => "present",
    managehome => true,
  }

#org.uberfire.nio.git.dir

  # creates directory org.uberfire.nio.git.dir
  file { "/home/niodir":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }
  # creates directory kie-samples
  file { "/home/kie-samples":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }
  # creates directory lucene
  file { "/home/lucene":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }
  # creates directory M2_HOMEs
  file { "/home/M2_HOME":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }  
  # unzip chtijbug examples
 exec { "unzip chtijbug-samples":
    command => "unzip /home/examples/chtijbug.zip -d /home/kie-samples",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
     require     => [exec["unzip tomcat"],file["/home/kie-samples"]],
  }
  # kie-tomcat-integration.jar :
  lib::wget { "kie-samples.zip":
    destination => '/home/kie-samples',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=org/kie/kie-wb-example-repositories/6.2.0.CR4/kie-wb-example-repositories-6.2.0.CR4.zip',
    require     => [exec["unzip chtijbug-samples"],exec["unzip tomcat"],file["/home/kie-samples"]],
  }

   exec { "unzip kie-samples":
    command => "unzip /home/kie-samples/kie-samples.zip -d /home/kie-samples",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [lib::wget["kie-samples.zip"]],
  }
  
  
  # creates directory /home/guvnor
  file { "/home/maven":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }

  lib::wget { "apache-maven-3.1.1-bin.tar.gz":
    destination => '/home/maven',
    user        => 'tomcat7',
    src         => "http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz",
    require     => [Package['openjdk-7-jdk'], user["tomcat7"]],
  }

  exec { "unzip maven":
    command => "tar xvfz  /home/maven/apache-maven-3.1.1-bin.tar.gz -C /home/maven ",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [lib::wget["apache-maven-3.1.1-bin.tar.gz"]],
  }

  lib::wget { "apache-tomcat-7.0.56.tar.gz":
    destination => '/home/tomcat7',
    user        => 'tomcat7',
    src         => "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.56/bin/apache-tomcat-7.0.56.tar.gz",
    require     => [Package['openjdk-7-jdk'], user["tomcat7"]],
  }

  exec { "unzip tomcat":
    command => "tar xvfz  /home/tomcat7/apache-tomcat-7.0.56.tar.gz -C /home/tomcat7 && mv /home/tomcat7/apache-tomcat-7.0.56 /home/tomcat7/apache-tomcat-7.0 ",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [lib::wget["apache-tomcat-7.0.56.tar.gz"]],
    user    => "tomcat7"
  }

  file { "/home/tomcat7/apache-tomcat-7.0/bin/catalina.sh":
    mode    => 755,
    require => [exec["unzip tomcat"]],
  }

  # creates directory /home/guvnor
  file { "/home/guvnor":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }

  # creates directory /home/bittronix
  file { "/home/bittronix":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"]],
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/btm-config.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/btm-config.properties',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"],
  }

  file { "/home/bittronix/conf":
    ensure  => directory,
    owner   => 'tomcat7',
    mode    => '0664',
    require => [exec["unzip tomcat"], file["/home/bittronix"]],
  }

  file { "/home/bittronix/conf/resources.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/resources.properties',
    owner   => tomcat7,
    mode    => 664,
    require => [exec["unzip tomcat"], file["/home/bittronix/conf"]]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/catalina.policy":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/catalina.policy',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/catalina.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/catalina.properties',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/context.xml":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/context.xml',
    owner   => tomcat7,
    mode    => 664,
    require => [exec["unzip tomcat"], file["/home/tomcat7/apache-tomcat-7.0/conf/server.xml"]]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/jaasConfig":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/jaasConfig',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/jpa.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/jpa.properties',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/logging.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/logging.properties',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/server.xml":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/server.xml',
    owner   => tomcat7,
    mode    => 664,
    require => exec["unzip tomcat"]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/bin/setenv.sh":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/tomcat7/setenv.sh',
    owner   => tomcat7,
    mode    => 774,
    require => [exec["unzip tomcat"], file["/home/tomcat7/apache-tomcat-7.0/conf/server.xml"]]
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/tomcat-users.xml": # create file from template
    ensure  => present,
    replace => true,
    owner   => 'tomcat7',
    mode    => '0664',
    source  => 'puppet:///modules/tomcat7/tomcat-users.xml',
    require => [exec["unzip tomcat"]],
  }

  file { "/home/tomcat7/apache-tomcat-7.0/conf/web.xml": # create file from template
    ensure  => present,
    replace => true,
    owner   => 'tomcat7',
    mode    => '0664',
    source  => 'puppet:///modules/tomcat7/web.xml',
    require => [exec["unzip tomcat"]],
  }
  #https://oss.sonatype.org/content/repositories/snapshots/org/chtijbug/drools/drools-platform-kie/6.2.0-SNAPSHOT/drools-platform-kie-6.2.0-20141216.152028-1-tomcat7.war
  # download kie-wb.war :
  lib::wget { "kie-wb.war":
    destination => '/home/tomcat7/apache-tomcat-7.0/webapps/',
    user        => 'tomcat7',
    src         => maven_to_link("org.chtijbug.drools:drools-framework-kie-wb-wars:2.0.0-SNAPSHOT:war"),
    require     => [
      exec["unzip tomcat"],
      exec["unzip kie-samples"],
      lib::wget["loginModule.jar"],
      file["/home/tomcat7/apache-tomcat-7.0/bin/setenv.sh"],
      file["/home/guvnor"]]
  }
  
  # download drools-platform-login.jar : 
  lib::wget { "loginModule.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => maven_to_link("org.chtijbug.drools:drools-framework-login:2.0.0-SNAPSHOT:jar"),
    require     => [
      exec["unzip tomcat"],
      lib::wget["commons-dbutils.jar"],
      lib::wget["9.3-1101-jdbc4.jar"],
      
      file["/home/tomcat7/apache-tomcat-7.0/bin/setenv.sh"]],
  }


  # download mysql-jdbc.jar :
  lib::wget { "mysql-connector-java-5.1.39.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.39/mysql-connector-java-5.1.39.jar',
    require     => [exec["unzip tomcat"]],
  }
  # download pgsql-jdbc.jar :
  lib::wget { "9.3-1101-jdbc4.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'https://oss.sonatype.org/content/repositories/releases/org/postgresql/postgresql/9.4.1208.jre7/postgresql-9.4.1208.jre7.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download DBUtils.war :
  lib::wget { "commons-dbutils.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib',
    user        => 'root',
    src         => 'http://central.maven.org/maven2/commons-dbutils/commons-dbutils/1.6/commons-dbutils-1.6.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download drools-platform-ui.war :
  # lib::wget { "drools-platform-ui.war":
  #  destination => '/home/tomcat7/apache-tomcat-7.0/webapps/',
  #  user        => 'tomcat7',
  #  src         => maven_to_link("org.chtijbug.drools:drools-platform-manager-ui:1.0.0-SNAPSHOT:war"),
  #  require     => [exec["unzip tomcat"], lib::wget["loginModule.jar"], file["/home/tomcat7/apache-tomcat-7.0/bin/setenv.sh"]],
  #}

  # download jacc-api-1.5.jar :
  lib::wget { "javax.security.jacc-api.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=javax/security/jacc/javax.security.jacc-api/1.5/javax.security.jacc-api-1.5.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download slf4j-api.jar :
  lib::wget { "slf4j-api-1.7.21.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=org/slf4j/slf4j-api/1.7.21/slf4j-api-1.7.21.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download slf4j-jdk14-1.7.2.jar :
  lib::wget { "slf4j-jdk14-1.7.21.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://central.maven.org/maven2/org/slf4j/slf4j-jdk14/1.7.21/slf4j-jdk14-1.7.21.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download btm-tomcat55-lifecycle.jar :
  lib::wget { "btm-tomcat55-lifecycle.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=org/codehaus/btm/btm-tomcat55-lifecycle/2.1.4/btm-tomcat55-lifecycle-2.1.4.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download btm.jar :
  lib::wget { "btm.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=org/codehaus/btm/btm/2.1.4/btm-2.1.4.jar',
    require     => [exec["unzip tomcat"]],
  }

  # download jta.jar :
  lib::wget { "jta.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
    src         => 'http://search.maven.org/remotecontent?filepath=javax/transaction/javax.transaction-api/1.2/javax.transaction-api-1.2.jar',
    require     => [exec["unzip tomcat"]],
  }

  # kie-tomcat-integration.jar :
  lib::wget { "kie-tomcat-integration.jar":
    destination => '/home/tomcat7/apache-tomcat-7.0/lib/',
    user        => 'root',
   src         => 'http://search.maven.org/remotecontent?filepath=org/kie/kie-tomcat-integration/6.4.0.Final/kie-tomcat-integration-6.4.0.Final.jar',
    # src         => maven_to_link("org.kie:kie-tomcat-integration:6.2.0.CR4:jar"),
    require     => [exec["unzip tomcat"]],
  }
  


}



