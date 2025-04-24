module main

import os
import a
import b

fn main() {
	input := os.read_file("input")!.split("\n\n").map(it.split("\n").filter(it != ''))

	a.run(input)
	b.run(input)
}
