import re
import math


def parse(input):
    instructions = input[0].replace("L", "0").replace("R", "1")
    instructions = [int(i) for i in instructions]
    mapping = {}
    starting = []

    for i in input[2:]:
        parts = re.split("=|\(|\)", i)
        instruction = parts[0].strip()
        mapping[instruction] = parts[2].split(", ")

        if instruction[2] == 'A':
            starting.append(instruction)

    return instructions, mapping, starting

def iterate(instructions, map, pointer):
    index = 0
    count = 0

    while pointer[2] != 'Z':
        pointer = map[pointer][instructions[index]]
        count += 1

        index = (index + 1) % len(instructions)
    return count

if __name__ == '__main__':
    file = open("input", 'r')

    input = []
    for line in file:
        input.append(line.strip())

    instructions, map, starting = parse(input)
    counts = []
    for s in starting:
        counts.append(iterate(instructions, map, s))
    print(counts)
    print(math.lcm(*counts))


