# mis-information
Miscreated information changes - Helping modders by tracking LUA and XML changes between Miscreated updates.

# How to use this script
The following is a rough list of Linux/Bash commands - you'll have to figure out and fix any borked commands. The listed commands will compare the installed version of Miscreated against the files contained in the `master` branch of this repo. Be sure to update the Miscreated install path to reflect the actual path in use on your system.
```bash
sudo apt install -y dos2unix
git clone https://github.com/Spafbi/mis-information.git
cd ./mis-information
rm -rf ./info
python3 ./mis-info-extractor.py -d /mnt/c/Games/SteamLibrary/steamapps/common/Miscreated
bash ./fix_line_endings.sh
git add .
```
## Diff all changed files
```bash
git diff
```
## Diff a specific file
Use the correct filename and path, of course.
```bash
git diff master info/Scripts/Entities/Items/XML/filename.xml
```
