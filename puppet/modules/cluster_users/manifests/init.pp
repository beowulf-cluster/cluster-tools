# Cria usuarios no cluster e no laboratorio fistat

# Variaveis: Configuracoes
#
#   $cluster_key = (true or false)
#   
#   true = cria o par de chaves ssh e armazena na pasta home do usuario que esta sendo criado
#
#   false = Valor padrao. Cria usuario mas nao cria chave de autenticacao ssh
#    
#

class cluster_users ( $cluster_key = 'false',  $deny_shell = 'false')  {
    
    include user
}
