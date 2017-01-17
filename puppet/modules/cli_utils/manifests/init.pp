# Aplicativos comuns a todos os membos do cluster e do laboratorio

# Aplicativos sem interface grafica

class cli_utils {

    Package { ensure => 'installed' }

    package { 'git': }
    package { 'htop': }
    package { 'ntpdate': }
    package { 'vim': }
    package { 'emacs': }
    package { 'openssh-server': }

}
