module main

import a
import b
import os

fn main() {
	mut lines := os.read_file("input")!.split("\n")
	lines.pop()

	mut grid := [][]string{}
	for line in lines {
		grid << line.split("")
	}

	a.run(grid)
	b.run(grid)
}
