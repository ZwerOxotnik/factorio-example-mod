#!/usr/bin/env bash
### Run this script on GitHub after zipping the mod to upload the mod on mods.factorio.com
### This a modified version of https://github.com/Penguin-Spy/factorio-mod-portal-publish/blob/5c669dc60672e6293afd5b1913a0c8475c5490c0/entrypoint.sh
### You can generate your FACTORIO_MOD_API_KEY on https://factorio.com/create-api-key


### Check commands
has_errors=false
if ! command -v jq &> /dev/null; then
	echo "Please install jq https://stedolan.github.io/jq/"
	has_errors=true
fi
if [ $has_errors = true ] ; then
	exit 1
fi


### Get mod name and version from info.json
### https://stedolan.github.io/jq/
MOD_VERSION=$(jq -r '.version' info.json)
MOD_NAME=$(jq -r '.name' info.json)


# Validate the version string we're building
if ! echo "${MOD_VERSION}" | grep -P --quiet '^\d+\.\d+\.\d+$'; then
    echo "Incorrect version pattern, needs to be %u.%u.%u (e.q., 0.1.0)"
    exit 1
fi


# Get an upload url for the mod
URL_RESULT=$(curl -s -d "mod=${MOD_NAME}" -H "Authorization: Bearer ${FACTORIO_MOD_API_KEY}" https://mods.factorio.com/api/v2/mods/releases/init_upload)
UPLOAD_URL=$(echo "${URL_RESULT}" | jq -r '.upload_url')
if [[ "${UPLOAD_URL}" == "null" ]] || [[ -z "${UPLOAD_URL}" ]]; then
    echo "Couldn't get an upload url, failed"
    ERROR=$(echo "${URL_RESULT}" | jq -r '.error')
    MESSAGE=$(echo "${URL_RESULT}" | jq -r '.message // empty')
    echo "${ERROR}: ${MESSAGE}"
    exit 1
fi


# Upload the file
UPLOAD_RESULT=$(curl -s -F "file=@${MOD_NAME}_${MOD_VERSION}.zip" "${UPLOAD_URL}")

# The success attribute only appears on successful uploads
SUCCESS=$(echo "${UPLOAD_RESULT}" | jq -r '.success')
if [[ "${SUCCESS}" == "null" ]] || [[ -z "${SUCCESS}" ]]; then
    echo "Upload failed"
    ERROR=$(echo "${UPLOAD_RESULT}" | jq -r '.error')
    MESSAGE=$(echo "${UPLOAD_RESULT}" | jq -r '.message // empty')
    echo "${ERROR}: ${MESSAGE}"
    exit 1
fi

echo "Upload of ${MOD_NAME}_${MOD_VERSION}.zip completed"
