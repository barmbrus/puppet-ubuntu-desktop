#!/bin/bash
apt-get update
apt-get -y install puppet vim vim-puppet
puppet module install puppetlabs-apt
puppet module install puppetlabs-firewall
# Ubuntu Snap Repos
puppet module install kemra102/snapd

