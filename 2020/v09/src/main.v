module main

import os
import a
import b

fn main() {
	input := os.read_file("input")!.split("\n").filter(it != "").map(it.int())
	// a.run(input)
	b.run(input)
}
