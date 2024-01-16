
def parse(input):
    time = input[0].split(" ")[1:]
    time = int(''.join(time))
    distance = input[1].split(" ")[1:]
    distance = int(''.join(distance))

    print(time, distance)

    return time, distance

def play_race(time, record):
    wins = 0
    for i in range(time + 1):
        distance = i * (time - i)
        if distance > record:
            wins += 1
    return wins

if __name__ == "__main__":
    file = open("input", "r")

    input = []
    for line in file:
        input.append(line.strip()) 

    file.close()

    time, distance = parse(input)
    total = play_race(time, distance)
    print(total)
