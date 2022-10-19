#!/usr/bin/env bash
(set -o igncr) 2>/dev/null && set -o igncr; # This comment is required.
### The above line ensures that the script can be run on Cygwin/Linux even with Windows CRNL.
### Run this script after updating the mod to prepare a zip of it.

main() {
### Check commands
if ! command -v git &> /dev/null; then
	echo "Please install/use git https://git-scm.com/downloads"
fi
local has_errors=false
if ! command -v jq &> /dev/null; then
	echo "Please install jq https://stedolan.github.io/jq/"
	local has_errors=true
fi
if ! command -v 7z &> /dev/null; then
	echo "Please install 7-Zip https://www.7-zip.org/download.html"
	local has_errors=true
fi
if [ $has_errors = true ] ; then
	exit 1
fi


### mod_folder is a mod directory with info.json
local init_dir=`pwd`


### Find info.json
local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
local infojson_exists=false
if [[ -s "$SCRIPT_DIR/info.json" ]]; then
	infojson_exists=true
	mod_folder=$SCRIPT_DIR
else
	cd $SCRIPT_DIR
	cd ..
	if [[ -s "$PWD/info.json" ]]; then
		infojson_exists=true
		mod_folder=$PWD
	elif [[ -s "$init_dir/info.json" ]]; then
		infojson_exists=true
		mod_folder=$init_dir
	fi
fi


if [ $infojson_exists = false ] ; then
	echo "There's no info.json"
	exit 1
fi
cd "$mod_folder/"
echo "Target folder: ${mod_folder}"


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
local MOD_NAME=$(jq -r '.name' info.json)
local MOD_VERSION=$(jq -r '.version' info.json)


# Validate the version string we're building
if ! echo "${MOD_VERSION}" | grep -P --quiet '^\d+\.\d+\.\d+$'; then
    echo "Incorrect version pattern, needs to be %u.%u.%u (e.q., 0.1.0)"
    exit 1
fi


### Prepare zip for Factorio native use and mod portal
### https://www.7-zip.org/download.html
local name="${MOD_NAME}_${MOD_VERSION}"
if command -v git &> /dev/null; then
	git clean -xdf
fi
7z a -xr'!.*' "${mod_folder}/${name}.zip" "${mod_folder}"
}
main
