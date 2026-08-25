#!/bin/bash

set -e
set -x

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

USERDATA_SOURCE="$SCRIPT_DIR/userdata"
USERDATA_FILE="$SCRIPT_DIR/userdata-local.yml"
USERDATA_FILE_ORIGINAL="$USERDATA_SOURCE"

cp -v "${USERDATA_FILE_ORIGINAL}" "${USERDATA_FILE}"

# Use local development domain.
sed -i -e '/package_upgrade/d' "${USERDATA_FILE}"
sed -i -e '/package_reboot_if_required/d' "${USERDATA_FILE}"
sed -i 's/^[[:space:]]*DOMAIN=.*/      DOMAIN=privatecaptcha-vagrant.local/' "${USERDATA_FILE}"
sed -i '/reverse_proxy 127\.0\.0\.1:8080/i\        tls internal' "${USERDATA_FILE}"

chmod og-w "$USERDATA_SOURCE"

