#!/bin/bash +x

while : ; do
    client_code=$( warp_question_ask "Client Code, it should be in lowercase and only letters, for example 'Summa Solutions' should be 'summa': " )

    if [[ $client_code =~ ^[a-z]{2,}$ ]] ; then
        warp_message_info2 "The client code is: $(warp_message_bold $client_code)"
        break
    else
        warp_message_warn "incorrect value, please enter only letters and lowercase\n"
    fi;
done


while : ; do
    project_code=$( warp_question_ask "Project Code, it should be in lowercase and only letters, for example 'WARP Engine' should be 'warp': " )

    if [[ $project_code =~ ^[a-z]{2,}$ ]] ; then
        warp_message_info2 "The project code is: $(warp_message_bold $project_code)"
        break
    else
        warp_message_warn "incorrect value, please enter only letters and lowercase\n"
    fi;
done

echo "# Project configurations" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "CLIENT_CODE=${client_code}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "PROJECT_CODE=${project_code}" >> $ENVIRONMENTVARIABLESFILESAMPLE
echo "" >> $ENVIRONMENTVARIABLESFILESAMPLE