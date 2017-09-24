ACCESS_TOKEN="igt9FdYKYr2sKuK4AxdnIR5J6Pkw0py558eqVQs6ks2RmTVzHZhK4NgcDNFT"

for PUB in `find update_depositions -name '*.json'`

do

NUM=`echo "$PUB" | rev | cut -d'.' -f2-7 | rev | cut -d'/' -f2`

echo "$PUB"
echo "$NUM"

# Create Deposition Resource
# Write STDERR to *_deposition.log
# Get zenodo id from JSON response and append to zenodo_id.txt

# Sandbox Zenodo
#curl  -H "Content-Type: application/json" -X POST -d @"$PUB" https://sandbox.zenodo.org/api/deposit/depositions?access_token="$ACCESS_TOKEN" | tee -a deposition_logs/"$NUM"_deposition.log | jq '.id' >> zenodo_id.txt


# Production Zenodo
curl -H "Content-Type: application/json" -X PUT -d @"$PUB" https://zenodo.org/api/deposit/depositions/"$PUB"?access_token="$ACCESS_TOKEN" | tee -a update_deposition_logs/"$NUM"_deposition.log 

# Publish Deposition
# Append response to *deposition.log

# Sandbox Zenodo
#curl -i -X POST https://sandbox.zenodo.org/api/deposit/depositions/"$ZENODO_ID"/actions/publish?access_token="$ACCESS_TOKEN" >> deposition_logs/"$NUM"_deposition.log

# Production Zenodo
#curl -i -X POST https://zenodo.org/api/deposit/depositions/"$ZENODO_ID"/actions/publish?access_token="$ACCESS_TOKEN" >> deposition_logs/"$NUM"_deposition.log



# Move uploaded file to uploaded/dir
#mv "$PUB" uploaded/"$NUM".json

done
