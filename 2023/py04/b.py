import re

def parse(input):
    multiply = [1 for _ in range(len(input))]

    for card in input:
        parts = re.split(r':|\|', card)
        name = int(parts[0].split(" ")[-1])

        nums = intersect(parts[1:])
        multiplicative = multiply[name - 1]
        for i in range(len(nums)):
            multiply[name + i] += multiplicative 

    print(multiply)
    print(sum(multiply))

        
def intersect(card):
    win = [i for i in card[0].split(" ") if i != ""]
    own = [i  for i in card[1].split(" ") if i != ""]

    return [c for c in win if c in own]

with open("input", "r") as file:
    input = []
    for line in file:
        input.append(line.strip())

    parse(input)
