import re

class Range:
    def __init__(self, source, destination, step):
        self.range = range(source, source + step)
        self.source = source
        self.destination = destination
        self.step  = step

    def check_index(self, index):
        return index in self.range

    def get_index(self, index):
        return self.destination + (index - self.source)

def strip(input):
    return [i for i in input if i != '']

def parse(input):
    seeds = parse_seeds(input[0])
    ranges = []
    for i in input[1:]:
        ranges.append(parse_map(i))

    locations = []
    for seed in seeds:
        locations.append(get_location(seed, ranges))

    print(locations)
    print(min(locations))

def get_location(seed, ranges):
    index = seed
    for map in ranges:
        for r in map:
            if r.check_index(index):
                index = r.get_index(index)
                break
    return index

def parse_seeds(input):
    input = strip(re.split(":| ", input))
    return [int(i) for i in input[1:]]

def parse_map(input):
    input = strip(re.split(":| ", input))[2:]
    input = [int(i) for i in input]
    return map_input(input)

def map_input(input):
    ranges = []

    for i in range(0, len(input), 3):
        destination = input[i]
        source = input[i + 1]
        step = input[i + 2]
        ranges.append(Range(source, destination, step))
    return ranges

with open("test", "r") as file:
    input = []
    section = ""
    for line in file:
        if len(line) == 1:
            input.append(section)
            section = ""
        section += line.strip() + ":"
    input.append(section)

    # print(strip(input[3].split(":")))
    parse(input)
