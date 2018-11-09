#!/bin/bash
/etc/init.d/rsyslog start
/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -db
