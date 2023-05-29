#!/bin/sh
cd /data
wget -O /data/geyser.jar.new https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone

GEYSER_NEWHASH=$(sha256sum /data/geyser.jar.new | cut -d' ' -f1)
if [ ! -f /data/geyser.jar ]; then
	echo "Installing Geyser..."
	mv /data/geyser.jar.new /data/geyser.jar
fi
GEYSER_OLDHASH=$(sha256sum /data/geyser.jar | cut -d' ' -f1)
if [ "$NEWHASH" != "$OLDHASH" ]; then
	echo "Updating Geyser..."
	mv /data/geyser.jar.new /data/geyser.jar
fi

echo "Updating GeyserConnect..."
if [ -z "$GH_TOKEN" ]; then
	echo "No GH_TOKEN set, cannot update GeyserConnect."
else

	GEYSERCONNECT_BUILD=$(curl -s https://api.github.com/repos/GeyserMC/GeyserConnect/actions/workflows/build.yml/runs | jq -r '.workflow_runs[0].id')
	GEYSERCONNECT_URL=$(curl -s https://api.github.com/repos/GeyserMC/GeyserConnect/actions/runs/5027683930/artifacts | jq -r '.artifacts[0].archive_download_url')
	curl -L \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer $GH_TOKEN" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		$GEYSERCONNECT_URL --output geyserconnect.zip
	unzip -o geyserconnect.zip GeyserConnect.jar
	mv GeyserConnect.jar extensions/GeyserConnect.jar
fi

java -jar geyser.jar
