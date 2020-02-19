#!/bin/bash

LINK_NAME=$1

DIRECTORY_PATH="html/"

mkdir -p ${DIRECTORY_PATH}
cd ${DIRECTORY_PATH} || exit

wget -O temp -U 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4' ${LINK_NAME}

SONG_TITLE=$(cat temp | grep "<div class=\"js-store\" data-content" | awk -F'song_name&quot;:&quot;' '{print $2}' | awk -F'&quot;' '{print $1}') 
ARTIST_NAME=$(cat temp | grep "<div class=\"js-store\" data-content" | awk -F'artist_name&quot;:&quot;' '{print $2}' | awk -F'&quot;' '{print $1}')
SONG_CONTENT=$(cat temp | grep "<div class=\"js-store\" data-content" | awk -F'content&quot;:&quot;' '{print $2}' | awk -F'&quot;' '{print $1}')

rm temp

SONG_CONTENT=$(echo $SONG_CONTENT | sed -e s/'\[tab\]'//g)
SONG_CONTENT=$(echo $SONG_CONTENT | sed -e s/'\[\/tab\]'//g)
SONG_CONTENT=$(echo $SONG_CONTENT | sed -e s/'\[ch\]'//g)
SONG_CONTENT=$(echo $SONG_CONTENT | sed -e s/'\[\/ch\]'//g)

FILENAME=${SONG_TITLE}_${ARTIST_NAME}.tex

echo '\\beginsong{'${SONG_TITLE}'}[' >> $FILENAME
echo '\tby={'${ARTIST_NAME}'},' >> $FILENAME
echo '\tindex={'${SONG_TITLE}'}]' >> $FILENAME

echo $SONG_CONTENT >> $FILENAME
echo '\\endsong' >> $FILENAME
