import re


def parse(input):
    instructions = input[0].replace("L", "0").replace("R", "1")
    instructions = [int(i) for i in instructions]
    mapping = {}

    for i in input[2:]:
        parts = re.split("=|\(|\)", i)
        mapping[parts[0].strip()] = parts[2].split(", ")

    return instructions, mapping

def iterate(instructions, map):
    pointer = 'AAA'
    index = 0
    count = 0

    while pointer != 'ZZZ':
        pointer = map[pointer][instructions[index]]
        count += 1

        index = (index + 1) % len(instructions)
    return count

if __name__ == '__main__':
    file = open("input", 'r')

    input = []
    for line in file:
        input.append(line.strip())

    instructions, map = parse(input)
    count = iterate(instructions, map)
    print(count)


