ACCESS_TOKEN="igt9FdYKYr2sKuK4AxdnIR5J6Pkw0py558eqVQs6ks2RmTVzHZhK4NgcDNFT"

for DEPOSITION in deposition_records/*

do 

DEPO_ID=`jq .id $DEPOSITION`
FILE_JSON=`curl -D -i https://zenodo.org/api/deposit/depositions/"$DEPO_ID"/files?access_token="$ACCESS_TOKEN"`

#echo $DEPOSITION
#echo $DEPO_ID

DEPO_MD=`jq -r '.metadata.creators[0].name,.metadata.title?,.metadata.journal.title,.metadata.publication_date,.metadata.access_right,.doi,.id,.links.html,.links.self' "$DEPOSITION" | tr '\012' '|'`

FILENAME=`echo "${FILE_JSON}" | jq -r '.[0].filename' | rev | cut -d'.' -f2-22 | rev`

echo "${FILENAME}|${DEPO_MD}"

done