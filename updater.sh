#!/bin/bash

set -vex;

/bin/echo url="https://www.duckdns.org/update?domains=$DOMAIN&token=$TOKEN&ip=" | /usr/bin/curl -k -K -
