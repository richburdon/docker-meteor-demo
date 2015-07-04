#!/bin/sh
# NOTE: This first line is necessary.

set -e

echo "Starting..."
cd app
pwd
/usr/local/bin/meteor
echo "OK"
