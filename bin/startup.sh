#!/bin/bash

bundle exec puma -e production -d -b unix:///app/tmp/puma.sock
/usr/sbin/nginx

