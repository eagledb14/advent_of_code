import re
import sys

class Range:
    def __init__(self, source, destination, step):
        self.source = source
        self.destination = destination
        self.step  = step

    def check_index(self, index):
        return index >= self.destination and index <= (self.destination + self.step)

    def get_index(self, index):
        return self.source + (index - self.destination)

def strip(input):
    return [i for i in input if i != '']

def parse(input):
    seeds = parse_seeds(input[0])
    ranges = []
    for i in input[1:]:
        ranges.append(parse_map(i))

    get_seed(ranges, 0, seeds)


def get_seed(ranges, location, seeds):
    while True:
        index = location
        for map in ranges[::-1]:
            for m in map:
                if m.check_index(index):
                    index = m.get_index(index)
                    break

        for seed in seeds:
            if index in seed:
                print("FINAL:", location - 1)
                sys.exit()

        print(location)
        location += 1

def parse_seeds(input):
    input = strip(re.split(":| ", input))
    input = [int(i) for i in input[1:]]
    seeds = []
    for i in range(0, len(input), 2):
        seeds.append(range(input[i], input[i] + input[i + 1] + 1))
    return seeds


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

with open("input", "r") as file:
    input = []
    section = ""
    for line in file:
        if len(line) == 1:
            input.append(section)
            section = ""
        section += line.strip() + ":"
    input.append(section)

    parse(input)
