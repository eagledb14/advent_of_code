module main

import os
import a
import b

fn main() {
	mut lines := os.read_file("input")!.split("\n")
	lines.pop()
	a.run(lines)
	b.run(lines)
}

