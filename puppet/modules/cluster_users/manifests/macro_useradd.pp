# Macro used for add a User

define macro_useradd ( $real_name, $password, $presence ) {

# Grabs username from class { tittle : }:
$username = $title

# Checks if the user will have shell access
    if $cluster_users::deny_shell == 'true' {

        $shell_type = "/bin/false"
        $has_home = "false"

    } else {

        $shell_type = "/bin/bash"
        $has_home = "true"
    }

# Creates the user
  user { "$username" :

    managehome => "$has_home",
    comment    => "$real_name",
    home       => "/home/$username",
    shell       => "$shell_type",
    password    => "$password",
    ensure      => "$presence"
  }


}
