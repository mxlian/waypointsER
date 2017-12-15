#!/bin/bash
#
# Takes a Google Maps ID and generates waypoints files in different
# formats. 
#
# Original work made by Sebastian Schmied

FILENAME="EntreRios"
MAPSID="1d6M1QwJvKgQwmjCkJ7wUT4sV28Z7Zrpj"
curl -H 'Cache-Control: no-cache' "https://www.google.com/maps/d/kml?forcekml=1&mid=${MAPSID}" -o ${FILENAME}.kml

gpsbabel -w -i kml -f ${FILENAME}.kml -o cup -F ${FILENAME}.cup
gpsbabel -w -i kml -f ${FILENAME}.kml -o ozi -F ${FILENAME}_ozi.wpt
gpsbabel -w -i kml -f ${FILENAME}.kml -o compegps -F ${FILENAME}_compe.wpt
gpsbabel -w -i kml -f ${FILENAME}.kml -o gpx -F ${FILENAME}.gpx

# Remove optional <time> element from .gpx to avoid git clutter
sed -i '/.*<time>.*<\/time>.*/d' ${FILENAME}.gpx
