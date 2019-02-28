#!/bin/bash
# Interpreter identifier

set -e
# Exit on fail

rm -f /jarvis/tmp/pids/server.pid

echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p

rm -f config/database.yml && cp config/database.sample.yml config/database.yml

bundle check || bundle install --binstubs="$BUNDLE_BIN"
# Ensure all gems installed. Add binstubs to bin which has been added to PATH in Dockerfile.

yarn install

exec "$@"
# Finally call command issued to the docker service