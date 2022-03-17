#!/bin/bash

apt-get update && apt-get install rsyslog openssl vim htop -y

# Make sure service is running
service cron start
service rsyslog start

mkdir /var/log/haproxy/

# Touch the log file so we can tail on it
touch /var/log/haproxy/haproxy.log
touch /var/log/haproxy/ocsp.log

# Throw the log to output
tail -f /var/log/haproxy/haproxy.log &
tail -f /var/log/haproxy/ocsp.log &

# Start haproxy
exec /usr/local/sbin/haproxy -f /usr/local/etc/haproxy/haproxy.cfg
