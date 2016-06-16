# install the wildfly82 on the machine
class wildfly82::install {
  user { "wildfly82":
    ensure     => "present",
    managehome => true,
  }
  file { "/home/wildfly":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',

  }
  #org.uberfire.nio.git.dir

  # creates directory org.uberfire.nio.git.dir
  file { "/home/niodir":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }
  # creates directory kie-samples
  file { "/home/kie-samples":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }
  # creates directory lucene
  file { "/home/lucene":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }
  # creates directory M2_HOMEs
  file { "/home/M2_HOME":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }
  # unzip chtijbug examples
  #exec { "unzip chtijbug-samples":
  #  command     => "unzip /home/examples/chtijbug.zip -d /home/kie-samples",
  #  path        => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
  #  require     => [exec["unzip wildfly"],file["/home/kie-samples"]],
  #}

  # lib::wget { "kie-samples.zip":
  #   destination => '/home/kie-samples',
  #   user        => 'root',
  #   src         => 'http://search.maven.org/remotecontent?filepath=org/kie/kie-wb-example-repositories/6.4.0.Final/kie-wb-example-repositories-6.4.0.Final.zip',
  #   require     => [exec["unzip wildfly"],file["/home/kie-samples"]],
  # }

  # exec { "unzip kie-samples":
  #   command => "unzip /home/kie-samples/kie-samples.zip -d /home/kie-samples",
  #   path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
  #   require => [lib::wget["kie-samples.zip"]],
  # }


  # creates directory /home/guvnor
  file { "/home/maven":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }

  # creates directory /root/.m2
  file { "/root/.m2":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }
  # creates directory /root/.m2/repository
  file { "/root/.m2/repository":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"],file["/root/.m2"]],
  }
  file { "/root/.m2/settings.xml":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/settings.xml',
    owner   => wildfly82,
    mode    => 664,
    require =>[exec["unzip wildfly"],file["/root/.m2"]],
  }

  # creates directory /root/.m2/repository/org
  file { "/root/.m2/repository/org":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [file["/root/.m2/repository"]],
  }
  # creates directory /root/.m2/repository/org/guvnor
  file { "/root/.m2/repository/org/guvnor":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [file["/root/.m2/repository/org"]],
  }
  # creates directory /root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project
  file { "/root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [file["/root/.m2/repository/org/guvnor"]],
  }
  # creates directory /root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/6.4.0.Final
  file { "/root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/6.4.0.Final":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [file["/root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project"]],
  }
  lib::wget { "guvnor-asset-mgmt-project-6.4.0.Final.jar":
    destination => '/root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/6.4.0.Final',
    user        => 'wildfly82',
    src         => "https://repository.jboss.org/nexus/content/groups/public-jboss/org/guvnor/guvnor-asset-mgmt-project/6.4.0.Final/guvnor-asset-mgmt-project-6.4.0.Final.jar",
    require     => [file["/root/.m2/repository/org/guvnor/guvnor-asset-mgmt-project/6.4.0.Final"]],
  }






  lib::wget { "apache-maven-3.3.9-bin.tar.gz":
    destination => '/home/maven',
    user        => 'wildfly82',
    src         => "http://mirrors.ircam.fr/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz",
    require     => [ user["wildfly82"]],
  }

  exec { "unzip maven":
    command => "tar xvfz  /home/maven/apache-maven-3.3.9-bin.tar.gz -C /home/maven ",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [lib::wget["apache-maven-3.3.9-bin.tar.gz"]],
  }

  lib::wget { "wildfly-8.2.1.Final.tar.gz":
    destination => '/home/wildfly',
    user        => 'wildfly82',
    src         => "http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.tar.gz",
    require     => [ user["wildfly82"]],
  }

  exec { "unzip wildfly":
    command => "tar xvfz  /home/wildfly/wildfly-8.2.1.Final.tar.gz -C /home/wildfly && mv /home/wildfly/wildfly-8.2.1.Final /home/wildfly/wildfly-8.2 ",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [lib::wget["wildfly-8.2.1.Final.tar.gz"]],
    user    => "wildfly82"
  }



  # creates directory /home/guvnor
  file { "/home/guvnor":
    ensure  => directory,
    owner   => 'wildfly82',
    mode    => '0664',
    require => [exec["unzip wildfly"]],
  }

  # creates directory /home/bittronix
  file { "/home/wildfly/wildfly-8.2/modules/org":
    ensure   => directory,
    owner    => 'wildfly82',
    mode     => '0664',
    recurse  => "true",
    require  => [exec["unzip wildfly"]],
  }

  file { "/home/wildfly/wildfly-8.2/modules/org/postgresql":
    ensure   => directory,
    owner    => 'wildfly82',
    mode     => '0664',
    recurse  => "true",
    require  => [file["/home/wildfly/wildfly-8.2/modules/org"]],
  }
  file { "/home/wildfly/wildfly-8.2/modules/org/postgresql/main":
    ensure   => directory,
    owner    => 'wildfly82',
    mode     => '0664',
    recurse  => "true",
    require  => [file["/home/wildfly/wildfly-8.2/modules/org/postgresql"]],
  }
  file { "/home/wildfly/wildfly-8.2/modules/org/postgresql/main/postgresql-9.4.1208.jre7.jar":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/postgresql-9.4.1208.jre7.jar',
    owner   => wildfly82,
    mode    => 664,
    require => [file["/home/wildfly/wildfly-8.2/modules/org/postgresql/main"]],
  }
  file { "/home/wildfly/wildfly-8.2/modules/org/postgresql/main/module.xml":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/module.xml',
    owner   => wildfly82,
    mode    => 664,
    require => exec["unzip wildfly"],
  }



  file { "/home/wildfly/wildfly-8.2/bin/standalone.conf":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/standalone.conf',
    owner   => wildfly82,
    mode    => 664,
    require => exec["unzip wildfly"],
  }

  file { "/home/wildfly/wildfly-8.2/standalone/configuration/standalone.xml":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/standalone.xml',
    owner   => wildfly82,
    mode    => 664,
    require => exec["unzip wildfly"],
  }

  file { "/home/wildfly/wildfly-8.2/standalone/configuration/drools-users.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/drools-users.properties',
    owner   => wildfly82,
    mode    => 664,
    require => exec["unzip wildfly"],
  }
  file { "/home/wildfly/wildfly-8.2/standalone/configuration/drools-roles.properties":
    ensure  => present,
    replace => true,
    source  => 'puppet:///modules/wildfly82/drools-roles.properties',
    owner   => wildfly82,
    mode    => 664,
    require => exec["unzip wildfly"],
  }
  # download kie-wb.war :
  lib::wget { "kie-wb.war":
    destination => '/home/wildfly/wildfly-8.2/standalone/deployments',
    user        => 'wildfly82',
    src         => maven_to_link("org.chtijbug.drools:drools-framework-kie-wb-wars:2.0.0-SNAPSHOT:war"),
    require     => [
      exec["unzip wildfly"],
      file["/home/guvnor"]]
  }


}



