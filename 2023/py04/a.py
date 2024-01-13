import re

def parse(input):
    scores = []

    for card in input:
        parts = re.split(r':|\|', card)
        name = parts[0].split(" ")[-1]

        nums = intersect(parts[1:])
        scores.append(get_score(nums))

    print(scores)
    print(sum(scores))

def intersect(card):
    win = [i for i in card[0].split(" ") if i != ""]
    own = [i  for i in card[1].split(" ") if i != ""]

    return [c for c in win if c in own]

def get_score(nums):
    if len(nums) == 0:
        return 0
    elif len(nums) == 1:
        return 1
    
    return 2 ** (len(nums) - 1)

with open("input", "r") as file:
    input = []
    for line in file:
        input.append(line.strip())

    parse(input)
