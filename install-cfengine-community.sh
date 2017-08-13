#!/bin/sh 


install_key() {
    wget -qO- https://cfengine-package-repos.s3.amazonaws.com/pub/gpg.key | apt-key add -
}


install_repo() {
    echo "deb https://cfengine-package-repos.s3.amazonaws.com/pub/apt/packages stable main" > /etc/apt/sources.list.d/cfengine-community.list
}


install_vim_files() {
    wget -O - https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/syntax/cf3.vim   > /usr/share/vim/vim74/syntax/cf3.vim
    chmod 0644 /usr/share/vim/vim74/syntax/cf3.vim

    wget -O - https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/ftplugin/cf3.vim > /usr/share/vim/vim74/ftplugin/cf3.vim
    chmod 0644 /usr/share/vim/vim74/ftplugin/cf3.vim
}


install_cfengine() {
    apt-get update
    LATEST_LTS=$(apt-cache show cfengine-community | grep ^Version:.3.10 | sort | cut -d' ' -f 2 | tail -n1)
    apt-get install cfengine-community=${LATEST_LTS}

    systemctl start cfengine3
}



install_key
install_repo
install_vim_files
install_cfengine


