
node default {
   stage { 'dbcontent': require => Stage['main'], }

  stage { 'javaapp': require => Stage['dbcontent'], }

  #  user { "pymma":
  ##    ensure   => present,
  #   password => "abcde",
  #   groups   => ['bin', 'adm', 'root'],
  # }

  # include classes from modules

  class { 'postgresql::globals':
     manage_package_repo => true,
    version             => '9.5',
   } ->
  class { 'postgresql::server':
     ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
     listen_addresses           => '*',
     postgres_password          => 'postgres',
   }

   postgresql::server::tablespace { 'security': location => '/var/lib/postgresql/9.5/security' }

   postgresql::server::tablespace { 'jbpm': location => '/var/lib/postgresql/9.5/jbpm' }

   postgresql::server::tablespace { 'loyaltyweb': location => '/var/lib/postgresql/9.5/loyaltyweb' }

   postgresql::server::tablespace { 'platform': location => '/var/lib/postgresql/9.5/platform' }

  # postgresql::server::tablespace { 'kieserver': location => '/var/lib/postgresql/9.5/kieserver' }


  #  postgresql::server::db { 'kieserver':
  #     user       => 'kieserver',
  #    password   => 'kieserver',
  #    tablespace => "kieserver",
  #    owner      => 'platform'
  #  }
    postgresql::server::db { 'platform':
      user       => 'platform',
       password   => 'platform',
      tablespace => "platform",
      owner      => 'platform'
    }
    postgresql::server::db { 'security':
      user       => 'security',
      password   => 'security',
      tablespace => "security",
      owner      => 'security'
    }

  #  postgresql::server::db { 'jbpm':
      user       => 'jbpm',
     password   => 'jbpm',
     tablespace => "jbpm",
     owner      => 'jbpm'
  }

     postgresql::server::db { 'loyaltyweb':
       user       => 'loyaltyweb',
      password   => 'loyaltyweb',
      tablespace => "loyaltyweb",
      owner      => 'loyaltyweb'
    }

     class { 'pgsqldpf::install':
       stage => dbcontent,
     }



  class { 'wildfly82::install':
    # stage => javaapp,
  }
  #  include 'pgsqldpf::install' # include in the installation code of this node the module postgres::install

  include 'wildfly82::install' # include in the installation code of this node the module tomcat::install
}