#!/bin/bash

    # IMPORT HELP

    . "$PROJECTPATH/.warp/bin/reset_help.sh"

function reset_project() 
{

    if [ "$1" = "-h" ] || [ "$1" = "--help" ] ; then
        
        reset_help_usage
        exit 1
    fi

    if [ $(warp_check_is_running) = true ]; then
        warp_message_warn "the containers is running";
        warp_message_warn "Please run first warp stop";
        exit 1;
    fi

    if [ "$1" = "--hard" ] ; then
        # reset files TL
        reset_warninig_confirm_hard
    else
        # reset files DEV
        reset_warninig_confirm
    fi;
}

function reset_warninig_confirm_hard()
{
    reset_msj_delete_all=$( warp_question_ask_default "Do you want to delete all project settings? $(warp_message_info [y/N]) " "N" )
    if [ "$reset_msj_delete_all" = "Y" ] || [ "$reset_msj_delete_all" = "y" ]
    then
        confirm_msj_delete_all=$( warp_question_ask_default "$(warp_message_warn 'If you go ahead you must reconfigure the entire project, do you want to continue?') $(warp_message_info [y/N]) " "N" )
        if [ "$confirm_msj_delete_all" = "Y" ] || [ "$confirm_msj_delete_all" = "y" ]
        then
            warp_message "* deleting $(basename $ENVIRONMENTVARIABLESFILE) $(warp_message_ok [ok])"
            warp_message "* deleting $(basename $ENVIRONMENTVARIABLESFILESAMPLE) $(warp_message_ok [ok])"
            warp_message "* deleting $(basename $DOCKERCOMPOSEFILE) $(warp_message_ok [ok])"
            warp_message "* deleting $(basename $DOCKERCOMPOSEFILESAMPLE) $(warp_message_ok [ok])"
            warp_message "* deleting $(basename $DOCKERCOMPOSEFILEMAC) $(warp_message_ok [ok])"
            warp_message "* deleting $(basename $DOCKERSYNCMAC) $(warp_message_ok [ok])"
            
            case "$(uname -s)" in
            Darwin)
                # clean data sync
                docker-sync clean
            ;;
            esac

            rm $ENVIRONMENTVARIABLESFILE 2> /dev/null
            rm $ENVIRONMENTVARIABLESFILESAMPLE 2> /dev/null
            rm $DOCKERCOMPOSEFILE 2> /dev/null
            rm $DOCKERCOMPOSEFILESAMPLE 2> /dev/null
            rm $DOCKERCOMPOSEFILEMAC 2> /dev/null
            rm $DOCKERSYNCMAC 2> /dev/null

	        rm -rf $PROJECTPATH/.warp/docker/config 2> /dev/null
            mkdir -p $PROJECTPATH/.warp/docker/config 2> /dev/null
            touch $PROJECTPATH/.warp/docker/config/.empty 2> /dev/null

            warp_message ""

            warp_message_warn "files have been deleted, to start again run: $(warp_message_bold './warp init')"
            warp_message ""
        else
            warp_message_warn "* aborting elimination"    
        fi

    fi
}

function reset_warninig_confirm()
{
    reset_msj_delete=$( warp_question_ask_default "Do you want to delete the settings? $(warp_message_info [y/N]) " "N" )
    if [ "$reset_msj_delete" = "Y" ] || [ "$reset_msj_delete" = "y" ]
    then
        warp_message "* deleting $(basename $ENVIRONMENTVARIABLESFILE) $(warp_message_ok [ok])"
        warp_message "* deleting $(basename $DOCKERCOMPOSEFILE) $(warp_message_ok [ok])"

        rm $ENVIRONMENTVARIABLESFILE 2> /dev/null
        rm $DOCKERCOMPOSEFILE 2> /dev/null
        warp_message ""

        warp_message_warn "files have been deleted, to start again run: $(warp_message_bold './warp init')"
        warp_message ""
    fi
}

function reset_main()
{
    case "$1" in
        reset)
            shift 1
            reset_project $*
        ;;

        -h | --help)
            reset_help_usage
        ;;

        *)            
            reset_help_usage
        ;;
    esac
}
