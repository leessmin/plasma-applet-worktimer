#!/bin/sh

DIR="$(cd "$(dirname "$0")" && pwd)"

META="$DIR/../../metadata.json"

plasmoidName=$(jq -r '.KPlugin.Id' "$META")
website=$(jq -r '.KPlugin.Website // empty' "$META")

bugAddress="$website"
packageRoot="$DIR/../../"
projectName="plasma_applet_${plasmoidName}"

#---
if [ -z "$plasmoidName" ]; then
    echo "[build] Error: Couldn't read plasmoidName."
    exit
fi

#---
echo "[build] Compiling messages"

catalogs=`find . -name '*.po' | sort`
for cat in $catalogs; do
    echo "$cat"
    catLocale=`basename ${cat%.*}`
    msgfmt -o "${catLocale}.mo" "$cat"

    installPath="$DIR/../../contents/locale/${catLocale}/LC_MESSAGES/${projectName}.mo"

    echo "[build] Install to ${installPath}"
    mkdir -p "$(dirname "$installPath")"
    mv "${catLocale}.mo" "${installPath}"
done

echo "[build] Done building messages"
