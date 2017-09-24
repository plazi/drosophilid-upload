SOURCE="drosophila_articles.json"
for RECORD in {151..200}

do
echo "$SOURCE"
JSON=`jq .rows["$RECORD"] "$SOURCE"`
FILENAME=`echo "$JSON" | grep "file" | cut -d':' -f2 | cut -d'"' -f2 | sed 's/^ \(.*\),$/\1/g'`

#echo "$JSON"
echo "$FILENAME"
echo "$JSON" | grep -v 'file":' > uploads/"$FILENAME".json

done
