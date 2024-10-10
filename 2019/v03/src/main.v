module main

import a
import b

import os

fn main() {
	lines := os.read_file("input")!.split("\n")

	a_route := lines[0].split(",");
	b_route := lines[1].split(",");

	b.run(a_route, b_route)
}


