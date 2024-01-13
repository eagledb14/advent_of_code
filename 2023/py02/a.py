import re

red_max = 12
green_max = 13
blue_max = 14

def parse(file):
    valid_games = []

    for line in file:
        line = line.strip()
        game = re.split(":|;", line)
        name = int(game[0].split(" ")[-1])

        valid_hand = True
        for hands in game[1:]:
            hand = parse_hand(hands)
            if 'red' in hand and hand['red'] > red_max:
                valid_hand = False
            if 'blue' in hand and hand['blue'] > blue_max:
                valid_hand = False
            if 'green' in hand and hand['green'] > green_max:
                valid_hand = False
        
        if valid_hand:
            valid_games.append(name)
    print(sum(valid_games))

def parse_hand(hand):
    h = {}
    dice = list(filter(lambda x: x != '', re.split(" |,", hand)))

    for i in range(1, len(dice), 2):
        if dice[i] not in h:
            h[dice[i]] = int(dice[i - 1])
        else:
            h[dice[i]] += int(dice[i - 1])

    return h



with open("input", "r") as file:
    parse(file)

