#!/bin/bash +x

while : ; do
    namespace_name=$( warp_question_ask "Namespace name, it should be in lowercase and only letters, for example 'Starfleet' should be 'starfleet': " )

    if [[ $namespace_name =~ ^[a-z]{2,}$ ]] ; then
        warp_message_info2 "The namespace name: $(warp_message_bold $namespace_name)"
        break
    else
        warp_message_warn "incorrect value, please enter only letters and lowercase\n"
    fi;
done


while : ; do
    project_name=$( warp_question_ask "Project Name, it should be in lowercase and only letters, for example 'WARP Engine' should be 'warp': " )

    if [[ $project_name =~ ^[a-z]{2,}$ ]] ; then
        warp_message_info2 "The project name is: $(warp_message_bold $project_name)"
        break
    else
        warp_message_warn "incorrect value, please enter only letters and lowercase\n"
    fi;
done

while : ; do
    framework=$( warp_question_ask_default "Framework, possible values are 'm1', 'm2' and 'oro': " "m2" )

    case $framework in
        'm1')
            break
        ;;
        'm2')
            break
        ;;
        'oro')
            break
        ;;
        *)
            warp_message_info2 "Selected: $framework, the available options are m1, m2 and oro"
        ;;
    esac
done

while : ; do
    docker_private_registry=$( warp_question_ask "Docker Private Registy (optional): " )

    if [ ! -z "$docker_private_registry" ] ; then
        warp_message_info2 "The docker private registry is: $(warp_message_bold $docker_private_registry)"
        break
    else
        warp_message_info2 "No docker private regitry entered\n"
    fi;
done

#echo "# Project configurations" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "NAMESPACE=${namespace_name}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "PROJECT=${project_name}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "FRAMEWORK=${framework}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "DOCKER_PRIVATE_REGISTRY=${docker_private_registry}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE