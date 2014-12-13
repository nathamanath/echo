#!/bin/bash

bundle exec puma -e production -d -b unix:///app/tmp/sockets/puma.sock
/usr/sbin/nginx

