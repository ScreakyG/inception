#!/bin/bash

echo "[INFO] Hello this is Wordpress setup script.."

mkdir /run/php
/usr/sbin/php-fpm7.4 -F
