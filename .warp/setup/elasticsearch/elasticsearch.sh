#!/bin/bash +x

warp_message_info "Configurando Servicio de ElasticSearch"

respuesta=$( warp_question_ask_default "Queres agregar un servicio de elasticsearch? $(warp_message_info [Y/n]) " "Y" )
if [ "$respuesta" = "Y" ] || [ "$respuesta" = "y" ]
then
    
    while : ; do
        elasticsearch_version=$( warp_question_ask_default "Cual es la version de elasticsearch del proyecto? $(warp_message_info [5.6.8]) " "5.6.8" )
    
        case $elasticsearch_version in
        '5.6.8')
            break
        ;;
        '2.4.4')
            break
        ;;
        '2.4.6')
            break
        ;;
        *)
            warp_message_info2 "Seleccionaste: $elasticsearch_version, las versiones disponibles son 5.6.8, 2.4.4, 2.4.6"
        ;;
        esac        
    done
    warp_message_info2 "Version de elasticsearch seleccionada: $elasticsearch_version, en los puertos internos 9200, 9300 $(warp_message_bold 'elasticsearch:9200, elasticsearch:9300')"
    
    cat $PROJECTPATH/.warp/setup/elasticsearch/tpl/elasticsearch.yml >> $PROJECTPATH/docker-compose.yml

    echo ""  >> $PROJECTPATH/.env
    echo "# Elasticsearch" >> $PROJECTPATH/.env
    echo "ES_VERSION=$elasticsearch_version" >> $PROJECTPATH/.env

fi; 
