
def parse(input):
    races = [[], []]
    races[0] = [int(i) for i in input[0].split(" ")[1:] if i != '']
    races[1] = [int(i) for i in input[1].split(" ")[1:] if i != '']
    return races

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

    races = parse(input)
    total = 1
    for i in range(len(races[0])):
        total *= play_race(races[0][i], races[1][i])

    print(total)
