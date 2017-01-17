# Deploys ssh rsa keys under created user for MPI comunication
#
# Since this is my first complex module, it needs a little rework.

define ssh_deploy() {

# Main paramenter:
$username = $title
        
    # Creates the containing folder
    file { "/home/$username/.ssh" :
        ensure => 'directory',
        owner => "$username",
        group => "$username",
        mode => 0700,
    } 
        
    # Generates the key pair with random label 
    exec { "ssh-keygen -t rsa -C $username@cluster -f id_rsa -N ''" :
        path => "/usr/bin",
        cwd => "/home/$username/.ssh",
        creates => "/home/$username/.ssh/id_rsa"
    }

        
    # Workaround. since 'ssh_deploy()' is defined as resource, it
    # won't run in clients when the 'exec' resource is the same.
    # If the exec { title : } is different, the command runs flawlessly

    # The main working dir
    $cwd = "/home/$username/.ssh"

    exec { "cat $cwd/id_rsa.pub > authorized_keys" :
        path => "/usr/bin:/bin",
        cwd => "/home/$username/.ssh",
        creates => "/home/$username/.ssh/authorized_keys",
        onlyif => "test -e $cwd/id_rsa.pub",
    }
     
    # ===================================
    # The key pair ownership and auth file
    #
    # The private key:
    file {"/home/$username/.ssh/id_rsa" :
        owner => "$username",
        group => "$username",
        mode => 0600,
    }
    
    # The public key
    file {"/home/$username/.ssh/id_rsa.pub" :
        owner => "$username",
        group => "$username",
        mode => 0600,
    }

    # The authorized keys
    file {"/home/$username/.ssh/authorized_keys" :
        owner => "$username",
        group => "$username",
        mode => 0600,
    }

    # The known hosts.
    # This directive MUST be set since in the first connection SSH
    # Asks for confirmation. It's safer to do this than disable server confirmation
    #
    # Change the main file in the file module directory
    file {"/home/$username/.ssh/known_hosts" :
        ensure => 'present',
        owner => "$username",
        group => "$username",
        mode => 0600,
        source => "puppet:///modules/cluster_users/known_hosts",
    }

}
