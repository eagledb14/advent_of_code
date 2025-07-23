module main;

import os;
import math;

fn main() {

	lines := os.read_lines("input")!

	mut total := 0
	for line in lines {
		mut dimentions := line.split("x")
		mut d_int := dimentions.map(it.int())
		d_int.sort()
		a := d_int[0]
		b := d_int[1]

		ribbon := 2 * a + 2 * b
		bow := d_int[0] * d_int[1] * d_int[2]

		total += ribbon + bow
	}
	println(total)
}
