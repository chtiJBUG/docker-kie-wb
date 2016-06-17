class pgsqldpf::install  {
    
  package { "gzip": ensure => present }
  
  file { ["/tmp/init_guvnor_security.sql"]: # create script sql from template
    ensure  => present,
    content => template("pgsqldpf/init_guvnor_security.sql.erb"),
    owner   => 'postgres'
  }
    file { ["/tmp/loyalty.sql"]: # create script sql from template
    ensure  => present,
    content => template("pgsqldpf/loyalty.sql"),
    owner   => 'postgres'
  }

  exec { "Import_data":
    command => "/etc/init.d/postgresql start  && psql -f /tmp/loyalty.sql loyaltyweb  && psql -f /tmp/init_guvnor_security.sql security   ",
    path    => "/usr/local/bin/:/bin/:/usr/sbin/:/usr/bin",
    require => [Package['postgresql95-server'], Package['gzip'],File['/tmp/loyalty.sql'],File['/tmp/init_guvnor_security.sql']],
    user    => "postgres"
  }

 

}
