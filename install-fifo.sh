#!/bin/sh 

#
# install fifo on smartos
#

ZONE_UUID=""
MAX_PHYS_MEM=""
IP_ADDRESS=""
GATEWAY=""
NETMASK=""

msg() {
    echo "$1"
}


die() {
    echo "$1" >&2
    exit 1
}


check_prereqs() {
    which wget      >/dev/null 2>&1 || die "FATAL: unable to find wget in \$PATH"    
    which apt-get   >/dev/null 2>&1 || die "FATAL: unable to find apt-get in \$PATH"
    which systemctl >/dev/null 2>&1 || die "FATAL: unable to find systemctl in \$PATH"
}


handle_error() {
    if [ $1 -ne 0 ]; then 
        die "FATAL: error during $2 (retval=$1)" 
    else
        msg "INFO: completed $2"
    fi 
}


# 1. Dataset import
import_image() {
    imgadm update
    imgadm import e1faace4-e19b-11e5-928b-83849e2fd94a
    imgadm list | grep e1faace4-e19b-11e5-928b-83849e2fd94a
}


# 2. Zone creation 
zone_creation() {
	echo "{"                                       >  /opt/setupfifo.json
	echo " \"autoboot\": true,"                    >> /opt/setupfifo.json
	echo " \"brand\": \"joyent\","                 >> /opt/setupfifo.json
	echo " \"image_uuid\": \"<zone uuid>\","       >> /opt/setupfifo.json
	echo " \"delegate_dataset\": true,"            >> /opt/setupfifo.json
	echo " \"indestructible_delegated\": true,"    >> /opt/setupfifo.json
	echo " \"max_physical_memory\": 3072,"         >> /opt/setupfifo.json
	echo " \"cpu_cap\": 100,"                      >> /opt/setupfifo.json
	echo " \"alias\": \"fifo\","                   >> /opt/setupfifo.json
	echo " \"quota\": \"40\","                     >> /opt/setupfifo.json
	echo " \"resolvers\": ["                       >> /opt/setupfifo.json
	echo "  \"8.8.8.8\","                          >> /opt/setupfifo.json
	echo "  \"8.8.4.4\""                           >> /opt/setupfifo.json
	echo " ],"                                     >> /opt/setupfifo.json
	echo " \"nics\": ["                            >> /opt/setupfifo.json
	echo "  {"                                     >> /opt/setupfifo.json
	echo "   \"interface\": \"net0\","             >> /opt/setupfifo.json
	echo "   \"nic_tag\": \"admin\","              >> /opt/setupfifo.json
	echo "   \"ip\": \"10.1.1.240\","              >> /opt/setupfifo.json
	echo "   \"gateway\": \"10.1.1.1\","           >> /opt/setupfifo.json
	echo "   \"netmask\": \"255.255.255.0\""       >> /opt/setupfifo.json
	echo "  }"                                     >> /opt/setupfifo.json
	echo " ]"                                      >> /opt/setupfifo.json
	echo "}"                                       >> /opt/setupfifo.json

	cd /opt
	vmadm create -f setupfifo.json
}


# 3. FiFo Packages Install
fifo_packages_install() {
	zlogin <fifo-vm-uuid>
	zfs set mountpoint=/data zones/$(zonename)/data
	

}


install_fifo_key() {
	cd /data
	curl -O https://project-fifo.net/fifo.gpg
	gpg --primary-keyring /opt/local/etc/gnupg/pkgsrc.gpg --import < fifo.gpg
	gpg --keyring /opt/local/etc/gnupg/pkgsrc.gpg --fingerprint
}


install_packages() {
	echo "http://release.project-fifo.net/pkg/15.4.1/rel" >> /opt/local/etc/pkgin/repositories.conf
	pkgin -fy up
	pkgin install fifo-snarl fifo-sniffle fifo-howl fifo-cerberus
}


# 4. Configuring fifo services
service_startup() {
	svcadm enable epmd
	svcadm enable snarl
	svcadm enable sniffle
	svcadm enable howl
	svcs epmd snarl sniffle howl
}

initial_admin_tasks() {
	# snarl-admin 	init <realm> <org> <role> <user> <pass>
 	snarl-admin 	init default MyOrg Users  admin  admin
}



# 5. LeoFS initialization
## FIXME


init_leo() {
	sniffle-admin init-leofs 10.1.1.21.xip.io
}

# Chunter install 
# FIXME


# 6. Configure fifo
# Web console ... 













check_prereqs




















