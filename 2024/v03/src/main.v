module main

import a
import b
import os

fn main() {
	input := os.read_file("input")!
	// println(input)
	a.run(input)
	b.run(input)

}
