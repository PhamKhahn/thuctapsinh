#!/bin/bash
yum install -y epel-release zlib-devel pcre2-devel make gcc mysql-devel postgresql-devel sqlite-devel
yum install -y wget
wget -q -O - https://updates.atomicorp.com/installers/atomic | sh
yum install -y ossec-hids ossec-hids-server
