import re

def parse(file):
    valid_games = []

    for line in file:
        line = line.strip()
        game = re.split(":|;", line)

        hand = {'red': 0, 'blue': 0, 'green':0}
        for hands in game[1:]:
            h = parse_hand(hands)

            if 'red' in h:
                hand['red'] = max(h['red'], hand['red'])
            if 'blue' in h:
                hand['blue'] = max(h['blue'], hand['blue'])
            if 'green' in h:
                hand['green'] = max(h['green'], hand['green'])

        valid_games.append(hand['red'] * hand['blue'] * hand['green'])
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

