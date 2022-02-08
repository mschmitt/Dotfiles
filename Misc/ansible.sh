#!/usr/bin/env bash

### pip3 install crudini / apt-get install crudini
if type crudini >/dev/null 2>&1
then
	crudini --set ~/.ansible.cfg defaults interpreter_python auto_silent
	crudini --set ~/.ansible.cfg defaults deprecation_warnings false
fi

