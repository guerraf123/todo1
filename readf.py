# Python code to
# demonstrate readlines()
import json

L = ["Geeks\n", "for\n", "Geeks\n"]

# writing to file
file2 = open('crCO.ps1', 'w')

# Using readlines()
file1 = open('createCO.ps1', 'r')
Lines = file1.readlines()

count = 0
# Strips the newline character
for line in Lines:
    file2.writelines(line)
file1.close()

file3 = open('crReq.ps1', 'w')


file1 = open('createReq.ps1', 'r')
Lines = file1.readlines()

count = 0
# Strips the newline character
for line in Lines:
    file3.writelines(line)
file1.close()




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
f.write("param(\n")
f.write("    [Parameter()]$releaseUrl,\n")
f.write("    [Parameter()]$envSearchPattern,\n")
f.write("    [Parameter()]$approvalComment\n")
f.write(")\n")

f.write("$headers = New-Object \"System.Collections.Generic.Dictionary[[String],[String]]\"\n")
f.write("$releaseUrl = 'http://401ktfsprod.es.ad.adp.com:8080/tfs/RSWebsites/RSWebsites/RSWebsites%20Team/_release?releaseId=")
for i in data['requests']:
        f.write(i['message'])
f.write("&_a=release-summary'\n")

f1 = open('tfs1.ps1', 'r')
Lines = f1.readlines()

count = 0
# Strips the newline character
for line in Lines:
    f.write(line)


f1.close()
f.close()

#create the trigger for Add User in Add
f1 = open("\\\\DC1PRRETVEN0002\\c$\\fg\\AddADUser.trg", "w")
f1.write("trigger=true")
f1.close()
