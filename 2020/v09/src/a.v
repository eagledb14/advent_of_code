module a

pub fn run(input []int) {
	mut preamble := input[..25].clone()
	queue := input[25..].clone()


	// println(find_non_valid(mut queue, input))
	println(find_invalid(mut preamble, queue))
}

fn find_invalid(mut preamble []int, queue []int) int {

	outer: for val in queue {
		// this checks if there is a valid combo, if there is then skip to the next number
		for i in 0..preamble.len {
			for j in i..preamble.len {
				// println(preamble[i] + preamble[j])
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
