Instalacao do kafka tibco via ansible

kafka1
kafka2
kafka3


para a POC.


hosts - arquivo de inventario que contem a lista dos servidores do broker (kafka) e o client

para gerar o producer via SSL, foi configurado o client sendo o primeiro servidor do kafka, entao o teste usando o utilitario do kafka pode ser \
realizado por este server, sendo assim no deploy carrego o arquivo client.properties para o diretorio config do kafka
* nao e um problema mudar o servidor client, apenas nao sera configurado o TLS com a referencia dos brokers e isso impede o teste partindo dele via SSL
    Pode tambem gerar manualmente o certificado.

No caso do consumer pode ser feito os outros servers a fim de validar a configuracao.

kafkainstall.sh - script com as opcoes de configuracao (deploy ja com ssl nos brokers contidos na lista do arquivo hosts)
    executando o script sem parametro ele retorma um help com as informacoes

-----

Caso queira usar o ansible, a automacao possui etapas validadas para parar o deploy, configurar os brokers com SSL, efetuar os testes iniciais no zookeeper
ja configurado com jmx e plugin para o prometheus, a ref : - mostra os passos para configurar o prometheus afim de monitorar a jvm e tambem o respectivo server.


O ansible possui o diretorio defaults e nele o arquivo main.yaml com as variaveis setadas para o deploy, e possivel configurar a particao, replicacao e o nome do topico.

Importante que o etc/hosts dos servidores estejam configurados a automacao foi feita com o nome 
    kafka1.labdomain.corp
    kafka2.labdomain.corp
    kafka3.labdomain.corp

lembrar de setar o hostname para tudo funcionar.

o comando hostnamectl set-hostname kafka1.labdomain.corp
