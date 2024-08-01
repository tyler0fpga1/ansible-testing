#!/bin/bash
echo
if [ "$EUID" -ne 0 ];then
	echo "Run as root or sudo."
	exit 1
fi
#Obtain OS information using either lsb_release or /etc/os-release
if ( type lsb_release &> /dev/null ); then
	OS=$(lsb_release -is)
	if [[ $OS =~ "RedHat" ]]; 	then OS="rhel"; fi
	if [[ $OS =~ "Oracle" ]]; 	then OS="ol"; fi
	if [[ $OS =~ "Ubuntu" ]]; 	then OS="ub"; fi
	if [[ $OS =~ "Debian" ]]; 	then OS="deb"; fi
	if [[ $OS =~ "Manjaro" ]];	then OS="aur"; fi
	if [[ $OS =~ "Arch" ]];		then OS="aur"; fi
	OS_V=$(lsb_release -rs | cut -f1 -d.)
	echo "Found OS: $OS"
elif [ -f /etc/os-release ]; then
	source /etc/os-release
	OS=$ID
	OS_V=$(echo $VERSION_ID | cut -f1 -d.)
else
	echo "Installation Exited: Unable to obtain OS information."
	exit 1
fi


#Set package manager
if type -p dnf  > /dev/null; then
	PKG_EXE="dnf -y install"
	echo "found PKG-MGR: DNF"
elif type -p yum > /dev/null; then
	PKG_EXE="yum -y install"
	echo "found PKG-MGR: YUM"
elif type -p apt > /dev/null; then
	PKG_EXE="apt -y install"
	echo "found PKG-MGR: APT"
elif type -p pacman > /dev/null; then
	PKG_EXE="pacman -Sy --noconfirm"
	echo "found PKG-MGR: PACMAN"
else
	echo "Unable to find package your manager."
fi


#Install Packages
echo "Updating system packages ..."
#eval $INSTALL_CMDS
if [[ !($OS =~ "aur") ]]; then
	$PKG_EXE -q update
	#$PKG_EXE = $PKG_EXE + " install "
else 
	pacman -Syyu
	#$PKG_EXE = $PKG_EXE
fi
clear
echo "Installing unzip"
$PKG_EXE unzip
echo "Installing UFW"
$PKG_EXE ufw
echo "Installing fonts"
$PKG_EXE dejavu-serif-fonts
echo "Installing python"
$PKG_EXE python3
echo "Installing Ansible"
$PKG_EXE ansible ansible-core ansible-galaxy





#! EOF
