module main

import a
import b
import os

fn main() {
	mut input := os.read_file("input")!.split(" ").map(it.u64())

	a.run(input)
	b.run(input)
}
