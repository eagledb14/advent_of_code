module main

import os

fn main() {
	mut input := os.read_file("input")!.split("\n").filter(it != "").map(it.int())
	b(input)
}

fn a(inp []int) {
	mut input := inp.clone()
	input << 0
	input.sort()
	input << input.last() + 3

	mut diff1 := 0
	mut diff3 := 0

	for i in 1..input.len {
		if input[i] - input[i - 1] == 1 {
			diff1++
		} else if input[i] - input[i - 1] == 3 {
			diff3++
		}
	}

	println("$diff1, $diff3, ${diff1 * diff3}")
}

fn b(inp []int) {
	mut input := inp.clone()
	input << 0
	input.sort()
	input << input.last() + 3

	mut memo := map[string]bool
	memo[input.str()] = true
	search(input, mut memo)

	println(memo.len)
}

fn search(input []int, mut memo map[string]bool) {

	for i in 1..input.len - 1 {
		mut new_input := input.clone()
		new_input.delete(i)

		if new_input.str() in memo {
			continue
		}

		if is_valid(new_input) {
			memo[new_input.str()] = true
			search(new_input, mut memo)
		}
	}
}

fn is_valid(input []int) bool {

	for i in 1..input.len {
		diff := input[i] - input[i - 1]
		if diff > 3 {
			return false
		}
	}

	return true
}
