#!/bin/sh

for ip in $(dig in a $1 +short); do whois $ip | grep OrgName; done
