#!/bin/bash
#
# Nektony Python 3 uninstaller for macOS
# https://nektony.com/how-to/uninstall-python-on-mac
#
# What it does:
# - Detects active Python 3.x version
# - Removes app bundle + framework + symlinks
# - Cleans receipts (.bom, .plist) in /private/var/db/receipts
# - Removes /private/var/folders org.python.* cache folders
# - Removes ~/Library/Python user packages
# - Cleans __pycache__ folders and .pyc files recursively
# - Removes Recent Documents reference
#
# Tested on: macOS Sequoia 15.5, Tahoe 26.4.1"]
# License: MIT
#
# Acknowledgement: Inspired by Charles Severance's uninstall-python3
# (https://github.com/csev/uninstall-python3) — extended with deep cleanup logic
# that covers receipts, system cache folders, user packages, and bytecode artefacts.
#
# Copyright (c) 2026 Nektony

# Detect installed Python 3 version (e.g. 3.13)
PYTHON_VERSION=$(ls /Library/Frameworks/Python.framework/Versions/ | grep -E '^3\.[0-9]+$' | sort -V | tail -n 1)

if [[ -z "$PYTHON_VERSION" ]]; then
  echo "No Python 3.x version found in /Library/Frameworks/Python.framework/Versions/"
  exit 1
fi

echo "Detected Python version: $PYTHON_VERSION"

echo "Uninstalling Python $PYTHON_VERSION..."

# Remove main application
sudo rm -rf "/Applications/Python $PYTHON_VERSION"

# Remove framework version
sudo rm -rf "/Library/Frameworks/Python.framework/Versions/$PYTHON_VERSION"

# Remove symlinks related to Python version
if [[ -d /usr/local/bin ]]; then
  cd /usr/local/bin && ls -l | grep "../Library/Frameworks/Python.framework/Versions/$PYTHON_VERSION" | awk '{print $9}' | xargs sudo rm -f
fi

# Remove known binary links (generic)
sudo rm -f /usr/local/bin/idle3
sudo rm -f /usr/local/bin/pip3
sudo rm -f /usr/local/bin/pydoc3
sudo rm -f /usr/local/bin/python3
sudo rm -f /usr/local/bin/python3-config

# Optionally remove the full framework if no other versions exist
if [[ $(ls /Library/Frameworks/Python.framework/Versions/ | grep -E '^3\.[0-9]+$' | wc -l) -eq 0 ]]; then
  echo "No other Python 3 versions found. Removing full Python.framework..."
  sudo rm -rf /Library/Frameworks/Python.framework
fi

# Remove recent documents record
sudo rm -f "$HOME/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.python.pythonlauncher.sfl3"

# Remove receipts
sudo rm -f /private/var/db/receipts/org.python.Python.PythonApplications-${PYTHON_VERSION}.bom
sudo rm -f /private/var/db/receipts/org.python.Python.PythonApplications-${PYTHON_VERSION}.plist
sudo rm -f /private/var/db/receipts/org.python.Python.PythonDocumentation-${PYTHON_VERSION}.bom
sudo rm -f /private/var/db/receipts/org.python.Python.PythonDocumentation-${PYTHON_VERSION}.plist
sudo rm -f /private/var/db/receipts/org.python.Python.PythonFramework-${PYTHON_VERSION}.bom
sudo rm -f /private/var/db/receipts/org.python.Python.PythonFramework-${PYTHON_VERSION}.plist
sudo rm -f /private/var/db/receipts/org.python.Python.PythonUnixTools-${PYTHON_VERSION}.bom
sudo rm -f /private/var/db/receipts/org.python.Python.PythonUnixTools-${PYTHON_VERSION}.plist

# Automatically find and delete org.python.* folders under /private/var/folders
sudo find /private/var/folders -type d \( -name "org.python.IDLE" -o -name "org.python.PythonLauncher" \) -exec rm -rf {} +

# Remove preferences
rm -f "$HOME/Library/Preferences/org.python.PythonLauncher.plist"

# Remove user-specific Python packages
rm -rf "$HOME/Library/Python/${PYTHON_VERSION}/"

# Remove __pycache__ and .pyc files
find "$HOME" -name "__pycache__" -type d \
  -not -path "*/node_modules/*" \
  -exec rm -rf {} +
find "$HOME" -name "*.pyc" \
  -not -path "*/node_modules/*" \
  -delete

echo "Python $PYTHON_VERSION and related files have been removed."
