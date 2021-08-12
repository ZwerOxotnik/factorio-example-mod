#!/bin/bash
### Run this script after updating the mod to prepare a zip of it.


### REPOSITORY is current working directory
REPOSITORY=`pwd`
cd "$REPOSITORY/"


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
mod_name=`cat info.json|jq -r .name`
mod_ver=`cat info.json|jq -r .version`


### https://git-scm.com/
### Create git tag for this version
git tag "$mod_ver"


### Prepare zip for Factorio native use and mod portal
name="${mod_name}_$mod_ver"
git clean -xdf
7z a -xr'!.*' "$name.zip"  .
