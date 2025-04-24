module main

import os
import a
import b

fn main() {
	input := os.read_file("input")!.split("\n\n")

	patterns := input[0].split(", ").filter(it != "")
	towels := input[1].split("\n").filter(it != "")

	b.run(patterns, towels)

}
