#!/bin/bash

provisioning=roles/deploy_kafkatibco/provisioning.yaml
basedir=roles/deploy_kafkatibco/tasks
case $1 in
    deploy) 
        #ansible-playbook -i hosts ${provisioning} --extra-vars "test_plan=${basedir}/initial" $2
	ansible-playbook -i hosts ${provisioning} --extra-vars "test_plan=init" $2
    ;;
    remove)
        ansible-playbook -i hosts ${provisioning} --extra-vars "test_plan=remove" $2
    ;;
    *)
        echo "sh $0 deploy -> instala o kafka com certificado"
        echo "sh $0 remove -> remove tudo"
    ;;
esac
