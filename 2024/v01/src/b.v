module b

pub fn run(input []string) {
	mut right := []int{}
	mut left := []int{}

	for lines in input {
		pairs := lines.split(" ")
		left << pairs[0].int()
		right << pairs.last().int()
	}

	mut count := map[int]int{}
	for num in left {
		count[num] = 0
	}

	for num in right {
		if num in left {
			count[num]++
		}
	}

	mut similar := 0
	for key, value in count {
		similar += key * value
	}

	println(similar)
}
