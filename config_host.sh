#!/bin/bash

if ! grep -q ${DOMAIN_NAME} "/etc/hosts"; then
	echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts
fi

sed -i "s/login/${LOGIN}/g" srcs/.env
