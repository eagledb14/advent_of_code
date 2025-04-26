module b

import arrays

pub fn run(input []int) {
	mut preamble := input[..25].clone()
	queue := input[25..].clone()

	invalid := find_invalid(preamble, queue)
	println(find_set(invalid, input) or {-12})
}

fn find_invalid(pre []int, queue []int) int {
	mut preamble := pre.clone()

	outer: for val in queue {
		// this checks if there is a valid combo, if there is then skip to the next number
		for i in 0..preamble.len {
			for j in i..preamble.len {
				if preamble[i] + preamble[j] == val {
					preamble = preamble[1..].clone()
					preamble << val
					continue outer
				}
			}
		}
		return val
	}

	return -1
}

fn find_set(invalid int, input []int) !int {
	mut sequence := []int{}

	outer: for i in 0..input.len {
		for j in i..input.len {
			sum := arrays.sum(input[i..j]) or {-1}
			if sum == invalid {
				sequence = input[i..j].clone()
				break outer
			}
		}
	}


	max := arrays.max(sequence)!
	min := arrays.min(sequence)!
	println("$invalid, $sequence, $max, $min")

	return max + min
}
