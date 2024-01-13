def get_num(i, line):
    str = line[i]
    if str.isdigit():
        return str
    elif str == "o":
        if line.startswith("one", i):
            return "1"
    elif str == "t":
        if line.startswith("two", i):
            return "2"
        if line.startswith("three", i):
            return "3"
    elif str == "f":
        if line.startswith("four", i):
            return "4"
        if line.startswith("five", i):
            return "5"
    elif str == "s":
        if line.startswith("six", i):
            return "6"
        if line.startswith("seven", i):
            return "7"
    elif str == "e":
        if line.startswith("eight", i):
            return "8"
    elif str == "n":
        if line.startswith("nine", i):
            return "9"

with open('input', "r") as file:
    numbers = []

    for line in file:
        num = ""
        line = line.strip()

        for i in range(len(line)):
            n = get_num(i, line)
            if n != None:
                num += n
                break

        for i in range(len(line) - 1, -1, -1):
            n = get_num(i, line)
            if n != None:
                num += n
                break
        
        numbers.append(int(num))

    # print(numbers)
    print(sum(numbers))

