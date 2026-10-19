#!/usr/bin/env bash
set -Eeuo pipefail

# Smartboard Control via ADB + scrcpy
# Requires: adb, scrcpy, python3
# Assumes the smartboard's ADB-over-TCP endpoint is available on port 5555.

PORT=5555

for cmd in adb scrcpy python3; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: '$cmd' is not installed or is not available in PATH."
    echo "Install ADB (Android Platform Tools), scrcpy, and Python 3, then try again."
    exit 1
  fi
done

read -r -p "Enter smartboard IP address: " IP

if ! python3 - "$IP" <<'PY'
import ipaddress
import sys

try:
    address = ipaddress.ip_address(sys.argv[1])
    if address.version != 4 or not address.is_private:
        raise ValueError
except ValueError:
    print("Error: enter a valid private IPv4 address, such as 192.168.1.50.")
    sys.exit(1)
PY
then
  exit 1
fi

TARGET="${IP}:${PORT}"

echo "Connecting to ${TARGET}..."
if ! adb connect "$TARGET"; then
  echo "Error: ADB could not connect. Check the IP, network, and ADB settings."
  exit 1
fi

# Confirm that ADB reports this exact target as online.
if ! adb devices | awk -v target="$TARGET" '$1 == target && $2 == "device" { found=1 } END { exit !found }'; then
  echo "Error: ${TARGET} is not online/authorized in ADB."
  echo "Check that network debugging is enabled and any authorization prompt is accepted."
  exit 1
fi

echo "Connected. Launching scrcpy..."
exec scrcpy --serial "$TARGET"
