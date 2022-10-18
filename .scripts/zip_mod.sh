#!/usr/bin/env bash
### Run this script after updating the mod to prepare a zip of it.


### REPOSITORY is current working directory
REPOSITORY=`pwd`
cd "$REPOSITORY/"


### Check commands
has_errors=false
if ! command -v jq &> /dev/null; then
  echo "Please install jq https://stedolan.github.io/jq/"
  has_errors=true
fi
if ! command -v 7z &> /dev/null; then
  echo "Please install 7-Zip https://www.7-zip.org/download.html"
fi
if [ $has_errors = true ] ; then
	exit
fi


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
mod_name=`cat info.json|jq -r .name`
mod_ver=`cat info.json|jq -r .version`


### Prepare zip for Factorio native use and mod portal
### https://www.7-zip.org/download.html
name="${mod_name}_${mod_ver}"
git clean -xdf
cd ..
7z a -xr'!.*' "${REPOSITORY}/${name}.zip" "${REPOSITORY}"
