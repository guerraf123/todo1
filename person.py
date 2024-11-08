import json

with open('friend.json') as f:
  data = json.load(f)

# Output: {'name': 'Bob', 'languages': ['English', 'Fench']}
print(data['friends'][1])
print(data)
