module b

pub fn run (input []u64) {
	mut out := map[u64]u64{}
	for stone in input {
		out[stone] += 1
	}

	for i in 0..75 {
		out = blink(out)
		println("$i -- ${calc_len(out)}")
	}

	println("\n${calc_len(out)} ----")
}

fn blink(input map[u64]u64) map[u64]u64 {
	mut out := map[u64]u64{}

	for key, count in input {
		vals := evaluate(key)

		for val in vals {
			out[val] += count
		}
	}

	return out
}

fn evaluate(stone u64) []u64 {
	mut buf := []u64{}

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

	return buf
}

fn calc_len(input map[u64]u64) u64 {
	mut out := u64(0)
	for _, count in input {
		out += count
	}
	return out
}
