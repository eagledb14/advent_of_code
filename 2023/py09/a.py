import sys

def parse(input):
    numbers = []
    for line in input:
        numbers.append([int(i) for i in line.split(" ")])
    return numbers

def next_value(history):
    return history[-1] + get_difference(history)

def get_difference(history):
    if all(i == 0 for i in history):
        return 0
    
    derivative = []
    for i in range(len(history) - 1):
        derivative.append(history[i + 1] - history[i])

    difference = get_difference(derivative)
    return derivative[-1] + difference

file = open(sys.argv[1], "r")
input = []
for line in file:
    input.append(line.strip())
file.close()

data = parse(input)


values = []
for d in data:
    values.append(next_value(d))
print(sum(values))

