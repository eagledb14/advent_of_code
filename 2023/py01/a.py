
with open('input', "r") as file:
    numbers = []

    for line in file:
        num = ""
        for i in line.strip():
            if i.isdigit():
                num += i
                break

        for i in reversed(line.strip()):
            if i.isdigit():
                num += i
                break
        
        numbers.append(int(num))

    # print(numbers)
    print(sum(numbers))

