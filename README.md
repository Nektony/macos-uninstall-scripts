# macos-uninstall-scripts
A collection of shell scripts for fully removing CLI tools and their associated artefacts from macOS — receipts, framework folders, system cache, user packages, and bytecode that GUI uninstallers typically miss.
Maintained by Nektony — the team behind App Cleaner & Uninstaller and MacCleaner Pro.
***Why these scripts exist
Most Mac uninstaller apps (including our own App Cleaner & Uninstaller) work great for GUI applications — .app bundles dragged from the Applications folder. They detect leftover preferences, support files, and caches.
But CLI tools installed via .pkg installers, package managers, or custom installer scripts leave artefacts that GUI uninstallers don't always reach: .bom and .plist receipts in /private/var/db/receipts, framework folders in /Library/Frameworks, system cache in /private/var/folders, user packages in ~/Library/Python (or equivalent), and bytecode files scattered across the filesystem.
These scripts are the CLI complement: focused, transparent, and tested.
> For GUI apps, we still recommend App Cleaner & Uninstaller — it's faster and shows you what's being removed before you confirm.
***Available scripts
Tool	Script	Article
Python 3	python/nektony_uninstall_python.sh	How to uninstall Python on Mac
More scripts coming as we expand the series (Ollama, Logitech Options, FileMaker Pro, …).
***Usage
Each script lives in its own subfolder with a dedicated README explaining what it removes, how to run it, and which macOS versions it's been tested on.
General pattern:
# 1. Download the script (see the script's README for the direct link)
# 2. Make it executable
chmod +x ~/Downloads/nektony_uninstall_<tool>.sh
# 3. Read what it does (always inspect shell scripts before running)
less ~/Downloads/nektony_uninstall_<tool>.sh
# 4. Run with sudo (system files require elevated privileges)
sudo ~/Downloads/nektony_uninstall_<tool>.sh
***Safety
These scripts perform destructive operations on system folders. Before running:
Read the script. Every script in this repo is small enough to review in a few minutes.
Back up. Time Machine or a manual backup of /Library and ~/Library before first run.
Test on a non-critical machine first if you can.
If something goes wrong, open an issue — we read them.
***Issues and pull requests
Issues welcome — bug reports, "tested on" additions for new macOS versions, suggestions for new scripts. PRs reviewed case by case; for non-trivial changes please open an issue first to discuss.
***License
MIT — use, modify, redistribute. No warranty.
***Acknowledgements
The Python uninstaller draws inspiration from csev/uninstall-python3 by Charles "Dr. Chuck" Severance. We extended the original logic with receipts cleanup, system cache removal, user packages, and bytecode artefacts.
***About Nektony
We build Mac utilities — focused, transparent, no-nonsense. See nektony.com for the full product line and our GitHub organisation for other open-source work (methodology docs, Figma exporter, Duplicate File Finder methodology).
