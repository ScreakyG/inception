#!/bin/bash

if [ ! -z "$DOMAIN_NAME" ]; then
    sudo sed -i "/127.0.0.1 ${DOMAIN}/d" /etc/hosts
fi

sed -i "s/${LOGIN}/login/g" srcs/.env
sed -i "s/${LOGIN}/login/g" Makefile
