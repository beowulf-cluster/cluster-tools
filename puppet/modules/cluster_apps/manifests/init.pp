# Aplicativos utilizados no Cluster

class cluster_apps {

    Package { ensure => installed }

    package { 'mpich': }
    package { 'gromacs': }
    package { 'gromacs-mpich': }

    # Pacote Python para gromacs
    package { 'mgltools-cmolkit': }

    package { 'nfs-kernel-server': }

    service { 'nfs-kernel-server':
        ensure => running,
        enable => true,
    }

}
