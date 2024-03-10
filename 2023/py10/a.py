from dataclasses import dataclass
# yeah this doesn't work and I've already lost interest in making it work

@dataclass
class Node:
    def __init__(self, arr, key, name):
        self.key = key
        self.name = name

        if len(arr) >= 1:
            self.first = arr[0]

        if len(arr) >= 2:
            self.second = arr[1]

    def __repr__(self):
        return f'{self.key} {self.first} {self.second}'

def is_valid_index(r, c, input):
    if r < 0 or r >= len(input[0]):
        return False
    
    if c < 0 or c >= len(input):
        return False
    return True

def insert_value(r, c, r1, c1, input, graph):
    if is_valid_index(r1, c1, input) == False:
        return

    key = (r, c)
    end = (r1, c1)
    if key in graph:
        graph[key].append(end)
    else:   
        graph[key] = [end]

def parse(input):
    keys = {
        '|': ['N', 'S'],
        '-': ['W', 'E'],
        'L': ['N', 'E'],
        'J': ['N', 'W'],
        '7': ['W', 'S'],
        'F': ['S', 'E']
    }

    graph = {}
    start = ()

    for r, row in enumerate(input):
        for c, tile in enumerate(row):
            if tile == '.':
                continue
            elif tile == 'S':
                print("hello?")
                get_start(r, c, input, graph)
                start = (r,c)
                continue

            for key in keys[tile]:
                r1, c1 = r, c


                if key == 'N':
                    r1 -= 1
                elif key == 'S':
                    r1 += 1
                elif key == 'W':
                    c1 -= 1
                elif key == 'E':
                    c1 += 1
                else:
                    continue

                insert_value(r, c, r1, c1, input, graph)

    for name, arr in graph.items():
        (r, c) = name
        graph[name] = Node(arr, input[r][c], name)
    return start, graph

def get_start(r, c, input, graph):
    dirs = [(-1, 0), (1, 0), (0, 1), (0, -1)]
    keys = [['|', 'L', 'J'], ['|', '7', 'F'], ['-', 'L', 'F'], ['-', 'J', '7']]

    for (x, y), key in zip(dirs, keys):
        r1,c1 = r + x, c + y 

        if input[r1][c1] in key:
            insert_value(r, c, r1, c1, input, graph)

def get_loop(start, graph):
    loop = [start]
    parent = start
    node = graph[start].first

    while node != start:
        loop.append(node)
        temp = node

        if graph[node].first == parent:
            node = graph[node].second
        else:
            node = graph[node].first
        parent = temp
    
    return loop

if __name__ == '__main__':
    file = open("input", "r")

    input = []

    for line in file:
        input.append(line.strip())
    file.close()
    start, graph = parse(input)

    loops = get_loop(start, graph)

    for i in loops:
        print(i)

    
    print(len(loops) / 2)

    # for i,j in graph.items():
    #     print(i, j)



