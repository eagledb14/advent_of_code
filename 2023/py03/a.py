

class Grid:
    def __init__(self, input):
        self.grid = [["" for _ in range(len(input[0]))] for _ in range(len(input))]
        self.x = len(input[0])
        self.y = len(input)
        self._init_grid(input)
        
    def _init_grid(self, input):
        for i in range(len(input)):
            j = 0
            while j < len(input[i]):

                if input[i][j].isdigit():
                    start = j
                    num = ""
                    while j < len(input[i]) and input[i][j].isdigit():
                        num += input[i][j]
                        j += 1

                    for k in range(start, j):
                        self.grid[i][k] = num
                    continue

                elif input[i][j] != '.':
                    self.grid[i][j] = input[i][j]

                j += 1

    def find_number(self):
        numbers = []
        for i in range(len(self.grid)):
            for j in range(len(self.grid[i])):
                if self.grid[i][j] != "" and not self.grid[i][j].isdigit():
                    numbers.extend(self.check_surroundings(i, j))

        return [int(n) for n in numbers ]

    
    def get(self, x, y):
        if x < 0 or x >= self.x:
            return ""

        if y < 0 or y >= self.y:
            return ""
        
        return self.grid[x][y]

    def check_surroundings(self, i, j):
        directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        nums = set()

        for dir in directions:
            num = self.get(i + dir[0], j + dir[1])
            if num.isdigit():
                nums.add(num)

        return list(nums)



with open("input", "r") as file:
    input = []
    for line in file:
        input.append(line.strip())

    g = Grid(input)
    # print(g.grid)
    n = g.find_number()
    # print(n)
    print(sum(n))

