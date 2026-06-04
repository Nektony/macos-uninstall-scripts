# nektony_uninstall_python.sh

Fully removes Python 3 installations from macOS — including artefacts that standard `pkg` uninstallation leaves behind.

**Article:** [How to uninstall Python on Mac](https://nektony.com/how-to/uninstall-python-on-mac) — step-by-step explanation, screenshots, and manual alternatives if you don't want to run a script.

---

## What it removes

- Python 3.x application bundle in `/Applications/Python 3.x/`
- Python framework in `/Library/Frameworks/Python.framework/Versions/3.x/`
- Symlinks in `/usr/local/bin/` (`python3`, `pip3`, `idle3`, etc.)
- Installation receipts (`.bom`, `.plist`) in `/private/var/db/receipts/`
- System cache folders in `/private/var/folders/` (`org.python.*`)
- User packages in `~/Library/Python/3.x/`
- All `__pycache__/` folders and `.pyc` files in the user's home directory
- Python's entry in macOS Recent Documents

---

## What it does NOT touch

- System Python 2 (deprecated by Apple but still bundled on some older systems)
- Homebrew-installed Python (use `brew uninstall python@3.x` for those)
- Conda / Miniconda / Anaconda installations (those have their own uninstallers)
- Python virtual environments (`venv`, `virtualenv`) — those are isolated and safe

---

## Tested on

- macOS Sequoia 15.5, macOS Tahoe 26.4.1

If you've used it on a different version successfully, please [open a PR](https://github.com/Nektony/macos-uninstall-scripts/pulls) to add it here.

---

## Usage

```bash
# Download the script
curl -O https://raw.githubusercontent.com/Nektony/macos-uninstall-scripts/main/python/nektony_uninstall_python.sh

# Or grab the ZIP from nektony.com:
# https://nektony.com/wp-content/uploads/2025/10/nektony_uninstall_python.zip

# Make it executable
chmod +x nektony_uninstall_python.sh

# Inspect before running
less nektony_uninstall_python.sh

# Run with sudo (system folders require elevated privileges)
sudo ./nektony_uninstall_python.sh
```

---

## Acknowledgement

Inspired by [csev/uninstall-python3](https://github.com/csev/uninstall-python3) by Charles "Dr. Chuck" Severance. This version extends the original with deeper cleanup: receipts, system cache, user packages, and bytecode artefacts.

---

## Issues / questions

[Open an issue](https://github.com/Nektony/macos-uninstall-scripts/issues) — we read them. For non-technical questions about Python on macOS, the [article on nektony.com](https://nektony.com/how-to/uninstall-python-on-mac) covers the most common cases.
