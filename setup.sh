#!/bin/bash

service mysql start
mysql -u root -proot /setup.sh
service mysql stop
