# Smartboard Control via ADB and scrcpy

A Bash script that connects to a compatible Android-based smartboard by IP address and opens its screen in a `scrcpy` window.

## Files

- `smartboard.sh` — connection script
- `README.md` — installation and usage instructions

## Requirements

Install these tools on the **computer running the script**:

- ADB (Android SDK Platform Tools)
- scrcpy
- Python 3
- Bash

### Ubuntu / Debian Linux

```bash
sudo apt update
sudo apt install adb scrcpy python3
```

If `scrcpy` is unavailable or the packaged version is outdated, follow the installation instructions in the official scrcpy repository: https://github.com/Genymobile/scrcpy

### Windows

This is a Bash script. You can run it in Git Bash or WSL, but ADB, scrcpy, and Python 3 must be installed and available in that environment's `PATH`. Display/device access under WSL may require extra setup. For a Windows-native workflow, use the Windows versions of ADB and scrcpy with a PowerShell script instead.

## Smartboard requirements

The smartboard must support ADB over TCP and have it enabled/authorized. This script assumes the device listens on **TCP port 5555**. Some smartboards require initial USB authorization, use a different wireless-debugging port, or disable ADB access, so this method will not work on every model.

Keep ADB restricted to trusted networks. Do not expose the ADB port to the public internet.

## How to use

1. Download `smartboard.sh`.
2. Open a terminal in the folder containing the file.
3. Make it executable:

   ```bash
   chmod +x smartboard.sh
   ```

4. Run it:

   ```bash
   ./smartboard.sh
   ```

5. Enter the smartboard's local IPv4 address when prompted, for example `192.168.1.50`.
6. If the connection succeeds, scrcpy opens a separate window with the smartboard screen.

Use the actual IP address shown in the smartboard's network settings. The example address is only illustrative.

## Troubleshooting

- **Connection refused / failed to connect:** Verify the IP address and whether ADB-over-TCP is enabled on port 5555.
- **Unauthorized:** Complete the device authorization process, if the smartboard supports it.
- **Offline:** Check the network and ADB status.
- **Command not found:** Install the missing tool and ensure it is in `PATH`.
- **The smartboard does not support ADB:** This script cannot enable unsupported access; check the manufacturer's supported remote-control options.

## Security and scope

Use this script only with devices you own or are authorized to administer. ADB can provide powerful device access. This script connects to a compatible device and launches scrcpy; it does not turn the script into a website or remove the need to install tools on the computer.

## Disclaimer

This is a community utility and is not affiliated with Google, Android, or any smartboard manufacturer.
