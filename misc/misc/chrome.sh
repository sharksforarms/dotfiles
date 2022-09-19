#!/bin/bash

PROFILE_DIR="/tmp/chrome-profile$(date +%s)"
# IP=""

SSLKEYLOGFILE=/tmp/sslkeylog google-chrome \
    --no-default-browser-check \
    --no-first-run \
    --enable-quic \
    --quic-version=h3 \
    --origin-to-force-quic-on=localhost:443 \
    --user-data-dir=$PROFILE_DIR \
    --disable-application-cache \
    https://localhost:443
    #--host-resolver-rules="MAP hostname:443 $IP:443" \

rm -rf $PROFILE_DIR
