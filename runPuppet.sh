#!/bin/sh
puppet apply --modulepath /etc/puppet/modules/:/etc/puppet/code/modules/ /etc/puppet/manifests/site.pp
