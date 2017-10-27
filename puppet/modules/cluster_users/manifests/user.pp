# Creates a user under the cluster machines
# The subclass name MUST have the same name as the file.pp

# Enables a ssh key in the key-keeper

class cluster_users::user {
    
    # Put here your username
    $create_user = "user"
    $presence   = 'present'


    macro_useradd { "$create_user" :
        real_name => "John Doe",
        password => 'secret!',
        presence => "$presence",
    }

# Configured in parent
    if $cluster_users::cluster_key == 'true' {
        $log_message = "Deploying keys for new user..."

        # Deploys only if present
        if $presence == 'present' {

            ssh_deploy { "$create_user" : }
        }
    }


    # Notify Server
    #notice($log_message)

    # Notify Client
    # notify{"debugou":

}
