#!/bin/sh

exec /usr/lib/chromium/chrome-original --disable-gpu --no-sandbox --disable-dev-shm-usage "$@"