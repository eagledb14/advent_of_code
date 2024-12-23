module main

import os
import a
import b

fn main() {
	mut input := os.read_file("input")!.split("\n")
	input.pop()
	// a.run(input)
	b.run(input)
}
