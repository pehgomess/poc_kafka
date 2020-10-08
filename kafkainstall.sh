#!/bin/bash

provisioning=roles/deploy_kafkatibco/provisioning.yaml

case $1 in
    deploy) 
	    ansible-playbook -i inventory ${provisioning} --extra-vars "test_plan=init" $2
    ;;
    remove)
        ansible-playbook -i inventory ${provisioning} --extra-vars "test_plan=remove" $2
    ;;
    scale_out)
        ansible-playbook -i inventory ${provisioning} --extra-vars "test_plan=scale_out" $2 && 
        echo "Executar o sh $0 restart para as configuracoes entrarem em vigor"
    ;;
    restart)
        ansible-playbook -i inventory ${provisioning} --extra-vars "test_plan=restart-all" $2
    ;;
    *)
        echo "sh $0 deploy -> instala o kafka com certificado"
        echo "sh $0 remove -> remove tudo"
        echo "sh $0 scale_out -> cria uma outra instancia do kafka em outro servidor na lista do inventario [scale_out] "
        echo "sh $0 restart -> systemctl restart zookeeper e kafka"
    ;;
esac
