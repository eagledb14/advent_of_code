module main

import a
import b
import os

fn main() {
	input := os.read_file("input")!.split("\n\n")

	mut page_order := map[int][]int{}
	for line in input[0].split("\n") {
		params := line.split("|")
		page_order[params[0].int()] << params[1].int()
	}

	mut updates := [][]int{}
	for line in input[1].split("\n") {
		updates << line.split(",").map(it.int())
	}
	updates.pop()

	a.run(page_order, updates)
	b.run(page_order, updates)
}
