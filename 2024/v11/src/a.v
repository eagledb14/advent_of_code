module a

pub fn run (input []u64) {
	mut out := input.clone()

	for _ in 0..25 {
		out = blink(out)
	}
	println(out.len)
}

fn blink(input []u64) []u64 {
	mut buf := []u64{}
	for stone in input {

		if stone == 0 {
			buf << 1
		} else if stone.str().len % 2 == 0 {
			half := stone.str().len / 2

			left := stone.str()[..half]
			right := stone.str()[half..]

			buf << left.u64()
			buf << right.u64()

		} else {
			buf << stone * 2024
		}

	}
	return buf
}
