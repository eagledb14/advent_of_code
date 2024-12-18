module a

import math

pub fn run(input []string) {
	mut right := []int{}
	mut left := []int{}

	for lines in input {
		pairs := lines.split(" ")
		left << pairs[0].int()
		right << pairs.last().int()
	}
	left.sort()
	right.sort()

	mut distance := 0
	for i in 0 .. left.len {
		distance += math.abs(left[i] - right[i])
	}

	println(distance)
}
