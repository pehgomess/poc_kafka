# Automacão dos testes realizados para a POC com Kafka

Automacao da instalação do kafka com TLS padrão com 3 brokers e possibilidade de efetuar um crescimento horizontal escalando mais instâncias.
Também foi desenvolvido scripts para remoção do ambiente para efetuar novamente a instalação caso necessário.

### Requisitos soft:

Na POC foi usado o openjdk1.8 a instalação e feita via ansible e precisa do repositorio com o pacote, em caso de problemas no ansible validar com o time de infraestrutura o responsavel pela ambiente (servidor), se quiser validar executar o comando abaixo

    yum search java-1.8.0-openjdk
    
- Importante que as maquinas possuem entradas no hosts, adicionar o dominio tambem para a POC.

    - Ex arquivo /etc/hosts. 
    
    127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
    IP-NODE1	kafka1.labdomain.corp
    IP-NODE2	kafka2.labdomain.corp
    IP-NODE3	kafka3.labdomain.corp

    **O nome do dominio deve ser o mesmo do arquivo main.yaml do diretorio defaults do ansible**

### Configuração inicial: 

1. Baixar o ansible (rpm) para o servidor

2. Importante efetuar a copy das chaves do usuario root para os servidores para conectar via ssh.
    - No servidor do ansible
    `# ssh-keygen -f .ssh/kafka`
    - Copiar as chaves para os servidores do kafka
    `ssh-copy-id -i ~/.ssh/kafka.pub root@servidores` ou copiar o conteudo da chave e colar no arquivo do servidor destino, `/root/.ssh/authorized_keys`

3. O arquivo inventory, possui a lista dos brokers do client e scale_out 
    - Adicionar igual ao exemplo do arquivo.
    - **O padrão da POC contém 3 brokers com 1 partição: fator de replicação: 3 com o topicname: POC**
    - O scale_out foi um teste de como funciona o crescimento horizontal no kafka ingressando outras maquinas ao cluster, e possivel adicionar quantas máquinas quiser na lista, respeitando a ordem da tag myid para criar o auto scale da infra do zookeeper

4. Variaveis de execucao

    - Diretorio defauls, possui o arquivo com as variaveis criadas no ansible, o nome do dominio no inventario tem que ser o mesmo, o meu caso labdomain.corp

### Execução do testes:

1. Para executar o ansible executar o script shell com o nome `kafkainstall.sh`, rode sem opção que ele mostra as opções.

    Opções: 
        `sh kafkainstall.sh deploy` -> instala o kafka com certificado (servidores da lista do \[broker]\)
        `sh kafkainstall.sh remove` -> remove tudo (remove todos relacionado a zookeeper e a tibico)
        `sh kafkainstall.sh scale_out` -> cria uma outra instancia do kafka em outro servidor na lista do inventario \[scale_out\] 
        `sh kafkainstall.sh restart` -> systemctl restart zookeeper e kafka

    Se quiser um modo debug rodar o script e adicionar o -vv ou -vvv ao final do comando