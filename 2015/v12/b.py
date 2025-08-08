import json

def sum_numbers_ignoring_red(data):
    total_sum = 0
    if isinstance(data, int):
        total_sum += data
    elif isinstance(data, list):
        for item in data:
            total_sum += sum_numbers_ignoring_red(item)
    elif isinstance(data, dict):
        if "red" in data.values():
            return 0
        else:
            for _, value in data.items():
                total_sum += sum_numbers_ignoring_red(value)
    return total_sum

with open('input', 'r') as f:
    puzzle_data = json.load(f)

result = sum_numbers_ignoring_red(puzzle_data)
print(result)
