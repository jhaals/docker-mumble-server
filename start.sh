#!/bin/bash
set -e
ruby2.0 /mumble.rb
/usr/bin/supervisord
