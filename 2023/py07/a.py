cards = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

class Hand:
    def __init__(self, hand, bid):
        self.hand = hand
        self.strength = []
        self.get_stength()
        self.bid = int(bid)

    def get_stength(self):
        self.strength.append(self.get_type(self.hand))

        for i in self.hand:
            self.strength.append(self.get_card_strength(i))

    def get_card_strength(self, card):
        return cards.index(card)

    def get_type(self, hand):
        card = {}
        for i in hand:
            if i in card:
                card[i] += 1
            else:
                card[i] = 1

        card = sorted(list(card.values()), reverse=True)

        if card[0] == 5:
            return 7
        elif card[0] == 4:
            return 6
        elif card[0] == 3 and card[1] == 2:
            return 5
        elif card[0] == 3:
            return 4
        elif card[0] == 2 and card[1] == 2:
            return 3
        elif card[0] == 2:
            return 2
        else:
            return 1

    def __str__(self):
        return f"{self.hand} {self.bid} {self.strength}"

    def __lt__(self, other):
        for i in range(len(self.strength)):
            if self.strength[i] != other.strength[i]:
                return self.strength[i] < other.strength[i]

        return False

    def __eq__(self, other):
        return self.strength == other.strength

def parse(input):
    hands = []
    for i in input:
        parts = i.split(" ")
        hands.append(Hand(parts[0], parts[1]))

    return hands


file = open("input", 'r')

input = []
for line in file:
    input.append(line.strip())
file.close()

hands = sorted(parse(input))

total = 0
for i in range(len(hands)):
    total += hands[i].bid * (i + 1)
print(total)

