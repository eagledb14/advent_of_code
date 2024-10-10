module main

import a
import b

fn main() {
	input := "128392-643281"
	// input := "100-200"
	start := input.split("-")[0].int()
	end := input.split("-")[1].int()

	// a.run(start, end)
	b.run(start, end)
}
