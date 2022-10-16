#!/bin/sh

# https://github.com/kunokdev/cra-runtime-environment-variables

# line endings must be \n, not \r\n !
echo "window._env = {" > ./env.js
awk -F '=' '{ print $1 ": \"" (ENVIRON[$1] ? ENVIRON[$1] : $2) "\"," }' ./.env >> ./env.js
echo "}" >> ./env.js
