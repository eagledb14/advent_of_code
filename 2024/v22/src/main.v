module main

import os
// import a
import b

fn main() {
	input := os.read_file("input")!.split("\n").filter(it != "").map(it.u64())
	// a.run(input)
	b.run(input)
}
