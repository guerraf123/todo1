# Python program to read
# json file


import json

# Opening JSON file
f = open('db.json',)

# returns JSON object as
# a dictionary
data = json.load(f)

# Iterating through the json
# list

for i in data['requests']:
        print(i['message'])


# Closing file
f.close()

f = open("tfs.ps1", "w")
f.write("$headers = New-Object \"System.Collections.Generic.Dictionary[[String],[String]]\"\n")


f.write("$releaseUrl = 'http://401ktfsprod.es.ad.adp.com:8080/tfs/RSWebsites/RSWebsites/RSWebsites%20Team/_release?releaseId=")
for i in data['requests']:
        f.write(i['message'])
f.write("&_a=release-summary'")




f.close()
