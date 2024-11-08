# Python program to read 
# json file 
  
  
import json 
  
# Opening JSON file 
f = open('data.json',) 
  
# returns JSON object as  
# a dictionary 
data = json.load(f) 
  
# Iterating through the json 
# list 

for i in data['requests']: 
    print(i) 

  "requests": [
    {
      "message": "32316",
      "attention": true,
      "tech": "Frank Guerra",
      "date": "2020-12-26T22:35:38.600Z",
      "id": 1
    }


for i in data['emp_details']: 
    print("Name:", i['emp_name']) 
    print("Website:", i['email']) 
    print("From:", i['job_profile']) 
    print() 

# Closing file 
f.close() 


