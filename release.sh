#!/bin/bash
version=${1#refs/tags/v}

npm ci
npm run build

zip -r -j bob-plugin-fireworks-$version.bobplugin build/*

sha256_fireworks=$(sha256sum bob-plugin-fireworks-$version.bobplugin | cut -d ' ' -f 1)
echo $sha256_fireworks

download_link="https://github.com/missuo/bob-plugin-fireworks/releases/download/v$version/bob-plugin-fireworks-$version.bobplugin"

new_version="{\"version\": \"$version\", \"desc\": \"None\", \"sha256\": \"$sha256_fireworks\", \"url\": \"$download_link\", \"minBobVersion\": \"1.8.0\"}"

json_file='appcast.json'
json_data=$(cat $json_file)

updated_json=$(echo $json_data | jq --argjson new_version "$new_version" '.versions = [$new_version] + .versions')

echo $updated_json > $json_file
mkdir -p dist
mv *.bobplugin dist
