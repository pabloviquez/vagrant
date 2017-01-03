#!/bin/bash
# -----------------------------------------------------------------------------
# -- Ubuntu Install Script
# --
# -- @author Pablo Viquez
# --
# -- https://raw.githubusercontent.com/pabloviquez/vagrant/master/setup.sh
# -----------------------------------------------------------------------------

echo "------------------------------------------------------------------------------"
echo "--"
echo "-- Ubuntu Provision Script"
echo "--"
echo "-- @author Pablo Viquez <pviquez@pabloviquez.com>"
echo "-- @version 2.1.0"
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
git clone --branch php7x https://github.com/pabloviquez/vagrant.git ~/provision

if [ -d ~/provision ]; then
  echo "Setting up dependencies"
  cd ~/provision
  source base/install.sh
  source nginx/install.sh
  source php/install.sh
  source mysql/install.sh
else
  echo "Unable to setup the machine. Provision directory not found"
fi