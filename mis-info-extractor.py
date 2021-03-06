#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# title           : mis-info-extractory.py
# description     : Extract LUA and XML files from Miscreated PAK files
# author          : Chris Snow (a.k.a. Spafbi)
# usage           : see ./mis-info-extractory.py -h for usage
# python_version  : 3.6.7
# ==============================================================================
from pathlib import Path
from zipfile import ZipFile
import argparse
import os
import subprocess


def extract_file_old_method(**kwargs):
    filename = kwargs.get('filename')
    target_dir = kwargs.get('target_dir')
    extensions = ('.lua', '.xml')
    pak_file = ZipFile(filename, 'r')
    for file in pak_file.namelist():
        if file.endswith(extensions):
            print("filename: {}\nfile: {}\ntarget_dir: {}".format(filename, file, target_dir))
            pak_file.extract(file, target_dir)
    pak_file.close()

def extract_file(**kwargs):
    filename = kwargs.get('filename')
    target_dir = kwargs.get('target_dir')
    extensions = ('.lua', '.xml')
    pak_file = ZipFile(filename, 'r')
    baseCmd = '/usr/bin/unzip -o {FILENAME} {THISFILE} -d {TARGET}'
    for file in pak_file.namelist():
        if file.lower().endswith(extensions):
            thisCmd = baseCmd.format(FILENAME=filename,
                                     THISFILE=file,
                                     TARGET=target_dir).split()

            subprocess.run(thisCmd)
    pak_file.close()

def remove_binary_xml_files(target_dir):
    textchars = bytearray({7,8,9,10,12,13,27} | set(range(0x20, 0x100)) - {0x7f})
    is_binary_string = lambda bytes: bool(bytes.translate(None, textchars))
    xml_list = list(Path(target_dir).rglob("*.[xX][mM][lL]"))
    binaries = list()
    for this_xml in xml_list:
        if is_binary_string(open(this_xml, 'rb').read(1024)):
            binaries.append(this_xml)
    for binary_file in binaries:
        os.remove(binary_file)

def process_paks(**kwargs):
    directory = kwargs.get('directory')
    target_dir = kwargs.get('target_dir')

    for filename in os.listdir(directory):
        if filename.endswith(".pak"):
            # extract_file(filename="{0}/{1}".format(directory, filename),
            #              target_dir=target_dir)
            extract_file(filename="{0}/{1}".format(directory, filename),
                         target_dir=target_dir)

    # Remove binary files
    remove_binary_xml_files(target_dir)


def main():
    description = 'Miscreated Information (LUA and XML) Extrator'
    default_dir = 'C:/Games/SteamLibrary/steamapps/common/Miscreated'
    # default_dir = 'C:/Games/Miscreated'
    help = "Miscreated installation directory - be sure to use forward " \
           "slashes instead of backslashes"
    parser = argparse.ArgumentParser(
        'Mis-Information-Extrator', description)
    parser.add_argument('-d', '--directory',
                        metavar='[directory]',
                        type=str,
                        required=False,
                        help=help,
                        default=default_dir)
    parser.add_argument('-t', '--target',
                        metavar='[target]',
                        type=str,
                        required=False,
                        help="target base directory for extracted files",
                        default='./info')

    args = parser.parse_args()
    install_dir = args.directory
    sdk_dir = "{0}/GameSDK".format(install_dir)

    if not os.path.isdir(sdk_dir):
        message = """
Oops... The specified Miscreated installation directory does not appear
        to contain a GameSDK subdirectory. Check to make sure you
        specified the correct directory.
        Please specify the proper Miscreated installation location.

Directory: {0}
"""
        print(message.format(install_dir))
        exit()

    process_paks(directory=sdk_dir,
                 target_dir=args.target)


if __name__ == '__main__':
    main()
