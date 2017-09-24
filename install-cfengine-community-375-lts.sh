#!/bin/sh 


msg() {
    echo "$1"
}


die() {
    echo "$1" >&2
    exit 1
}


check_prereqs() {
    which wget >/dev/null 2>&1 || die "FATAL: unable to find wget in \$PATH"    
    apt-get    >/dev/null 2>&1 || die "FATAL: unable to find apt-get in \$PATH"
    systemctl  >/dev/null 2>&1 || die "FATAL: unable to find systemctl in \$PATH"
}


handle_error() {
    if [ $1 -ne 0 ]; then 
        die "FATAL: error during $2 (retval=$1)" 
    else
        msg "INFO: completed $2"
    fi 
}


install_packages() {
    apt-get --no-install-recommends --assume-yes install apt-transport-https python >/dev/null 2>&1
    handle_error $? "installation of: apt-transport-https python"

}


install_vim() {
    apt-get --no-install-recommends --assume-yes install vim >/dev/null 2>&1
    handle_error $? "installation of: vim"

    vim_dir=$(find /usr/share/vim -type d -regex '/usr/share/vim/vim[0-9][0-9]$')

    if [ -d "$vim_dir" ]; then

        wget -O $vim_dir/syntax/cf3.vim https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/syntax/cf3.vim  >/dev/null 2>&1
        handle_error $? "installation of syntax file for cfengine3"
        chmod 0644 $vim_dir/syntax/cf3.vim

        wget -O $vim_dir/ftplugin/cf3.vim https://raw.githubusercontent.com/neilhwatson/vim_cf3/master/ftplugin/cf3.vim >/dev/null 2>&1
        handle_error $? "installation of ftplugin for cfengine3"
        chmod 0644 $vim_dir/ftplugin/cf3.vim >/dev/null 2>&1
    fi 
}


install_cfengine() {
    wget -qO- https://cfengine-package-repos.s3.amazonaws.com/pub/gpg.key | apt-key add -
    handle_error $? "attempt to add cfengine package signing key"

    echo "deb https://cfengine-package-repos.s3.amazonaws.com/pub/apt/packages stable main" > /etc/apt/sources.list.d/cfengine-community.list

    apt-get update >/dev/null 2>&1
    handle_error $? "update of local package cache"

    LATEST_LTS=$(apt-cache show cfengine-community | grep ^Version:.3.7 | sort | cut -d' ' -f 2 | tail -n1)
    apt-get --no-install-recommends --assume-yes install cfengine-community=${LATEST_LTS} >/dev/null 2>&1
    handle_error $? "installation of: cfengine-community=${LATEST_LTS}"

    systemctl stop cfengine3 >/dev/null 2>&1
    handle_error $? "stopping of service cfengine3"

    echo "RUN_CF_SERVERD=1"     >  /etc/default/cfengine3 
    echo "RUN_CF_EXECD=1"       >> /etc/default/cfengine3 
    echo "RUN_CF_MONITORD=1"    >> /etc/default/cfengine3 
    echo "RUN_CF_HUB=0"         >> /etc/default/cfengine3 

    systemctl start cfengine3 >/dev/null 2>&1
    handle_error $? "start of service cfengine3"
}


check_prereqs
install_packages
install_vim
#install_cfengine


