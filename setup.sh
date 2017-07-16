#!/bin/bash
# -----------------------------------------------------------------------------
# -- Ubuntu Install Script
# --
# -- @author Pablo Viquez
# --
# -- https://raw.githubusercontent.com/pabloviquez/vagrant/master/setup.sh
# -----------------------------------------------------------------------------

AVAILABLE_BRANCH=(
  "php56_apache_xenial"
  "php7x_xenial"
)

VERSION="2.3.8"
TARGET_OS="xenial"
TARGET_PHP="5.6"
TARGET_HTTP_SERVER="Apache 2.4"
TARGET_BRANCH=${AVAILABLE_BRANCH[0]}

echo "------------------------------------------------------------------------------"
echo "--"
echo "-- Ubuntu Provision Script"
echo "--"
echo "-- Specs:"
echo "--     OS         : ${TARGET_OS}"
echo "--     PHP        : ${TARGET_PHP}"
echo "--     Web Server : ${TARGET_HTTP_SERVER}"
echo "--"
echo "-- Repo Branch: ${TARGET_BRANCH}"
echo "--"
echo "-- @author Pablo Viquez <pviquez@pabloviquez.com>"
echo "-- @version ${VERSION}"
echo "------------------------------------------------------------------------------"
echo ""

if [ ! -d ~/provision ]; then
  echo ""
  echo ""
  echo ""
  echo "Initializing..."
  apt-get update
  apt-get install -y -V git
  ssh -oStrictHostKeyChecking=no -T git@github.com
fi

echo "Cloning remote provisioning"
rm -Rf ~/provision
# git clone https://github.com/pabloviquez/vagrant.git ~/provision
git clone --branch ${TARGET_BRANCH} https://github.com/pabloviquez/vagrant.git ~/provision

if [ -d ~/provision ]; then
  echo "Setting up dependencies"
  cd ~/provision
  source base/install.sh
  source php/install.sh
  source apache/install.sh
  source mysql/install.sh
else
  echo "Unable to setup the machine. Provision directory not found"
fi