#!/bin/bash +x

echo ""
warp_message_info "Configurando Servicio de ElasticSearch"

while : ; do
    respuesta_es=$( warp_question_ask_default "Queres agregar un servicio de elasticsearch? $(warp_message_info [Y/n]) " "Y" )
    if [ "$respuesta_es" = "Y" ] || [ "$respuesta_es" = "y" ] || [ "$respuesta_es" = "N" ] || [ "$respuesta_es" = "n" ] ; then
        break
    else
        warp_message_warn "Respuesta Incorrecta, debe seleccionar entre dos opciones: $(warp_message_info [Y/n]) "
    fi
done

if [ "$respuesta_es" = "Y" ] || [ "$respuesta_es" = "y" ]
then
    warp_message_info2 "Podes chequear las versiones de elasticsearch disponibles acá: $(warp_message_info '[ https://hub.docker.com/r/summasolutions/elasticsearch/tags/ ]')"
    
    while : ; do
        elasticsearch_version=$( warp_question_ask_default "Cual es la version de elasticsearch del proyecto? $(warp_message_info [5.6.8]) " "5.6.8" )
    
        case $elasticsearch_version in
        '6.4.2')
            break
        ;;
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
            warp_message_info2 "Seleccionaste: $elasticsearch_version, las versiones disponibles son 6.4.2, 5.6.8, 2.4.4, 2.4.6"
        ;;
        esac        
    done
    warp_message_info2 "Version de elasticsearch seleccionada: $elasticsearch_version, en los puertos internos 9200, 9300 $(warp_message_bold 'elasticsearch:9200, elasticsearch:9300')"
    
    cat $PROJECTPATH/.warp/setup/elasticsearch/tpl/elasticsearch.yml >> $DOCKERCOMPOSEFILESAMPLE

    echo ""  >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "# Elasticsearch" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo "ES_VERSION=$elasticsearch_version" >> $ENVIRONMENTVARIABLESFILESAMPLE
    echo ""  >> $ENVIRONMENTVARIABLESFILESAMPLE

fi; 
