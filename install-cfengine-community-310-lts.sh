#!/bin/sh 


install_key() {
    wget -qO- https://cfengine-package-repos.s3.amazonaws.com/pub/gpg.key | apt-key add -
}


install_apt() {
    apt-get install aptitude apt-transport-https 
}


install_repo() {
    echo "deb https://cfengine-package-repos.s3.amazonaws.com/pub/apt/packages stable main" > /etc/apt/sources.list.d/cfengine-community.list
}


install_vim_files() {
    vim_dir=$(find /usr/share/vim -type d -regex '/usr/share/vim/vim[0-9][0-9]$')

    if [ -d "$vim_dir" ]; then

        wget -O - https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/syntax/cf3.vim   > /usr/share/vim/$vim_dir/syntax/cf3.vim
        chmod 0644 /usr/share/vim/$vim_dir/syntax/cf3.vim

        wget -O - https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/ftplugin/cf3.vim > /usr/share/vim/vim80/$vim_dir/ftplugin/cf3.vim
        chmod 0644 /usr/share/vim/$vim_dir/ftplugin/cf3.vim
    fi 
}


install_cfengine() {
    apt-get update
    LATEST_LTS=$(apt-cache show cfengine-community | grep ^Version:.3.10 | sort | cut -d' ' -f 2 | tail -n1)
    apt-get install cfengine-community=${LATEST_LTS}

    systemctl stop cfengine3

    echo "RUN_CF_SERVERD=0"     >  /etc/default/cfengine3 
    echo "RUN_CF_EXECD=1"       >> /etc/default/cfengine3 
    echo "RUN_CF_MONITORD=1"    >> /etc/default/cfengine3 
    echo "RUN_CF_HUB=0"         >> /etc/default/cfengine3 

    systemctl start cfengine3
}



install_key
install_apt
install_repo
install_vim_files
install_cfengine


