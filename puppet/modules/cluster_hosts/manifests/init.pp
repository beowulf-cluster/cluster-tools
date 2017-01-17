# Distribute the hosts file amongst all cluster nodes

# I prefer this approach since it is easier to maintain instead of keeping track of the puppet hosts resource

class cluster_hosts {

    file { '/etc/hosts':
        ensure => present,
        owner => 'root',
        group => 'root',
        mode => '0644',
        source => "puppet:///modules/cluster_hosts/hosts",
     }
}
