#! /bin/bash

i=0
URL="https://www.floatplane.com/api/v3/content/creator?id=6548c71244c4c2831b1bdac7"
EXPORT_PATH=/home/runner/work/FloatGetJames/FloatGetJames/james.xml

curl -o json $URL 
echo '<?xml version="1.0" encoding="utf-8"?>' > $EXPORT_PATH
echo '<rss version="2.0">' >> $EXPORT_PATH
echo '
<channel>
<title>Floatplane RSS feed ltt un-off</title>
<link>https://floatplane.com/</link>
<description>Script made by @HarleyGodfrey5 on twitter</description>
<lastBuildDate>'$(date)'</lastBuildDate>
<language>en-us</language>' >> $EXPORT_PATH

while [ $i -le 19 ];
do
	echo '<item>
	<title>'$(cat json | jq -r '.['$i'].title' | recode ascii..html)'</title>
	<pubDate>'$(date -d $(cat json | jq -r '.['$i'].releaseDate') --rfc-2822)'</pubDate>
	<link>https://www.floatplane.com/post/'$(cat json | jq -r '.['$i'].id' | recode ascii..html)'</link>
	<description>&lt;img src="'$(cat json | jq -r '.['$i'].thumbnail.path')'"&gt;'$(cat json | jq -r '.['$i'].text' | recode ascii..html)'</description>
	</item>' >> $EXPORT_PATH
	((i++))
done
echo '</channel>
</rss>' >> $EXPORT_PATH
